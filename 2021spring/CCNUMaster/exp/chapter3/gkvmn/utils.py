'''
Author       : maywzh
Date         : 2021-03-29 00:22:40
LastEditTime : 2021-04-04 02:52:43
LastEditors  : maywzh
Description  : 
FilePath     : /ji_coursenotes/2021spring/CCNUMaster/exp/chapter3/pytorch_dkvmn-master/utils.py
symbol_custom_string_obkoro1: 
Copyright (c) 2017 maywzh.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
'''
import json

import torch.nn.init


def variable(tensor, gpu):
    '''
    返回一个可训练的参数
    输入 tensor
    输出 tensor.Variable
    '''
    if gpu >= 0:
        return torch.autograd.Variable(tensor).cuda()
    else:
        return torch.autograd.Variable(tensor)


def to_scalar(var: torch.Tensor):
    '''
    转换为标量 取第一个
    输入 
    '''
    return var.view(-1).data.tolist()[0]


def save_checkpoint(state, track_list, filename):
    '''
    保存模型
    '''
    with open(filename + '.json', 'w') as f:
        json.dump(track_list, f)
    torch.save(state, filename + '.model')


def adjust_learning_rate(optimizer, lr):
    '''
    调整学习率
    '''
    for param_group in optimizer.param_groups:
        param_group['lr'] = lr
