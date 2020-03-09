import math
import random
from matplotlib import pyplot as plt
from keras.models import Sequential
from keras.layers.core import Dense
import numpy as np
import matplotlib.animation as animation
from PIL import Image


#定义kdd99数据预处理函数
def sample(low, up, num):
    data = []
    for i in range(num):
        #采样
        tmp = random.uniform(low, up)
        data.append(tmp)
    data.sort()
    return data


def func(x):
    y = []
    for i in range(len(x)):
        tmp = math.sin(x[i] - math.pi / 3)
        y.append(tmp)
    return y


def getfit(model, x):
    y = []
    for i in range(len(x)):
        tmp = model.predict([x[i]], 10)
        y.append(tmp[0][0])
    return y


def init():
    fpath = "E:/imgs/0.jpg"
    img = Image.open(fpath)
    plt.axis('off')  # 关掉坐标轴为 off
    return plt.imshow(img)


def update(i):
    fpath = "E:/imgs/" + str(i) + ".jpg"
    img = Image.open(fpath)
    plt.axis('off')  # 关掉坐标轴为 off
    return plt.imshow(img)


if __name__ == '__main__':
    low = 0
    up = 2 * math.pi
    x = np.linspace(low, up, 1000)
    y = func(x)

    # 数据采样
    #     x_sample = sample(low,up,20);
    x_sample = [
        0.09326442022999694, 0.5812590520508311, 1.040490143783586, 1.5504427746047338, 2.1589557183817036, 2.6235357787018407, 2.712578091093361,
        2.7379109336528167, 3.0339662651841186, 3.147676812083248, 3.58596337171837, 3.6621496731124314, 3.81130899864203, 3.833092859928872,
        4.396611340802901, 4.4481080339256875, 4.609657879057151, 5.399731063412583, 5.54299720786794, 5.764084730699906
    ]
    y_sample = func(x_sample)

    # 建立顺序神经网络层次模型
    model = Sequential()
    model.add(Dense(10, input_dim=1, init='uniform', activation='relu'))
    model.add(Dense(1, init='uniform', activation='tanh'))

    plt.ion()
    #开启interactive mode 成功的关键函数
    fig = plt.figure(1)

    for i in range(100):
        filepath = "E:/Model/weights-improvement-" + str(i + 1) + ".hdf5"
        model.load_weights(filepath)
        #测试数据
        x_new = np.linspace(low, up, 1000)
        y_new = getfit(model, x_new)
        # 显示数据
        plt.clf()
        plt.plot(x, y)
        plt.scatter(x_sample, y_sample)
        plt.plot(x_new, y_new)

        ffpath = "E:/imgs/" + str(i) + ".jpg"
        plt.savefig(ffpath)

        plt.pause(0.01)  # 暂停0.01秒

    ani = animation.FuncAnimation(plt.figure(2), update, range(100), init_func=init, interval=500)
    ani.save("E:/test.gif", writer='pillow')

    plt.ioff()  # 关闭交互模式
