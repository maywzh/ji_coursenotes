'''
Author       : maywzh
Date         : 2021-04-19 17:13:17
LastEditTime : 2021-04-19 21:42:36
LastEditors  : maywzh
Description  : 
FilePath     : /ji_coursenotes/2021spring/CCNUMaster/exp/chapter4/DKT/run.py
License      : 
Copyright (c) 2017 maywzh.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
'''
import eval
import torch.optim as optim
import Constants as C
from dataloader import getTrainLoader, getTestLoader, getLoader
from RNNModel import DKT
import sys
sys.path.append('../')

print('Dataset: ' + C.DATASET + ', Learning Rate: ' + str(C.LR) + '\n')

model = DKT(C.INPUT, C.HIDDEN, C.LAYERS, C.OUTPUT)
optimizer_adam = optim.Adam(model.parameters(), lr=C.LR)
optimizer_adgd = optim.Adagrad(model.parameters(), lr=C.LR)

loss_func = eval.lossFunc()

trainLoaders, testLoaders = getLoader(C.DATASET)

for epoch in range(C.EPOCH):
    print('epoch: ' + str(epoch))
    model, optimizer = eval.train(
        trainLoaders, model, optimizer_adgd, loss_func)
    eval.test(testLoaders, model)
