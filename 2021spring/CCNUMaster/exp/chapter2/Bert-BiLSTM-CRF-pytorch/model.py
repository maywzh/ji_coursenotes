'''
Author       : maywzh
Date         : 2021-04-01 09:57:38
LastEditTime : 2021-04-02 00:53:13
LastEditors  : maywzh
Description  : 
FilePath     : /ji_coursenotes/2021spring/CCNUMaster/exp/chapter2/Bert-BiLSTM-CRF-pytorch-master/model.py
symbol_custom_string_obkoro1: 
Copyright (c) 2017 maywzh.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
'''
import torch
import torch.nn as nn
from utils import tag2idx, idx2tag
from pytorch_pretrained_bert import BertModel
from transformers import BertTokenizer


class Net(nn.Module):
    def __init__(self, top_rnns=False, vocab_size=None, device='cpu', finetuning=False, bertpath="./pretrained_model/chinese_wwm_ext_L-12_H-768_A-12"):
        super().__init__()
        self.bert = BertModel.from_pretrained(bertpath)

        self.top_rnns = top_rnns
        if top_rnns:
            self.rnn = nn.LSTM(bidirectional=True, num_layers=2, input_size=768,
                               hidden_size=768//2, batch_first=True)  # [128, 74, 768]
        self.fc = nn.Linear(768, vocab_size)

        self.device = device
        self.finetuning = finetuning
        # self.bert.to(self.device)

    def forward(self, x, y, ):
        '''
        x: (N, T). int64
        y: (N, T). int64

        Returns
        enc: (N, T, VOCAB)
        '''
        x = x.to(self.device)  # [128, 74]
        y = y.to(self.device)

        if self.training and self.finetuning:
            # print("->bert.train()")
            self.bert.train()
            encoded_layers, _ = self.bert(x)
            enc = encoded_layers[-1]
        else:
            self.bert.eval()
            with torch.no_grad():
                encoded_layers, _ = self.bert(x)
                enc = encoded_layers[-1]  # [128, 74, 768]

        if self.top_rnns:
            enc, _ = self.rnn(enc)  # [128, 74, 768]
        logits = self.fc(enc)  # [128, 74, 10]
        y_hat = logits.argmax(-1)  # [128, 74]
        return logits, y, y_hat


tokenizer = BertTokenizer.from_pretrained("BERT-wwm-ext")
model = BertModel.from_pretrained("BERT-wwm-ext")
