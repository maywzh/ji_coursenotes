'''
Author       : maywzh
Date         : 2021-03-24 23:12:54
LastEditTime : 2021-03-25 01:58:04
LastEditors  : maywzh
Description  : 
FilePath     : /ji_coursenotes/2021spring/CSCI991/presentation/code/draw.py
symbol_custom_string_obkoro1: 
Copyright (c) 2017 maywzh.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
'''
import matplotlib.pyplot as plt
import numpy as np

# 这两行代码解决 plt 中文显示的问题
plt.rcParams['font.sans-serif'] = ['SimHei']
plt.rcParams['axes.unicode_minus'] = False

# 输入统计数据
waters = ('Accuracy', 'F1_macro', 'F1_micro')
model1 = [69.6, 75.3, 74.2]
model2 = [73.2, 77.1, 76.2]
model3 = [76.9, 80.1, 79.9]
model4 = [77.3, 80.9, 79.1]

bar_width = 0.5  # 条形宽度
index_1 = np.arange(len(waters))  # 男生条形图的横坐标
index_2 = index_1 + bar_width/4  # 女生条形图的横坐标
index_3 = index_2 + bar_width/4
index_4 = index_3 + bar_width/4
# 使用两次 bar 函数画出两组条形图
plt.bar(index_1, height=model1,
        width=bar_width/4, color='darkorange', label='NB')
plt.bar(index_2, height=model2,
        width=bar_width/4, color='tan', label='ML-KNN')
plt.bar(index_3, height=model3,
        width=bar_width/4, color='gold', label='CNN+BERT')
plt.bar(index_4, height=model4,
        width=bar_width/4, color='olive', label='Proposed')
plt.legend(bbox_to_anchor=(1,1), loc='center left')  # 显示图例
# 让横坐标轴刻度显示 waters 里的饮用水， index_male + bar_width/2 为横坐标轴刻度的位置
plt.xticks(index_2+bar_width/8, waters)
plt.ylabel('%')  # 纵坐标轴标题
plt.title('Model Performance')  # 图形标题

plt.show()
