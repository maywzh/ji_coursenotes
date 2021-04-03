'''
Author       : maywzh
Date         : 2021-04-02 02:01:19
LastEditTime : 2021-04-04 00:57:58
LastEditors  : maywzh
Description  : 
FilePath     : /ji_coursenotes/2021spring/CCNUMaster/exp/chapter2/Bert-BiLSTM-CRF-pytorch/bert.py
symbol_custom_string_obkoro1: 
Copyright (c) 2017 maywzh.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
'''
import numpy as np
import torch
from transformers import BertModel, BertConfig, BertTokenizer
from scipy.spatial.distance import cosine

from torch import nn

config_path = 'pretrained_model/chinese_wwm_ext_pytorch/bert_config.json'
model_path = 'pretrained_model/chinese_wwm_ext_pytorch/pytorch_model.bin'
vocab_path = 'pretrained_model/chinese_wwm_ext_pytorch/vocab.txt'

al_config_path = 'model/albert_tiny/bert_config.json'
al_model_path = 'model/albert_tiny/pytorch_model.bin'
al_vocab_path = 'model/albert_tiny/vocab.txt'


class BertTextNet(nn.Module):
    def __init__(self):
        """
        bert模型。
        """
        super(BertTextNet, self).__init__()
        modelConfig = BertConfig.from_pretrained(config_path)
        self.textExtractor = BertModel.from_pretrained(
            model_path, config=modelConfig)
        self.tokenizer = BertTokenizer.from_pretrained(vocab_path)

    def forward(self, tokens, segments, input_masks):
        output = self.textExtractor(tokens, token_type_ids=segments,
                                    attention_mask=input_masks)
        text_embeddings = output[0][:, 0, :]
        return text_embeddings


class BertSeqVec(object):
    def __init__(self, text_net):
        """
        接收一个bert或albert模型，对文本进行向量化。
        :param text_net: bert或albert模型实例。
        """
        self.text_net = text_net
        self.tokenizer = text_net.tokenizer

    def seq2vec(self, text):
        """
        对文本向量化。
        :param text:str，未分词的文本。
        :return:
        """
        text = "[CLS] {} [SEP]".format(text)
        tokens, segments, input_masks = [], [], []

        tokenized_text = self.tokenizer.tokenize(text)  # 用tokenizer对句子分词
        indexed_tokens = self.tokenizer.convert_tokens_to_ids(
            tokenized_text)  # 索引列表
        tokens.append(indexed_tokens)
        segments.append([0] * len(indexed_tokens))
        input_masks.append([1] * len(indexed_tokens))

        max_len = max([len(single) for single in tokens])  # 最大的句子长度

        for j in range(len(tokens)):
            padding = [0] * (max_len - len(tokens[j]))
            tokens[j] += padding
            segments[j] += padding
            input_masks[j] += padding
        tokens_tensor = torch.tensor(tokens)
        segments_tensors = torch.tensor(segments)
        input_masks_tensors = torch.tensor(input_masks)
        text_hashCodes = self.text_net(tokens_tensor, segments_tensors,
                                       input_masks_tensors)  # text_hashCodes是bert模型的文本特征
        return text_hashCodes[0].detach().numpy()


if __name__ == '__main__':
    texts = ["若“”为真命题，则下列命题一定为假命题的是（）A．B．C．D．答案D解析试题分析：由“”为真命题，知命题p与q至少有一个是真命题，因此与可能为真命题，排除A，B；当p与q都为真命题时，为真命题；与至少有一个假命题，所以为假命题，故选D．",
             "逻辑",
             "数学",
             "函数图像"
             ]
    last_vec = None
    distances = []
    text_net = BertTextNet()  # 选择一个文本向量化模型
    seq2vec = BertSeqVec(text_net)  # 将模型实例给向量化对象。
    for text in texts:
        vec = seq2vec.seq2vec(text)  # 向量化
        print(vec)
        if last_vec is None:
            last_vec = vec
        else:
            dis = cosine(vec, last_vec)
            distances.append(dis)
            last_vec = vec
    print(np.array(distances))
    print('done')
