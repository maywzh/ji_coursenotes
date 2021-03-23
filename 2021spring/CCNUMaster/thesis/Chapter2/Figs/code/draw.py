'''
Author       : maywzh
Date         : 2021-02-20 01:50:33
LastEditTime : 2021-02-20 02:11:43
LastEditors  : maywzh
Description  : 
FilePath     : /ji_coursenotes/2021spring/CSCI991/thesis/Chapter2/Figs/code/draw.py

Copyright (c) 2017 maywzh.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
'''
import matplotlib.pyplot as plt

plt.figure(figsize=(6, 9))  # 调节图形大小
# plt.rcParams['font.sans-serif']=['SimHei'] #用来正常显示中文标签
# plt.rcParams['axes.unicode_minus']=False #用来正常显示负号
labels = ['1 KP', '2 KP',
          '3 KP', '4+ KP']  # 定义标签
sizes = [1543, 1235, 474, 69]  # 每块值
colors = ['red', 'yellowgreen', 'lightskyblue', 'yellow']  # 每块颜色定义
explode = (0, 0, 0, 0)  # 将某一块分割出来，值越大分割出的间隙越大
patches, text1, text2 = plt.pie(sizes,
                                explode=explode,
                                labels=labels,
                                colors=colors,
                                autopct='%3.2f%%',  # 数值保留固定小数位
                                shadow=False,  # 无阴影设置
                                startangle=90,  # 逆时针起始角度设置
                                pctdistance=0.6)  # 数值距圆心半径倍数的距离
# patches饼图的返回值，texts1饼图外label的文本，texts2饼图内部的文本
# x，y轴刻度设置一致，保证饼图为圆形
plt.axis('equal')
# plt.bar(range(len(labels)), sizes, color='rgb', tick_label=labels)
# plt.xlabel("The number of knowledge points")
# plt.ylabel("The number of exercise")
plt.show()
print((1543+1235*2+474*3+69*4.3)/3374)
