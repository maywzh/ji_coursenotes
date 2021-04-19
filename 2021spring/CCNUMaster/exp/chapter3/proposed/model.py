import torch
import torch.nn as nn
from memory import DKVMN, GKVMN
import numpy as np
import utils as utils


class MODEL(nn.Module):
    def __init__(self, n_question, batch_size, q_embed_dim, qa_embed_dim,
                 memory_size, memory_key_state_dim, memory_value_state_dim, final_fc_dim, student_num=None, gpu=-1):
        super(MODEL, self).__init__()
        self.n_question = n_question
        self.batch_size = batch_size
        self.q_embed_dim = q_embed_dim  # 问题emb维度d_k
        self.qa_embed_dim = qa_embed_dim  # 问题回答emb维度
        self.memory_size = memory_size  # 存储单元数 = 知识点数
        self.memory_key_state_dim = memory_key_state_dim  # 存储单元Key的维度
        self.memory_value_state_dim = memory_value_state_dim  # 存储单元Value的维度
        self.final_fc_dim = final_fc_dim  # 最终预测的维度 d_ft
        self.student_num = student_num  # 学生数
        self.gpu = gpu

        # 计算
        self.input_embed_linear = nn.Linear(
            self.q_embed_dim, self.final_fc_dim, bias=True)
        # 计算 f_t=W1(r_t, k_t)+b1
        self.read_embed_linear = nn.Linear(
            self.memory_value_state_dim + self.final_fc_dim, self.final_fc_dim, bias=True)
        # 计算 p_t=Sigmoid(W2f_t+b2)
        self.predict_linear = nn.Linear(
            self.final_fc_dim, 1, bias=True)
        # 初始化Key存储
        self.init_memory_key = nn.Parameter(torch.randn(
            self.memory_size, self.memory_key_state_dim))
        nn.init.kaiming_normal_(self.init_memory_key)
        # 初始化Value存储
        self.init_memory_value = nn.Parameter(torch.randn(
            self.memory_size, self.memory_value_state_dim))
        nn.init.kaiming_normal_(self.init_memory_value)
        # 写过程
        self.mem = DKVMN(memory_size=self.memory_size,
                         memory_key_state_dim=self.memory_key_state_dim,
                         memory_value_state_dim=self.memory_value_state_dim, init_memory_key=self.init_memory_key, gpu=self.gpu)
        #
        memory_value = nn.Parameter(torch.cat(
            [self.init_memory_value.unsqueeze(0) for _ in range(batch_size)], 0).data)
        self.mem.init_value_memory(memory_value)
        # embed 问题 : output Shape(self.q_embed_dim)
        self.q_embed = nn.Embedding(
            self.n_question + 1, self.q_embed_dim, padding_idx=0)
        # embed 问题与回答 : output Shape(self.qa_embed_dim)
        self.qa_embed = nn.Embedding(
            2 * self.n_question + 1, self.qa_embed_dim, padding_idx=0)

    def init_params(self):
        '''
        初始化参数权重矩阵
        '''
        nn.init.kaiming_normal_(self.predict_linear.weight)
        nn.init.kaiming_normal_(self.read_embed_linear.weight)
        nn.init.constant_(self.read_embed_linear.bias, 0)
        nn.init.constant_(self.predict_linear.bias, 0)
        # nn.init.constant(self.input_embed_linear.bias, 0)
        # nn.init.normal(self.input_embed_linear.weight, std=0.02)

    def init_embeddings(self):
        '''
        初始化embedding 向量
        '''
        nn.init.kaiming_normal_(self.q_embed.weight)
        nn.init.kaiming_normal_(self.qa_embed.weight)

    def forward(self, q_data, qa_data, target, student_id=None):
        # q_data : Shape (batch_size * seqlen)
        batch_size = q_data.shape[0]
        seqlen = q_data.shape[1]  # Q
        # embed 问题
        q_embed_data = self.q_embed(q_data)
        # embed 回答
        qa_embed_data = self.qa_embed(qa_data)
        # 初始化
        memory_value = nn.Parameter(torch.cat(
            [self.init_memory_value.unsqueeze(0) for _ in range(batch_size)], 0).data)
        self.mem.init_value_memory(memory_value)

        # q_data Shape : (batchsize * seqlen)
        slice_q_data = torch.chunk(q_data, seqlen, 1)  # batchsize x 1
        slice_q_embed_data = torch.chunk(
            q_embed_data, seqlen, 1)  # batchsize x 1
        slice_qa_embed_data = torch.chunk(
            qa_embed_data, seqlen, 1)  # batchsize x 1

        value_read_content_l = []
        input_embed_l = []
        predict_logs = []
        for i in range(seqlen):
            # Attention
            q = slice_q_embed_data[i].squeeze(1)
            correlation_weight = self.mem.attention(q)
            if_memory_write = slice_q_data[i].squeeze(1).ge(1)
            if_memory_write = utils.variable(
                torch.FloatTensor(if_memory_write.data.tolist()), self.gpu)

            # Read Process
            read_content = self.mem.read(correlation_weight)
            value_read_content_l.append(read_content)
            input_embed_l.append(q)
            # Write Process
            qa = slice_qa_embed_data[i].squeeze(1)
            new_memory_value = self.mem.write(
                correlation_weight, qa, if_memory_write)

            # read_content_embed = torch.tanh(self.read_embed_linear(torch.cat([read_content, q], 1)))
            # pred = self.predict_linear(read_content_embed)
            # predict_logs.append(pred)

        all_read_value_content = torch.cat(
            [value_read_content_l[i].unsqueeze(1) for i in range(seqlen)], 1)
        input_embed_content = torch.cat(
            [input_embed_l[i].unsqueeze(1) for i in range(seqlen)], 1)
        # input_embed_content = input_embed_content.view(batch_size * seqlen, -1)
        # input_embed_content = torch.tanh(self.input_embed_linear(input_embed_content))
        # input_embed_content = input_embed_content.view(batch_size, seqlen, -1)

        predict_input = torch.cat(
            [all_read_value_content, input_embed_content], 2)
        read_content_embed = torch.tanh(self.read_embed_linear(
            predict_input.view(batch_size*seqlen, -1)))

        pred = self.predict_linear(read_content_embed)
        # predicts = torch.cat([predict_logs[i] for i in range(seqlen)], 1)
        target_1d = target                   # [batch_size * seq_len, 1]
        mask = target_1d.ge(0)               # [batch_size * seq_len, 1]
        # pred_1d = predicts.view(-1, 1)           # [batch_size * seq_len, 1]
        pred_1d = pred.view(-1, 1)           # [batch_size * seq_len, 1]

        filtered_pred = torch.masked_select(pred_1d, mask)
        filtered_target = torch.masked_select(target_1d, mask)
        loss = torch.nn.functional.binary_cross_entropy_with_logits(
            filtered_pred, filtered_target)

        return loss, torch.sigmoid(filtered_pred), filtered_target

