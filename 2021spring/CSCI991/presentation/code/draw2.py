'''
Author       : maywzh
Date         : 2021-03-25 02:00:22
LastEditTime : 2021-03-25 11:56:20
LastEditors  : maywzh
Description  : 
FilePath     : /ji_coursenotes/2021spring/CSCI991/presentation/code/draw2.py
symbol_custom_string_obkoro1: 
Copyright (c) 2017 maywzh.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
'''
import numpy as np
import matplotlib.pyplot as plt

def auto_text(rects):
    for rect in rects:
        ax.text(rect.get_x(), rect.get_height(), rect.get_height(), ha='left', va='bottom')


size = 3
waters = ('Accuracy', 'F1_macro', 'F1_micro')

model1 = [69.6, 75.3, 74.2]
model2 = [73.2, 77.1, 76.2]
model3 = [76.9, 80.1, 79.9]
model4 = [77.3, 80.9, 79.1]
total_width, n =1, 4
width = total_width / 5
x = np.arange(size)

plt.bar(x, model1,  width=width, label='a',color='darkorange')
plt.bar(x + width, model2, width=width, label='b',color='tan')
plt.bar(x + 2 * width, model3, width=width, label='c',color='gold')
plt.bar(x + 3 * width, model4, width=width, label='d',color='olive')
plt.xticks(x+1.5*width, waters)
plt.legend(loc='upper right')
plt.ylabel('%')  # 纵坐标轴标题
plt.ylim(ymax=110)
plt.yticks(np.arange(0,101,10))
plt.title('Model Performance(τ=200)')  # 图形标

plt.show()