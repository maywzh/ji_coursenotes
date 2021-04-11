from sklearn.metrics import classification_report, confusion_matrix
import time
from torch._C import ParameterDict
from tqdm import tqdm
from torch.utils.data import TensorDataset, DataLoader, RandomSampler, SequentialSampler
from transformers import PreTrainedTokenizerFast
import torch.nn.functional as F
import torch.nn as nn
import torch
import seaborn as sns
import numpy as np
import pandas as pd
import re
from torch.nn import Parameter
import math
from matplotlib import pyplot as plt
from sklearn.metrics import *


train_df = pd.read_csv('./data/train.csv')
test_df = pd.read_csv('./data/test.csv')

dev_size = int(train_df.shape[0] * 0.10)

train_df_cpy = train_df[dev_size:]
dev_df_cpy = train_df[:dev_size]
test_df_cpy = test_df

max_length = 64
hidden_size = 128
tokenizer = None
batch_size = 32
n_epochs = 20
embed_size = 100
lr = 0.001
model_path = "BiLSTM.pt"
use_gpu = True
num_labels = 7

tokenizer = PreTrainedTokenizerFast.from_pretrained('hfl/chinese-bert-wwm')
tokenizer.add_special_tokens({'pad_token': '[PAD]'})
adj = torch.Tensor(np.identity(num_labels))


def prepare_set(dataset, max_length=max_length):
    """returns input_ids, input_masks, labels for set of data ready in BERT format"""
    global tokenizer

    input_ids = dataset
#     for i in tqdm(dataset):
#         input_ids.append(camel_case_split(i))
    tokenized = tokenizer.batch_encode_plus(input_ids, return_token_type_ids=False, return_attention_mask=False,
                                            pad_to_max_length=True, truncation=True, max_length=max_length)["input_ids"]
    return tokenized


print("preprocessing training data...")
X_train = prepare_set(train_df_cpy['exercise_text'].values.tolist())

print("preprocessing training data...")
X_dev = prepare_set(dev_df_cpy['exercise_text'].values.tolist())

print("preprocessing test data...")
# -1 labels mean that those lines were not used for the scoring

X_test = prepare_set(test_df['exercise_text'].values.tolist())

cols_target = train_df.columns[1:].tolist()

keywords = {
    "函数奇偶性": "奇函数偶函数奇偶",
    "三角函数": "正弦余弦三角函数",
    "逻辑与命题关系": "命题充分必要充要",
    "集合": "集合并集交集子集空集韦恩图",
    "导数": "导数切线极值单调递单调区间",
    "平面向量": "向量",
    "数列": "数列"
}

kcols_target = [keywords[k] for k in cols_target]


device = torch.device('cuda' if torch.cuda.is_available()
                      and use_gpu else 'cpu')

labels_pre = prepare_set(cols_target)

labels_bemb = torch.tensor(labels_pre, dtype=torch.long).to(device)
klabels_bemb = torch.tensor(prepare_set(
    kcols_target), dtype=torch.long).to(device)

y_train = train_df_cpy[cols_target].values  # 0,0,1,0,0,1,0
y_dev = dev_df_cpy[cols_target].values  # 0,0,1,0,0,1,0
y_test = test_df[cols_target].values  # 0,0,1,0,0,1,0


x_train_torch = torch.tensor(X_train, dtype=torch.long).to(
    device)  # bert(exercisetext)
x_dev_torch = torch.tensor(X_dev, dtype=torch.long).to(device)
x_test_torch = torch.tensor(X_test, dtype=torch.long).to(device)

# y_train_torch = torch.tensor(np.hstack([y_train, y_aux_train]), dtype=torch.float32).to(device)
y_train_torch = torch.tensor(y_train, dtype=torch.float).to(device)
y_dev_torch = torch.tensor(y_dev, dtype=torch.float).to(device)
# y_val_torch = torch.tensor(np.hstack([y_val, y_aux_val]), dtype=torch.float32).to(device)
y_test_torch = torch.tensor(y_test, dtype=torch.float).to(device)


