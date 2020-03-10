import numpy as np
import pandas as pd
import random
import libsvm.commonutil as commonutil
import libsvm.svmutil as svmutil

# def readData(filepath, ifShuffle, feature_num=4):
#     label_dict = {}
#     xs = []
#     ys = []
#     ynums = []
#     label_num = 0
#     with open(filepath) as f:
#         lines = f.readlines()
#         if ifShuffle:
#             random.shuffle(lines)
#         for line in lines:
#             x = list(map(float, line.split(',')[0:feature_num]))
#             xs.append(np.array(x).reshape(feature_num, 1))
#             label_str = line.strip('\n').split(',')[-1]
#             if not label_str in list(label_dict.keys()):
#                 label_num += 1
#                 label_dict[label_str] = label_num
#             ynums.append(label_dict[label_str])
#         for ynum in ynums:
#             y = np.zeros(label_num)
#             y[ynum - 1] = 1.0
#             ys.append(y.reshape(label_num, 1))
#     return xs, ys
