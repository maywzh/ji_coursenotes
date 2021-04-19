'''
Author       : maywzh
Date         : 2021-04-05 22:28:39
LastEditTime : 2021-04-09 07:55:25
LastEditors  : maywzh
Description  : 
FilePath     : /ji_coursenotes/2021spring/CCNUMaster/exp/chapter3/gkvmn/draw.py
symbol_custom_string_obkoro1: 
Copyright (c) 2017 maywzh.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
'''
import seaborn as sns
import numpy as np
from numpy.linalg import cholesky
import matplotlib.pyplot as plt
import pandas as pd
import re
file_name = './train.txt'
ls = []
loss = []
auc = []
acc = []
vauc = []
vacc = []
with open(file_name) as f:
    ls = f.readlines()
cnt = 0
for l in ls:
    matloss = re.search('loss : ', l)
    matvalid = re.search('valid auc : ', l)
    if matloss:
        start = matloss.span()[1]
        #print(l[start:start+7], l[start+15:start+22], l[start+35:start+42])
        loss.append(float(l[start:start+7]))
        auc.append(float(l[start+15:start+22]))
        acc.append(float(l[start+35:start+42]))
        cnt += 1
    if matvalid:
        start = matvalid.span()[1]
        vauc.append(float(l[start:start+7]))
        vacc.append(float(l[start+26:start+33]))
    # if mat:
    # print(l[mat[1]:])
a, b = np.array(vauc[150:]).max(), np.array(vauc[150:]).min()
print(a, b, (a+b)/2, (a-b)/2)

plt.figure(dpi=300)
#plt.plot(range(200), loss, label="training loss")
plt.plot(range(200), auc, label="training AUC")
plt.plot(range(200), acc, label="training accuracy")
plt.plot(range(200), vauc, label="validate AUC")
plt.plot(range(200), vacc, label="validate accuracy")
#plt.title("Training Process")
plt.xlabel("Epoch")
plt.ylabel("")
plt.legend()
plt.show()
