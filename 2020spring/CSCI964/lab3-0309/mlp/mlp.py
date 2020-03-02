import numpy as np
import random
import matplotlib.pyplot as plt


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
        self.W = []
        self.b = []
        self.last_W = []
        self.last_b = []
        self.init()

    def init(self):
        #Initailize the Weight and Bias Matrix
        for i in range(len(self.size) - 1):
            self.W.append(np.mat(np.random.uniform(-0.5, 0.5, size=(self.size[i + 1], self.size[i]))))
            self.b.append(np.mat(np.random.uniform(-0.5, 0.5, size=(self.size[i + 1], 1))))

    def forwardPropagation(self, item=None):
        a = [item]
        for wIndex in range(len(self.W)):
            a.append(sigmoid(self.W[wIndex] * a[-1] + self.b[wIndex]))
        return a

    def backPropagation(self, label=None, a=None):
        # print("backPropagation--------------------begin")
        delta = []
        # Output layer's gradient of out value
        delta.append(np.multiply((a[-1] - label), np.multiply(a[-1], (1.0 - a[-1]))))
        for i in range(len(self.W) - 1):
            pd_ol = np.multiply(a[-2 - i], 1 - a[-2 - i])  # output layer partial derivative of sigmoid
            delta_hl = np.multiply(self.W[-1 - i].T * delta[-1], pd_ol)  # Hidden layer's delta before sigmoid
            delta.append(delta_hl)
        # if no W => the first bp, no last momentum.
        if not len(self.last_W):
            for i in range(self.size - 1):
                self.last_w.append(np.mat(np.zeros_like(self.W[i])))
                self.last_b.append(np.mat(np.zeros_like(self.b[i])))
            # Update the Weights
            for j in range(len(delta)):
                # The delta of the relative layer biases
                ads = delta[j] * a[-2 - j].T
                self.W[-1 - j] = self.W[-1 - j] - self.learningRate * (ads + self.lambda_ * self.W[-1 - j])  #W-lr*delta_W
                self.b[-1 - j] = self.b[-1 - j] - self.learningRate * delta[j]  #b-lr*delta_b
                self.last_W[-1 - j] = -self.learningRate * (ads + self.lambda_ * self.W[-1 - j])  # Record the direction of the update to add momentum
                self.last_b[-1 - j] = -self.learningRate * delta[j]
        else:
            for j in range(len(delta)):
                ads = delta[j] * a[-2 - j].T
                self.W[-1 - j] = self.W[-1 - j] - self.learningRate * (ads + self.lambda_ * self.W[-1 - j]) + self.momentum * self.last_W[-1 - j]
                self.b[-1 - j] = self.b[-1 - j] - self.learningRate * delta[j] + self.momentum * self.last_b[-1 - j]
                self.last_W[-1 - j] = -self.learningRate * (ads + self.lambda_ * self.W[-1 - j]) + self.momentum * self.last_W[-1 - j]
                self.last_b[-1 - j] = -self.learningRate * delta[j] + self.momentum * self.last_b[-1 - j]
        error = sum(0.5 * np.multiply(a[-1] - label, a[-1] - label))  #L2 loss
        return error

    def train(self, input_=None, target=None, show=10):
        plt.ion()
        plt.figure(1)
        plt.xlabel('epoch')
        plt.ylabel('loss')
        plt.grid(True)
        plt.title('epoch-loss')
        for ep in range(self.maxEpoch):
            error = []
            for itemIndex in range(input_.shape[1]):
                a = self.forwardPropagation(input_[:, itemIndex])
                e = self.backPropagation(target[:, itemIndex], a)
                error.append(e[0, 0])
            epoch_error = sum(error) / len(error)

            plt.scatter(ep, epoch_error)
            plt.draw()

            if epoch_error < self.thresholdError:
                print("Finish {0}: ".format(ep) % epoch_error)
                return
            elif ep % show == 0:
                print("epoch {0}: ".format(ep) % epoch_error)

    def sim(self, inp=None):
        return self.forwardPropagation(item=inp)[-1]


if __name__ == "__main__":
    x, y = readData('../iris.txt', False, 4)
    print(len(y[0]))
    #model = mlp(lr=0.1, momentum=0.5, lda=0.0, te=1e-5, epoch=1000, size=[len(x), 5, len(y)])
