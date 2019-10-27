#!/usr/bin/env python

# Name : Wangzhihui Mei
# Number: 6603385(uow) / 2019124044(ccnu)
# Time: Oct. 20, 2019
# Site: https://github.com/maywzh

from math import log
import operator
from collections import Counter


def readDataset(filepath):
    """
    Read dataset from data.txt
    """
    datalist = []
    featurelist = []
    with open(filepath) as f:
        features = f.readline()
        featurelist = features.split()
        datalines = f.readlines()
        for dataline in datalines:
            datalist.append(dataline.split())
    return featurelist, datalist

def splitDataset(dataSet, t, v):
    """
    Dataset Classfication
    """
    retDataSet = []
    for featVec in dataSet:
        if featVec[t] == v:
            reducedFeatVec = featVec[:t]
            # The operation of these two steps does not include the divided feature attribute
            reducedFeatVec.extend(featVec[t + 1:])
            retDataSet.append(reducedFeatVec)

    return retDataSet

def getEntropy(dataSet):
    """
    calculate Entropy for dataset
    """
    dataSetSize = len(dataSet)
    if dataSetSize <= 1:
        return 0
    counts = Counter()
    for data in dataSet:
        counts[data[-1]] += 1
    probs = [float(c) / dataSetSize for c in counts.values()]
    ent = 0
    for p in probs:
        if p > 0.:
            ent -= p * log(p, 2)
    return ent

def majorityCnt(classList):
    """
    Sort by category quantity after classification
    """
    classCount = {}
    for vote in classList:
        if vote not in classCount.keys():
            classCount[vote] = 0
        classCount[vote] += 1
    sortedClassCount = sorted(
        classCount.items(), key=operator.itemgetter(1), reverse=True)
    print(sortedClassCount)
    return sortedClassCount[0][0]

# Build decision tree (ID3 decision tree)


def createTree(dataSet, labels):
    classList = [example[-1] for example in dataSet]
    # Return the same category in the final leaf node
    if classList.count(classList[0]) == len(classList):
        return ' ('+classList[0]+')'
    if len(dataSet[0]) == 1:
        return ' ('+majorityCnt(classList)+')'
    # Index for selecting the best feature
    bestFeat = chooseBestFeatureToSplit(dataSet)
    bestFeatLabel = labels[bestFeat]
    rs = ''
    # The classification results are saved in the form of dictionaries
    myTree = {bestFeatLabel: {}}
    del (labels[bestFeat])
    featValues = [example[bestFeat] for example in dataSet]
    Uvals = set(featValues)
    for value in Uvals:
        rs1 = '('+str(bestFeatLabel)+' '+str(value)
        subLabels = labels[:]
        rs1 = rs1+createTree(splitDataset(dataSet, bestFeat, value), subLabels)
        rs = rs+rs1+')'
    return rs
# Choose the best classification feature


def chooseBestFeatureToSplit(dataSet):
    numFeatures = len(dataSet[0]) - 1          # Number of features obtained
    BasedEntropy = getEntropy(dataSet)     # Primitive information entropy
    BestInfoGain = 0
    BestFeatures = -1
    for i in range(numFeatures):              # Ergodic two features
        featList = [example[i] for example in dataSet]
        uniqueVals = set(featList)            # Introduction set
        NewEntropy = 0

        for value in uniqueVals:
            # Data set classified according to a feature
            subDataSet = splitDataset(dataSet, i, value)
            prob = len(subDataSet) / float(len(dataSet))
            # Conditional empirical entropy after feature classification
            NewEntropy += prob * getEntropy(subDataSet)
        # The difference between the original entropy and the entropy classified according to the feature is the information gain divided according to the feature.
        INFOGain = BasedEntropy - NewEntropy
        # If the entropy decreases the most after a feature is divided, then the sub feature is the optimal classification feature.
        if (INFOGain > BestInfoGain):
            bestInfoGain = INFOGain
            BestFeatures = i
    # The index of the optimal feature is returned
    return BestFeatures


if __name__ == '__main__':
    labels, dataSet = readDataset('data.txt')  # Create presentation data
    labels2 = labels.copy()
    d = createTree(dataSet, labels)  # Output decision tree model results
    attribute = []
    for i in range(len(labels2)):
        attribute.append([])
        for j in dataSet:
            if j[i] not in attribute[i]:
                attribute[i].append(j[i])
    d = '('+d+')'
    print(d)
