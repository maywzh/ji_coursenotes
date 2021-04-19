'''
Author       : maywzh
Date         : 2021-04-19 17:13:17
LastEditTime : 2021-04-19 21:44:05
LastEditors  : maywzh
Description  : 
FilePath     : /ji_coursenotes/2021spring/CCNUMaster/exp/chapter4/DKT/dataloader.py
License      : 
Copyright (c) 2017 maywzh.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
'''
from DKTDataSet import DKTDataSet
from readdata import DataReader
import Constants as C
import torch.utils.data as Data
import torch
import sys
sys.path.append('../')


def getTrainLoader(train_data_path):
    handle = DataReader(train_data_path, C.MAX_STEP, C.NUM_OF_QUESTIONS)
    trainques, trainans = handle.getTrainData()
    dtrain = DKTDataSet(trainques, trainans)
    trainLoader = Data.DataLoader(
        dtrain, batch_size=C.BATCH_SIZE, shuffle=True)
    return trainLoader


def getTestLoader(test_data_path):
    handle = DataReader(test_data_path, C.MAX_STEP, C.NUM_OF_QUESTIONS)
    testques, testans = handle.getTestData()
    dtest = DKTDataSet(testques, testans)
    testLoader = Data.DataLoader(dtest, batch_size=C.BATCH_SIZE, shuffle=False)
    return testLoader


def getLoader(dataset):
    trainLoaders = []
    testLoaders = []
    if dataset == 'assist2009':
        trainLoader = getTrainLoader(C.Dpath + '/assist2009/builder_train.csv')
        trainLoaders.append(trainLoader)
        testLoader = getTestLoader(C.Dpath + '/assist2009/builder_test.csv')
        testLoaders.append(testLoader)
    elif dataset == 'assist2015':
        trainLoader = getTrainLoader(
            C.Dpath + '/assist2015/assist2015_train.txt')
        trainLoaders.append(trainLoader)
        testLoader = getTestLoader(C.Dpath + '/assist2015/assist2015_test.txt')
        testLoaders.append(testLoader)
    elif dataset == 'static2011':
        trainLoader = getTrainLoader(
            C.Dpath + '/statics2011/static2011_train.txt')
        trainLoaders.append(trainLoader)
        testLoader = getTestLoader(
            C.Dpath + '/statics2011/static2011_test.txt')
        testLoaders.append(testLoader)
    elif dataset == 'kddcup2010':
        trainLoader = getTrainLoader(
            C.Dpath + '/kddcup2010/kddcup2010_train.txt')
        trainLoaders.append(trainLoader)
        testLoader = getTestLoader(C.Dpath + '/kddcup2010/kddcup2010_test.txt')
        testLoaders.append(testLoader)
    elif dataset == 'assist2017':
        trainLoader = getTrainLoader(
            C.Dpath + '/assist2017/assist2017_train.txt')
        trainLoaders.append(trainLoader)
        testLoader = getTestLoader(C.Dpath + '/assist2017/assist2017_test.txt')
        testLoaders.append(testLoader)
    elif dataset == 'synthetic':
        trainLoader = getTrainLoader(
            C.Dpath + '/synthetic/synthetic_train_v0.txt')
        trainLoaders.append(trainLoader)
        testLoader = getTestLoader(
            C.Dpath + '/synthetic/synthetic_test_v0.txt')
        testLoaders.append(testLoader)
    return trainLoaders, testLoaders