#


class MODEL_BH(nn.Module):
    def __init__(self, n_question, batch_size, q_embed_dim, qa_embed_dim,
                 memory_size, memory_key_state_dim, memory_value_state_dim, final_fc_dim, student_num=None, gpu=-1):
        super(MODEL_BH, self).__init__()
        self.n_question = n_question
        self.batch_size = batch_size
        self.q_embed_dim = q_embed_dim  # 问题emb维度d_k
        self.qa_embed_dim = qa_embed_dim  # 问题回答emb维度
        self.memory_size = memory_size  # 存储单元数 = 知识点数
        self.memory_key_state_dim = memory_key_state_dim  # 存储单元Key的维度
        self.memory_value_state_dim = memory_value_state_dim  # 存储单元Value的维度
        self.final_fc_dim = final_fc_dim  # 最终预测的维度 d_ft
        self.student_num = student_num  # 学生数
        self.gpu = gpu
        # 计算
        self.input_embed_linear = nn.Linear(
            self.q_embed_dim, self.final_fc_dim, bias=True)
        # 计算 f_t=W1(r_t, k_t, bh1_t, bh2_t, bh3_t)+b1

        self.read_embed_linear = nn.Linear(
            self.memory_value_state_dim + self.final_fc_dim + 1, self.final_fc_dim, bias=True)

        # 计算 p_t=Sigmoid(W2f_t+b2)
        self.predict_linear = nn.Linear(
            self.final_fc_dim, 1, bias=True)
        # 初始化Key存储
        self.init_memory_key = nn.Parameter(torch.randn(
            self.memory_size, self.memory_key_state_dim))
        nn.init.kaiming_normal_(self.init_memory_key)
        # 初始化Value存储
        self.init_memory_value = nn.Parameter(torch.randn(
            self.memory_size, self.memory_value_state_dim))
        nn.init.kaiming_normal_(self.init_memory_value)
        # 写过程
        self.mem = GKVMN(memory_size=self.memory_size,
                         memory_key_state_dim=self.memory_key_state_dim,
                         memory_value_state_dim=self.memory_value_state_dim, init_memory_key=self.init_memory_key, gpu=self.gpu)
        #
        memory_value = nn.Parameter(torch.cat(
            [self.init_memory_value.unsqueeze(0) for _ in range(batch_size)], 0).data)
        self.mem.init_value_memory(memory_value)
        # embed 问题 : output Shape(self.q_embed_dim)
        self.q_embed = nn.Embedding(
            self.n_question + 1, self.q_embed_dim, padding_idx=0)
        # embed 问题与回答 : output Shape(self.qa_embed_dim)
        self.qa_embed = nn.Embedding(
            2 * self.n_question + 1, self.qa_embed_dim, padding_idx=0)
        # self.encode_behavior_fc = nn.Linear(
        #     self.q_embed_dim+self.seqlen, self.q_embed_dim, bias=True)

    def init_params(self):
        '''
        初始化参数权重矩阵
        '''
        nn.init.kaiming_normal_(self.predict_linear.weight)
        nn.init.kaiming_normal_(self.read_embed_linear.weight)
        nn.init.constant_(self.read_embed_linear.bias, 0)
        nn.init.constant_(self.predict_linear.bias, 0)
        # nn.init.constant(self.input_embed_linear.bias, 0)
        # nn.init.normal(self.input_embed_linear.weight, std=0.02)

    def init_embeddings(self):
        '''
        初始化embedding 向量
        '''
        nn.init.kaiming_normal_(self.q_embed.weight)
        nn.init.kaiming_normal_(self.qa_embed.weight)

    def forward(self, q_data, qa_data, target, bh1_data, bh2_data, bh3_data, bh4_data, student_id=None):
        """
        q_data : batch_size * seqlen
        qa_data : batch_size * seqlen
        bhi_data : batch_size * seqlen

        """
        # q_data : Shape (batch_size * seqlen)
        batch_size = q_data.shape[0]
        seqlen = q_data.shape[1]  # Q
        # embed 问题

        # batch_size * seqlen * embedding_size
        q_embed_data = self.q_embed(q_data)
        # embed 回答
        # batch_size * seqlen * embedding_size
        qa_embed_data = self.qa_embed(qa_data)
        # 初始化
        memory_value = nn.Parameter(torch.cat(
            [self.init_memory_value.unsqueeze(0) for _ in range(batch_size)], 0).data)
        self.mem.init_value_memory(memory_value)

        # q_data Shape : (batchsize * seqlen)
        # seqlen个（batch_size * 1）
        slice_q_data = torch.chunk(q_data, seqlen, 1)
        # slice_bh1_data = torch.chunk(bh1_data, seqlen, 1)
        # slice_bh2_data = torch.chunk(bh2_data, seqlen, 1)
        # slice_bh3_data = torch.chunk(bh3_data, seqlen, 1)
        # seqlen个 batch_size *1 *emb_size
        slice_q_embed_data = torch.chunk(
            q_embed_data, seqlen, 1)  # seqlen个 batch_size *1 *emb_size
        slice_qa_embed_data = torch.chunk(
            qa_embed_data, seqlen, 1)  # seqlen个 batch_size *1 *emb_size

        value_read_content_l = []  # seqlen* batch_size * remb_size

        input_embed_l = []  # seqlen * batch_size * emb_size
        predict_logs = []
        # seqlen*batch_size*1

        input_bh1 = bh1_data.unsqueeze(2)

        input_bh2 = bh2_data.unsqueeze(2)

        input_bh3 = bh3_data.unsqueeze(2)

        input_bh4 = bh4_data.unsqueeze(2)
        # bh1_t1 = []
        # bh2_t1 = []
        # bh3_t1 = []
        for i in range(seqlen):
            # Attention
            q = slice_q_embed_data[i].squeeze(1)  # batch_size * emb_size
            # bh1 = slice_bh1_data[i]
            # bh2 = slice_bh2_data[i]
            # bh3 = slice_bh3_data[i]
            # bh1_t1.append(bh1)
            # bh2_t1.append(bh2)
            # bh3_t1.append(bh3)
            correlation_weight = self.mem.attention(q)
            if_memory_write = slice_q_data[i].squeeze(1).ge(1)
            if_memory_write = utils.variable(
                torch.FloatTensor(if_memory_write.data.tolist()), self.gpu)
            # Read Process
            read_content = self.mem.read(correlation_weight)
            value_read_content_l.append(read_content)
            input_embed_l.append(q)
            # Write Process
            qa = slice_qa_embed_data[i].squeeze(1)
            new_memory_value = self.mem.write(
                correlation_weight, qa, if_memory_write)
            # Graph Propagation
            #new_memory_value = self.mem.graph_propagation()
            # read_content_embed = torch.tanh(self.read_embed_linear(torch.cat([read_content, q], 1)))
            # pred = self.predict_linear(read_content_embed)
            # predict_logs.append(pred)
        # batch_size * seqlen * remb_size
        all_read_value_content = torch.cat(
            [value_read_content_l[i].unsqueeze(1) for i in range(seqlen)], 1)
        # batch_size * seqlen * emb_size
        input_embed_content = torch.cat(
            [input_embed_l[i].unsqueeze(1) for i in range(seqlen)], 1)
        # input_embed_content = input_embed_content.view(batch_size * seqlen, -1)
        # input_embed_content = torch.tanh(self.input_embed_linear(input_embed_content))
        # input_embed_content = input_embed_content.view(batch_size, seqlen, -1)

        predict_input = torch.cat(
            [all_read_value_content, input_embed_content, input_bh1], 2)

        read_content_embed = torch.tanh(self.read_embed_linear(
            predict_input.view(batch_size*seqlen, -1)))

        pred = self.predict_linear(read_content_embed)
        # predicts = torch.cat([predict_logs[i] for i in range(seqlen)], 1)
        target_1d = target                   # [batch_size * seq_len, 1]
        mask = target_1d.ge(0)               # [batch_size * seq_len, 1]
        # pred_1d = predicts.view(-1, 1)           # [batch_size * seq_len, 1]
        pred_1d = pred.view(-1, 1)           # [batch_size * seq_len, 1]

        filtered_pred = torch.masked_select(pred_1d, mask)
        filtered_target = torch.masked_select(target_1d, mask)
        loss = torch.nn.functional.binary_cross_entropy_with_logits(
            filtered_pred, filtered_target)

        return loss, torch.sigmoid(filtered_pred), filtered_target


