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


class mlp(object):
    def __init__(self, lr=0.1, mometum=0.5, lda=0.0, te=1e-5, epoch=100, size=None):
        self.learningRate = lr
        self.lambda_ = lda
        self.thresholdError = te
        self.maxEpoch = epoch
        self.size = size  # The number of neutron in every layer
        self.momentum = momentum
        self.Weights = []
        self.biases = []
        self.last_W = []
        self.last_b = []
        self.init()

    def init(self):
        #Initailize the Weight and Bias Matrix
        for i in range(len(self.size) - 1):
            self.Weights.append(np.mat(np.random.uniform(-0.5, 0.5, size=(self.size[i + 1], self.size[i]))))
            self.biases.append(np.mat(np.random.uniform(-0.5, 0.5, size=(self.size[i + 1], 1))))

    def forwardPropagation(self, item=None):
        a = [item]
        for wIndex in range(len(self.W)):
            a.append(sigmoid(self.W[wIndex] * a[-1] + self.b[wIndex]))
        return a

    def backPropagation(self, label=None, a=None):
        # print("backPropagation--------------------begin")
        delta = []
        delta.append(np.multiply((a[-1] - label), np.multiply(a[-1], (1.0 - a[-1]))))
        pass


if __name__ == "__main__":
    x, y = readData('../iris.txt', False, 4)