train_data = TensorDataset(x_train_torch, y_train_torch)
train_sampler = RandomSampler(train_data)
train_dataloader = DataLoader(
    train_data, sampler=train_sampler, batch_size=batch_size)


# Create the DataLoader for dev set
dev_data = TensorDataset(x_dev_torch, y_dev_torch)
dev_sampler = RandomSampler(dev_data)
dev_dataloader = DataLoader(
    dev_data, sampler=dev_sampler, batch_size=batch_size)

# Create the DataLoader for dev set.
test_data = TensorDataset(x_test_torch, y_test_torch)
test_sampler = SequentialSampler(test_data)
test_dataloader = DataLoader(
    test_data, sampler=test_sampler, batch_size=batch_size)

adj = torch.Tensor(np.identity(num_labels))


class Attention(nn.Module):
    """a Single Attention Layer"""

    def __init__(self, feature_dim):
        super(Attention, self).__init__()

        self.supports_masking = True
        self.feature_dim = feature_dim
        weight = torch.zeros(feature_dim, 1)
        nn.init.xavier_uniform_(weight)
        self.weight = nn.Parameter(weight)

    def forward(self, x, step_dim, mask=None):
        feature_dim = self.feature_dim
        eij = torch.mm(
            x.contiguous().view(-1, feature_dim), self.weight
        ).view(-1, step_dim)
        eij = torch.tanh(eij)
        a = torch.exp(eij)
        if mask is not None:
            a = a * mask
        a = a / torch.sum(a, 1, keepdim=True) + 1e-10
        weighted_input = x * torch.unsqueeze(a, -1)
        return torch.sum(weighted_input, 1), torch.unsqueeze(a, -1)


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


class Model(nn.Module):
    def __init__(self, hidden_size, embed_size, max_features, num_classes, max_length, emb_labels):
        super().__init__()
        self.embedding = nn.Embedding(max_features, embed_size)

#         self.embedding_dropout = dropout.SpatialDropout(0.3)

        self.lstm1 = nn.LSTM(embed_size, hidden_size,
                             bidirectional=True, batch_first=True)

        self.lstm2 = nn.LSTM(hidden_size * 2, hidden_size,
                             bidirectional=True, batch_first=True)

        self.lstm_attention = Attention(hidden_size * 2)

        self.linear1 = nn.Linear(hidden_size * 6, hidden_size * 6)
        self.linear2 = nn.Linear(hidden_size * 6, hidden_size * 6)
        self.linear_out = nn.Linear(hidden_size * 6, 1)
        self.linear_aux_out = nn.Linear(hidden_size * 6, num_classes)
        self.predict = nn.Linear(num_classes, num_classes)
        self.gc1 = GraphConvolution(hidden_size * 6, hidden_size * 6)
        self.gc2 = GraphConvolution(hidden_size * 6, hidden_size * 6)
        self.relu = nn.LeakyReLU(0.2)
        self.emb_labels = emb_labels

    def forward(self, x, step_len):
        h_embedding = self.embedding(x)
#         print(f"h_embedding size : {h_embedding.shape}")
#         h_embedding = self.embedding_dropout(h_embedding)
        h_lstm1, _ = self.lstm1(h_embedding)
#         print(f"lstm1 size : {h_lstm1.shape}")
        h_lstm2, _ = self.lstm2(h_lstm1)
#         print(f"lstm2 size : {h_lstm2.shape}")
        # Attention layer
        h_lstm_atten, weights = self.lstm_attention(h_lstm2, max_length)
#         print(f"h_lstm , w sizes : {h_lstm_atten.shape}, {weights.shape}")
        # global average pooling
        avg_pool = torch.mean(h_lstm2, 1)
#         print(f"avg pool : {avg_pool.shape}")
        # global max pooling
        max_pool, _ = torch.max(h_lstm2, 1)
#         print(f"max pool : {max_pool.shape}")
        h_conc = torch.cat((h_lstm_atten, max_pool, avg_pool), 1)