class MODEL_GBH(nn.Module):
    def __init__(self, n_question, batch_size, q_embed_dim, qa_embed_dim,
                 memory_size, memory_key_state_dim, memory_value_state_dim, final_fc_dim, student_num=None, gpu=-1):
        super(MODEL_GBH, self).__init__()
        self.n_question = n_question
        self.batch_size = batch_size
        self.q_embed_dim = q_embed_dim  # 问题emb维度d_k
        self.qa_embed_dim = qa_embed_dim  # 问题回答emb维度
        self.memory_size = memory_size  # 存储单元数 = 知识点数
        self.memory_key_state_dim = memory_key_state_dim  # 存储单元Key的维度
        self.memory_value_state_dim = memory_value_state_dim  # 存储单元Value的维度
        self.final_fc_dim = final_fc_dim  # 最终预测的维度 d_ft
        self.student_num = student_num  # 学生数
        self.gpu = gpu
        # 计算
        self.input_embed_linear = nn.Linear(
            self.q_embed_dim, self.final_fc_dim, bias=True)
        # 计算 f_t=W1(r_t, k_t, bh1_t, bh2_t, bh3_t)+b1

        self.read_embed_linear = nn.Linear(
            self.memory_value_state_dim + self.final_fc_dim + 1, self.final_fc_dim, bias=True)

        # 计算 p_t=Sigmoid(W2f_t+b2)
        self.predict_linear = nn.Linear(
            self.final_fc_dim, 1, bias=True)
        # 初始化Key存储
        self.init_memory_key = nn.Parameter(torch.randn(
            self.memory_size, self.memory_key_state_dim))
        nn.init.kaiming_normal_(self.init_memory_key)
        # 初始化Value存储
        self.init_memory_value = nn.Parameter(torch.randn(
            self.memory_size, self.memory_value_state_dim))
        nn.init.kaiming_normal_(self.init_memory_value)
        # 写过程
        self.mem = GKVMN(memory_size=self.memory_size,
                         memory_key_state_dim=self.memory_key_state_dim,
                         memory_value_state_dim=self.memory_value_state_dim, init_memory_key=self.init_memory_key, gpu=self.gpu)
        #
        memory_value = nn.Parameter(torch.cat(
            [self.init_memory_value.unsqueeze(0) for _ in range(batch_size)], 0).data)
        self.mem.init_value_memory(memory_value)
        # embed 问题 : output Shape(self.q_embed_dim)
        self.q_embed = nn.Embedding(
            self.n_question + 1, self.q_embed_dim, padding_idx=0)
        # embed 问题与回答 : output Shape(self.qa_embed_dim)
        self.qa_embed = nn.Embedding(
            2 * self.n_question + 1, self.qa_embed_dim, padding_idx=0)
        # self.encode_behavior_fc = nn.Linear(
        #     self.q_embed_dim+self.seqlen, self.q_embed_dim, bias=True)

    def init_params(self):
        '''
        初始化参数权重矩阵
        '''
        nn.init.kaiming_normal_(self.predict_linear.weight)
        nn.init.kaiming_normal_(self.read_embed_linear.weight)
        nn.init.constant_(self.read_embed_linear.bias, 0)
        nn.init.constant_(self.predict_linear.bias, 0)
        # nn.init.constant(self.input_embed_linear.bias, 0)
        # nn.init.normal(self.input_embed_linear.weight, std=0.02)

    def init_embeddings(self):
        '''
        初始化embedding 向量
        '''
        nn.init.kaiming_normal_(self.q_embed.weight)
        nn.init.kaiming_normal_(self.qa_embed.weight)

    def forward(self, q_data, qa_data, target, bh1_data, bh2_data, bh3_data, bh4_data, student_id=None):
        """
        q_data : batch_size * seqlen
        qa_data : batch_size * seqlen
        bhi_data : batch_size * seqlen

        """
        # q_data : Shape (batch_size * seqlen)
        batch_size = q_data.shape[0]
        seqlen = q_data.shape[1]  # Q
        # embed 问题

        # batch_size * seqlen * embedding_size
        q_embed_data = self.q_embed(q_data)
        # embed 回答
        # batch_size * seqlen * embedding_size
        qa_embed_data = self.qa_embed(qa_data)
        # 初始化
        memory_value = nn.Parameter(torch.cat(
            [self.init_memory_value.unsqueeze(0) for _ in range(batch_size)], 0).data)
        self.mem.init_value_memory(memory_value)

        # q_data Shape : (batchsize * seqlen)
        # seqlen个（batch_size * 1）
        slice_q_data = torch.chunk(q_data, seqlen, 1)
        # slice_bh1_data = torch.chunk(bh1_data, seqlen, 1)
        # slice_bh2_data = torch.chunk(bh2_data, seqlen, 1)
        # slice_bh3_data = torch.chunk(bh3_data, seqlen, 1)
        # seqlen个 batch_size *1 *emb_size
        slice_q_embed_data = torch.chunk(
            q_embed_data, seqlen, 1)  # seqlen个 batch_size *1 *emb_size
        slice_qa_embed_data = torch.chunk(
            qa_embed_data, seqlen, 1)  # seqlen个 batch_size *1 *emb_size

        value_read_content_l = []  # seqlen* batch_size * remb_size

        input_embed_l = []  # seqlen * batch_size * emb_size
        predict_logs = []
        # seqlen*batch_size*1

        input_bh1 = bh1_data.unsqueeze(2)

        input_bh2 = bh2_data.unsqueeze(2)

        input_bh3 = bh3_data.unsqueeze(2)

        input_bh4 = bh4_data.unsqueeze(2)
        # bh1_t1 = []
        # bh2_t1 = []
        # bh3_t1 = []
        for i in range(seqlen):
            # Attention
            q = slice_q_embed_data[i].squeeze(1)  # batch_size * emb_size
            # bh1 = slice_bh1_data[i]
            # bh2 = slice_bh2_data[i]
            # bh3 = slice_bh3_data[i]
            # bh1_t1.append(bh1)
            # bh2_t1.append(bh2)
            # bh3_t1.append(bh3)
            correlation_weight = self.mem.attention(q)
            if_memory_write = slice_q_data[i].squeeze(1).ge(1)
            if_memory_write = utils.variable(
                torch.FloatTensor(if_memory_write.data.tolist()), self.gpu)
            # Read Process
            read_content = self.mem.read(correlation_weight)
            value_read_content_l.append(read_content)
            input_embed_l.append(q)
            # Write Process
            qa = slice_qa_embed_data[i].squeeze(1)
            new_memory_value = self.mem.write(
                correlation_weight, qa, if_memory_write)
            # Graph Propagation
            new_memory_value = self.mem.graph_propagation()
            # read_content_embed = torch.tanh(self.read_embed_linear(torch.cat([read_content, q], 1)))
            # pred = self.predict_linear(read_content_embed)
            # predict_logs.append(pred)
        # batch_size * seqlen * remb_size
        all_read_value_content = torch.cat(
            [value_read_content_l[i].unsqueeze(1) for i in range(seqlen)], 1)
        # batch_size * seqlen * emb_size
        input_embed_content = torch.cat(
            [input_embed_l[i].unsqueeze(1) for i in range(seqlen)], 1)
        # input_embed_content = input_embed_content.view(batch_size * seqlen, -1)
        # input_embed_content = torch.tanh(self.input_embed_linear(input_embed_content))
        # input_embed_content = input_embed_content.view(batch_size, seqlen, -1)

        predict_input = torch.cat(
            [all_read_value_content, input_embed_content, input_bh1], 2)

        read_content_embed = torch.tanh(self.read_embed_linear(
            predict_input.view(batch_size*seqlen, -1)))

        pred = self.predict_linear(read_content_embed)
        # predicts = torch.cat([predict_logs[i] for i in range(seqlen)], 1)
        target_1d = target                   # [batch_size * seq_len, 1]
        mask = target_1d.ge(0)               # [batch_size * seq_len, 1]
        # pred_1d = predicts.view(-1, 1)           # [batch_size * seq_len, 1]
        pred_1d = pred.view(-1, 1)           # [batch_size * seq_len, 1]

        filtered_pred = torch.masked_select(pred_1d, mask)
        filtered_target = torch.masked_select(target_1d, mask)
        loss = torch.nn.functional.binary_cross_entropy_with_logits(
            filtered_pred, filtered_target)

        return loss, torch.sigmoid(filtered_pred), filtered_target
