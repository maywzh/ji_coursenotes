'''
Author       : maywzh
Date         : 2021-03-25 00:52:57
LastEditTime : 2021-03-25 01:36:07
LastEditors  : maywzh
Description  :
FilePath     : /ji_coursenotes/2021spring/CSCI991/presentation/code/subplog.py
symbol_custom_string_obkoro1:
Copyright (c) 2017 maywzh.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
'''
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

fig, ax = plt.subplots(2, 2)


# 输入统计数据
waters = ('Accuracy', 'F1_macro', 'F1_micro')
model1 = [69.6, 75.3, 74.2]
model2 = [73.2, 77.1, 76.2]
model3 = [76.9, 80.1, 79.9]
model4 = [77.3, 80.9, 79.1]

bar_width = 0.3  # 条形宽度
index_1 = np.arange(len(waters))  # 男生条形图的横坐标
index_2 = index_1 + bar_width/4  # 女生条形图的横坐标
index_3 = index_2 + bar_width/4
index_4 = index_3 + bar_width/4


ax[0][0].bar(index_1, height=model1,
             width=bar_width/4, color='darkorange', label='NB')
ax[0][0].bar(index_2, height=model2,
             width=bar_width/4, color='tan', label='ML-KNN')
ax[0][0].bar(index_3, height=model3,
             width=bar_width/4, color='gold', label='CNN+BERT')
ax[0][0].bar(index_4, height=model4,
             width=bar_width/4, color='olive', label='Proposed')


model1 = [67.2, 71.2, 72.1]
model2 = [69.1, 73.2, 72.3]
model3 = [72.3, 74.3, 74.4]
model4 = [73.1, 75.5, 75.7]


# 画第1个图：折线图
x = np.arange(1, 100)
# 画第2个图：散点图
ax[0][1].bar(index_1, height=model1,
             width=bar_width/4, color='darkorange', label='NB')
ax[0][1].bar(index_2, height=model2,
             width=bar_width/4, color='tan', label='ML-KNN')
ax[0][1].bar(index_3, height=model3,
             width=bar_width/4, color='gold', label='CNN+BERT')
ax[0][1].bar(index_4, height=model4,
             width=bar_width/4, color='olive', label='Proposed')
# 画第3个图：饼图
# ax[1][0].pie(x=[15, 30, 45, 10], labels=list('ABCD'),
# autopct = '%.0f', explode = [0, 0.05, 0, 0])
# 画第4个图：条形图
# ax[1][1].bar([20, 10, 30, 25, 15], [25, 15, 35, 30, 20], color = 'b')


fig.legend()  # 显示图例
# 让横坐标轴刻度显示 waters 里的饮用水， index_male + bar_width/2 为横坐标轴刻度的位置
plt.xticks(index_1 + bar_width/4, waters)
plt.ylabel('%')  # 纵坐标轴标题
plt.show()
