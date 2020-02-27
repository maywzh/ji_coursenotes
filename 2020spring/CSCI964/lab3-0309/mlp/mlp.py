import numpy as np
import random


def sigmoid(x):
    return 1.0 / (1.0 + np.exp(-x))


def numToVector(x, label_num):
    result = np.empty((1, label_num))
    result[x] = 1
    return result


def readData(filepath, ifShuffle, feature_num=4):
    label_dict = {}
    xs = []
    ys = []
    ynums = []
    label_num = 0
    with open(filepath) as f:
        lines = f.readlines()
        if ifShuffle:
            random.shuffle(lines)
        for line in lines:
            xs.append(np.array(line.split(',')[0:feature_num]))
            label_str = line.split(',')[-1].strip('\n')
            if not label_str in label_dict.keys():
                label_num += 1
                label_dict[label_str] = label_num
            ynums.append(label_dict[label_str])
        for ynum in ynums:
            y = np.zeros((1, label_num))
            y[0][ynum - 1] = 1
            ys.append(y)
    return xs, ys


x, y = readData('../iris.txt', False, 4)
