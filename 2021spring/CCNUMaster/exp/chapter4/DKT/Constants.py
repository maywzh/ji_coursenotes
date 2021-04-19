'''
Author       : maywzh
Date         : 2021-04-19 17:13:17
LastEditTime : 2021-04-19 20:47:04
LastEditors  : maywzh
Description  : 
FilePath     : /ji_coursenotes/2021spring/CCNUMaster/exp/chapter4/DeepKnowledgeTracing-DKT-Pytorch-master/DKT/KnowledgeTracing/Constant/Constants.py
License      : 
Copyright (c) 2017 maywzh.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
'''
Dpath = './data'

datasets = {
    'assist2009': 'assist2009',
    'assist2015': 'assist2015',
    'assist2017': 'assist2017',
    'static2011': 'static2011',
    'kddcup2010': 'kddcup2010',
    'synthetic': 'synthetic'
}

# question number of each dataset
numbers = {
    'assist2009': 124,
    'assist2015': 100,
    'assist2017': 102,
    'static2011': 1224,
    'kddcup2010': 661,
    'synthetic': 50
}

DATASET = datasets['static2011']
NUM_OF_QUESTIONS = numbers['static2011']
# the max step of RNN model
MAX_STEP = 50
BATCH_SIZE = 64
LR = 0.002
EPOCH = 1000
# input dimension
INPUT = NUM_OF_QUESTIONS * 2
# embedding dimension
EMBED = NUM_OF_QUESTIONS
# hidden layer dimension
HIDDEN = 200
# nums of hidden layers
LAYERS = 1
# output dimension
OUTPUT = NUM_OF_QUESTIONS
