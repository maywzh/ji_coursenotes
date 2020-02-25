import numpy as np 
import math
def sigmoid(x):
    s = 1 / (1 + np.exp(-x))
    return s
i = np.mat([1, 2])

w1 = np.mat([[3, 2], [1, 4]])

w2 = np.mat([[3, 5], [2, 1]])

b1 = np.mat([1, 1])

b2 = np.mat([1, 1])

h = sigmoid(i * w1 + b1)

y = sigmoid(h * w2 + b2)

print(h, y)