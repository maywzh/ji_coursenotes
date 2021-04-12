'''
Author       : maywzh
Date         : 2021-04-10 00:19:58
LastEditTime : 2021-04-10 00:22:16
LastEditors  : maywzh
Description  : 
FilePath     : /ji_coursenotes/2021spring/CCNUMaster/exp/chapter4/utils/student.py
License      : 
Copyright (c) 2017 maywzh.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
'''
from sklearn import metrics


class Student(object):
    def __init__(self):
        self.exercises = []
        self.Mv = None

    def similar_with(self, B):
        return metrics.pairwise.cosine_similarity(self.Mv, B.Mv)