#         print(f"h_conc : {h_conc.shape}")
        h_conc_linear1 = F.relu(self.linear1(h_conc))
#         print(f"h_conc_linear1 : {h_conc_linear1.shape}")
        h_conc_linear2 = F.relu(self.linear2(h_conc))
#         print(f"h_conc_linear2 : {h_conc_linear2.shape}")
        l_embedding = self.embedding(self.emb_labels)
#         print(f"h_embedding size : {h_embedding.shape}")
#         h_embedding = self.embedding_dropout(h_embedding)
        l_lstm1, _ = self.lstm1(l_embedding)
#         print(f"lstm1 size : {h_lstm1.shape}")
        l_lstm2, _ = self.lstm2(l_lstm1)
#         print(f"lstm2 size : {h_lstm2.shape}")
        # Attention layer
        l_lstm_atten, l_weights = self.lstm_attention(l_lstm2, max_length)
#         print(f"h_lstm , w sizes : {h_lstm_atten.shape}, {weights.shape}")
        # global average pooling
        l_avg_pool = torch.mean(l_lstm2, 1)
#         print(f"avg pool : {avg_pool.shape}")
        # global max pooling
        l_max_pool, _ = torch.max(l_lstm2, 1)
#         print(f"max pool : {max_pool.shape}")
        l_conc = torch.cat((l_lstm_atten, l_max_pool, l_avg_pool), 1)
#         print(f"h_conc : {h_conc.shape}")
        l_conc_linear1 = F.relu(self.linear1(l_conc))
#         print(f"h_conc_linear1 : {h_conc_linear1.shape}")
        l_conc_linear2 = F.relu(self.linear2(l_conc))
#         print(f"h_conc_linear2 : {h_conc_linear2.shape}")
        hidden = h_conc + h_conc_linear1 + h_conc_linear2
        l_hidden = l_conc + l_conc_linear1 + l_conc_linear2
        result = self.linear_out(hidden)
#         print(f"result : {result.shape}")
        #aux_result = self.linear_aux_out(hidden)
        norm_hidden = hidden / hidden.norm(dim=-1, keepdim=True)
        norm_lhidden = l_hidden / l_hidden.norm(dim=-1, keepdim=True)

        x = self.gc1(norm_lhidden, adj)
        x = self.relu(x)
        x = self.gc2(x, adj)

#         label_rep = self.graph(self.emb_labels)
        aux_result = torch.matmul(norm_hidden, x.transpose(0, 1))
#         print(f"aux_result : {aux_result.shape}")
#         out = torch.cat([result, aux_result], 1)
#         print(f"out : {out.shape}")
#         return out, weights
        #aux_result = F.leaky_relu(self.predict(aux_result))
        return aux_result, weights


def train_model(model, loss_fn, lr=0.001, batch_size=32, n_epochs=10, max_length=64):
    param_lrs = [{'params': param, 'lr': lr} for param in model.parameters()]
    optimizer = torch.optim.Adam(param_lrs, lr=lr)
    scheduler = torch.optim.lr_scheduler.LambdaLR(
        optimizer, lambda epoch: 0.6 ** epoch)

    training_loss = []
    validation_loss = []
    training_acc = []
    validation_acc = []
    best_loss = float("inf")

    for epoch in range(n_epochs):
        start_time = time.time()
        training_res = []
        validataion_res = []
        model.train()
        avg_loss = 0
        y_train_preds = []
        y_train_batchs = []
        y_valid_preds = []
        y_valid_batchs = []
        for data in tqdm(train_dataloader, disable=False):
            x_batch = data[:-1]
            y_batch = data[-1]
            y_batch_labels = y_batch.detach().cpu().numpy()
#             if y_trues.shape[0] == 1:
#                 y_trues = y_batch_labels
#             else:
#                 print(y_trues, y_batch_labels)
#                 y_trues = np.concatenate(y_trues, np.array(y_batch_labels))
            y_train_batchs += y_batch_labels.tolist()
            y_pred, _ = model(*x_batch, max_length)
            y_pred_labels = (torch.sigmoid(
                y_pred).detach().cpu().numpy() > 0.5)

