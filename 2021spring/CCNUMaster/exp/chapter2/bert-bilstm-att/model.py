'''
Author       : maywzh
Date         : 2021-01-19 10:22:58
LastEditTime : 2021-04-07 18:27:59
LastEditors  : maywzh
Description  : 
FilePath     : /ji_coursenotes/2021spring/CCNUMaster/exp/chapter2/bert-bilstm-att/model.py
symbol_custom_string_obkoro1: 
Copyright (c) 2017 maywzh.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
'''
import torch
import torch.nn as nn
import torch.nn.functional as F
from bert import BertSeqVec, BertTextNet
import math


class Att_BiLSTM(nn.Module):
    def __init__(self, vocab_size, config, vec=None):
        super().__init__()
        self.hidden_dim = config['hidden_dim']
        self.batch_size = config['batch_size']
        self.emb_dim = config['emb_dim']
        self.gpu = config['gpu']
        self.embedding = BertSeqVec(BertTextNet())
        #self.embedding = nn.Embedding(vocab_size, config['emb_dim'])
        # if vec is not None:
        #     self.embedding.weight.data.copy_(vec) #load pretrained
        #     #self.embedding.weight.requires_grad = False #non-trainable
        self.bi_lstm = nn.LSTM(config['emb_dim'], config['hidden_dim'], num_layers=config['nlayers'],
                               bidirectional=config['bidir'], dropout=config['dropout'])
        self.fc = nn.Linear(config['hidden_dim'], config['out_dim'])
        self.dropout = nn.Dropout(config['dropout'])
        #self.hidden = nn.Parameters(self.batch_size, self.hidden_dim)

    def attention(self, encoder_out, final_hidden):
        hidden = final_hidden.squeeze(0)
        #M = torch.tanh(encoder_out)
        attn_weights = torch.bmm(encoder_out, hidden.unsqueeze(2)).squeeze(2)
        soft_attn_weights = F.softmax(attn_weights, 1)
        new_hidden = torch.bmm(encoder_out.transpose(
            1, 2), soft_attn_weights.unsqueeze(2)).squeeze(2)
        #print (wt.shape, new_hidden.shape)
        #new_hidden = torch.tanh(new_hidden)
        #print ('UP:', new_hidden, new_hidden.shape)

        return new_hidden

    def forward(self, sequence):
        emb_input = self.embedding.seq2vec(sequence)
        inputx = self.dropout(emb_input)
        output, (hn, cn) = self.bi_lstm(inputx)
        fbout = output[:, :, :self.hidden_dim] + \
            output[:, :, self.hidden_dim:]  # sum bidir outputs F+B
        fbout = fbout.permute(1, 0, 2)
        fbhn = (hn[-2, :, :]+hn[-1, :, :]).unsqueeze(0)
        #print (fbhn.shape, fbout.shape)
        attn_out = self.attention(fbout, fbhn)
        #attn1_out = self.attention1(output, hn)
        logits = self.fc(attn_out)
        return logits


class GraphConvolution(nn.Module):
    """
    Simple GCN layer, similar to https://arxiv.org/abs/1609.02907
    """

    def __init__(self, in_features, out_features, bias=False):
        super(GraphConvolution, self).__init__()
        self.in_features = in_features
        self.out_features = out_features
        self.weight = Parameter(torch.Tensor(in_features, out_features))
        if bias:
            self.bias = Parameter(torch.Tensor(1, 1, out_features))
        else:
            self.register_parameter('bias', None)
        self.reset_parameters()

    def reset_parameters(self):
        stdv = 1. / math.sqrt(self.weight.size(1))
        self.weight.data.uniform_(-stdv, stdv)
        if self.bias is not None:
            self.bias.data.uniform_(-stdv, stdv)

    def forward(self, input, adj):
        support = torch.matmul(input, self.weight)
        output = torch.matmul(adj, support)
        if self.bias is not None:
            return output + self.bias
        else:
            return output

    def __repr__(self):
        return self.__class__.__name__ + ' (' \
            + str(self.in_features) + ' -> ' \
            + str(self.out_features) + ')'


if __name__ == '__main__':
    txt = "数学习题"
    emb = BertSeqVec(BertTextNet())
    a = emb.Embed(txt)
    print(a, a[0].shape)
