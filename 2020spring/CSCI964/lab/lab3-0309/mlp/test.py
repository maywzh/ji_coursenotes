import matplotlib.pyplot as plt
import numpy as np
import time
from math import *

plt.ion()  #开启interactive mode 成功的关键函数
plt.figure(1)
t = np.linspace(0, 20, 100)

for i in range(20):
    # plt.clf() # 清空画布上的所有内容。此处不能调用此函数，不然之前画出的轨迹，将会被清空。
    y = np.sin(t * i / 10.0)
    plt.plot(t, y)  # 一条轨迹
    plt.pause(0.01)
