'''
@Author: maywzh
@Date: 2020-03-21 14:14:43
@FilePath: /ji_coursenotes/2020spring/CSCI964/lab5-0323/src/kmeans.py
'''
import numpy as np
import random
import re
import matplotlib.pyplot as plt


def loadDataSet():
    dataSet = np.loadtxt("../data/iris.txt")
    return dataSet


def initCentroids(dataSet, k):
    dataSet = list(dataSet)
    return random.sample(dataSet, k)


def minifyDistance(dataSet, centroidList):
    clusterDict = dict()
    k = len(centroidList)
    