#             if y_preds.shape[0] == 1:
#                 y_preds = y_pred_labels
#             else:
#                 y_preds = np.concatenate(y_preds, y_pred_labels)

            y_train_preds += y_pred_labels.tolist()
            loss = nn.BCEWithLogitsLoss()(y_pred, y_batch)
            optimizer.zero_grad()
            loss.backward()
            optimizer.step()
            avg_loss += loss.item() / len(train_dataloader)
        tacc = accuracy_score(y_train_batchs, y_train_preds)
        training_acc.append(tacc)
        training_loss.append(avg_loss)
        model.eval()
        print(f'... Validating ... ')
        avg_val_loss = 0
        for val_data in tqdm(dev_dataloader, disable=False):
            x_batch = val_data[:-1]
            y_batch = val_data[-1]
            y_batch_labels = y_batch.detach().cpu().numpy()
            y_valid_batchs += y_batch_labels.tolist()
#             if y_trues_v.shape[0] == 1:
#                 y_trues_v = y_batch_labels
#             else:
#                 y_trues_v = np.concatenate(y_trues_v, y_batch_labels)
            y_pred, _ = model(*x_batch, max_length)
            y_pred_labels = (torch.sigmoid(
                y_pred).detach().cpu().numpy() > 0.5)
            y_valid_preds += y_pred_labels.tolist()
#             if y_preds_v.shape[0] == 1:
#                 y_preds_v = y_pred_labels
#             else:
#                 y_preds_v = np.concatenate(y_preds_v, y_pred_labels)

            val_loss = nn.BCEWithLogitsLoss()(y_pred, y_batch)
            avg_val_loss += val_loss.item() / len(dev_dataloader)
        vacc = accuracy_score(y_valid_batchs, y_valid_preds)
        validation_acc.append(vacc)
        elapsed_time = time.time() - start_time
        validation_loss.append(avg_val_loss)
        if avg_val_loss < best_loss:
            print('saving the best model so far')
            best_loss = avg_val_loss
            torch.save(model.state_dict(), model_path)
        print(f'Epoch {epoch + 1}/{n_epochs}\t training_loss={avg_loss:.4f} \t validation_loss={avg_val_loss: 4f} \t train_epoch_acc={tacc: 4f} \t valid_epoch_acc={vacc: 4f} \t time={elapsed_time:.2f}s')
        scheduler.step()
    return training_loss, validation_loss, training_acc, validation_acc


def evaluate(model):
    # Create the DataLoader for dev set.
    model.eval()
    preds = np.zeros((1, num_labels))
    y_test_preds = []
    y_test_trues = []
    with torch.no_grad():
        for tst_data in tqdm(test_dataloader, disable=False):
            x_batch = tst_data[:-1]
            y_batch_labels = tst_data[-1].detach().cpu().numpy()
            y_test_trues += y_batch_labels.tolist()
            y_pred, _ = model(*x_batch, max_length)

            y_pred_labels = (torch.sigmoid(
                y_pred).detach().cpu().numpy() > 0.5)
            y_test_preds += y_pred_labels.tolist()
            correct_labels = (y_pred_labels == y_batch_labels)
            preds += correct_labels.sum(axis=0)

    return preds, y_test_preds, y_test_trues


model = Model(hidden_size=hidden_size,
              embed_size=embed_size,
              max_features=tokenizer.vocab_size,
              num_classes=num_labels,
              max_length=max_length, emb_labels=klabels_bemb)
model.to(device)
trainloss, vloss, training_acc, validation_acc = train_model(model=model, loss_fn=None, lr=lr, batch_size=batch_size,
                                                             n_epochs=n_epochs, max_length=max_length)

true_positives, y_test_preds, y_test_trues = evaluate(model)
for i, acc in enumerate((true_positives / test_df.shape[0])[0]):
    print(f"{cols_target[i]} accuracy is {acc*100:.2f}%")