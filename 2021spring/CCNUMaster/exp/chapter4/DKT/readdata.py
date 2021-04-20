'''
Author       : maywzh
Date         : 2021-04-19 17:13:17
LastEditTime : 2021-04-19 21:53:35
LastEditors  : maywzh
Description  : 
FilePath     : /ji_coursenotes/2021spring/CCNUMaster/exp/chapter4/DKT/readdata.py
License      : 
Copyright (c) 2017 maywzh.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
'''
import numpy as np
import DKTDataSet
import itertools
import tqdm


class DataReader():
    def __init__(self, path, maxstep, numofques):
        self.path = path
        self.maxstep = maxstep
        self.numofques = numofques

    def getTrainData(self):
        trainqus = np.array([])
        trainans = np.array([])
        with open(self.path, 'r') as train:
            for len, ques, ans in tqdm.tqdm(itertools.zip_longest(*[train] * 3), desc='loading train data:    ', mininterval=2):
                len = int(len.strip().strip(','))
                ques = np.array(ques.strip().strip(
                    ',').split(',')).astype(np.int)
                ans = np.array(ans.strip().strip(
                    ',').split(',')).astype(np.int)
                mod = 0 if len % self.maxstep == 0 else (
                    self.maxstep - len % self.maxstep)
                zero = np.zeros(mod) - 1
                ques = np.append(ques, zero)
                ans = np.append(ans, zero)
                trainqus = np.append(trainqus, ques).astype(np.int)
                trainans = np.append(trainans, ans).astype(np.int)
        return trainqus.reshape([-1, self.maxstep]), trainans.reshape([-1, self.maxstep])

    def getTestData(self):
        testqus = np.array([])
        testans = np.array([])
        with open(self.path, 'r') as test:
            for len, ques, ans in tqdm.tqdm(itertools.zip_longest(*[test] * 3), desc='loading test data:    ', mininterval=2):
                len = int(len.strip().strip(','))
                ques = np.array(ques.strip().strip(',').split(',')).astype(int)
                ans = np.array(ans.strip().strip(',').split(',')).astype(int)
                mod = 0 if len % self.maxstep == 0 else (
                    self.maxstep - len % self.maxstep)
                zero = np.zeros(mod) - 1
                ques = np.append(ques, zero)
                ans = np.append(ans, zero)
                testqus = np.append(testqus, ques).astype(np.int)
                testans = np.append(testans, ans).astype(np.int)
        return testqus.reshape([-1, self.maxstep]), testans.reshape([-1, self.maxstep])
