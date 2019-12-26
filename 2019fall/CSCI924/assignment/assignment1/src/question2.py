# Name : Wangzhihui Mei
# Number: 6603385(uow) / 2019124044(ccnu)
# Time: Oct. 20, 2019
# Site: https://github.com/maywzh

from math import log
import operator
from collections import Counter


def readDataset(filepath):
    """
    Read dataSet from data.txt
    """
    datalist = []
    featurelist = []
    with open(filepath) as f:
        features = f.readline()
        featurelist = features.split()
        datalines = f.readlines()
        for dataline in datalines:
            datalist.append(dataline.split())
    featurelist.pop()
    return featurelist, datalist


def getEntropy(dataSet):
    """
    calculate Entropy for dataSet
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


def getMajorClass(dataClassList):
    """
    get the dominant classification
    """
    counts = Counter()
    for dataClass in dataClassList:
        counts[dataClass] += 1
    return counts.most_common(1)[0][0]


def splitDataset(dataSet, featureIdx, v):
    """
    Dataset Classfication
    """
    retDataSet = []
    for featureVector in dataSet:
        if featureVector[featureIdx] == v:
            reducedFeatureVector = featureVector[:featureIdx]
            # The operation of these two steps does not include the divided feature attribute
            reducedFeatureVector.extend(featureVector[featureIdx + 1:])
            retDataSet.append(reducedFeatureVector)

    return retDataSet

def getSubDataset(dataSet, colIndex, value):
    """
    split subset 
    """
    subDataset = []
    for rowVector in dataSet:
        if rowVector[colIndex] == value:
            subRowVector = rowVector[:colIndex]
            subRowVector.extend(rowVector[colIndex + 1:])
            subDataset.append(subRowVector)
    return subDataset


def getSubDataset_Fixed(dataSet, colIndex, value):
    """
    split subset bug fix
    """
    subDataset = []
    for rowVector in dataSet:
        if rowVector[colIndex] == value:
            subDataset.append(rowVector)
    return subDataset


def getSplitFeature(dataSet):
    """
    Choose best feature for classification
    """
    numFeature = len(dataSet[0]) - 1
    baseEntropy = getEntropy(dataSet)
    bestInfoGain = 0.0
    bestFeature = -1
    for i in range(numFeature):
        feat_i_values = [dataInstance[i] for dataInstance in dataSet]
        uniqueValues = set(feat_i_values)
        feat_i_entropy = 0.0
        for value in uniqueValues:
            subDataset = getSubDataset_Fixed(dataSet, i, value)
            prob_i = len(subDataset) / float(len(dataSet))
            feat_i_entropy += prob_i * getEntropy(subDataset)
        infoGain_i = baseEntropy - feat_i_entropy
        if (infoGain_i > bestInfoGain):
            bestInfoGain = infoGain_i
            bestFeature = i
    return bestFeature


def createTree(dataSet, featureLabels):
    """
    Core Function: ID3 Algorithm Implementation 
    """
    # get the last colomn (the class) of dataSet
    dataclassList = [dataInstance[-1] for dataInstance in dataSet]
    # if there are only one class  => class
    if dataclassList.count(dataclassList[0]) == len(dataclassList):
        return dataclassList[0]
    # get dominant class
    if len(dataSet[0]) == 1:
        return getMajorClass(dataclassList)
    # get feature to split set
    bestFeature = getSplitFeature(dataSet)

    # getthe label
    bestFeatureLabel = featureLabels[bestFeature]
    # get tree
    myTree = {bestFeatureLabel: {}}
    # delete that lable
    del (featureLabels[bestFeature])
    # get best candidate value
    bestFeatureValues = [dataInstance[bestFeature] for dataInstance in dataSet]

    uniqueBestFeatureValues = set(bestFeatureValues)
    for value in uniqueBestFeatureValues:
        subDataset = getSubDataset(dataSet, bestFeature, value)
        subLabels = featureLabels[:]
        # recursively create subtree
        myTree[bestFeatureLabel][value] = createTree(subDataset, subLabels)
    return myTree


def printTree(dataSet, featureLabels):
    """
    compatible to LISP
    """
    dataClassList = [dataInstance[-1] for dataInstance in dataSet]
    # 
    if dataClassList.count(dataClassList[0]) == len(dataClassList):
        return ' ('+dataClassList[0]+')'
    if len(dataSet[0]) == 1:
        return ' ('+getMajorClass(dataClassList)+')'
    bestFeat = getSplitFeature(dataSet)
    bestFeatLabel = featureLabels[bestFeat]
    ans = ''
    myTree = {bestFeatLabel: {}}
    del (featureLabels[bestFeat])
    featValues = [dataInstance[bestFeat] for dataInstance in dataSet]
    Uvals = set(featValues)
    for value in Uvals:
        tmpstr = '('+str(bestFeatLabel)+' '+str(value)
        subLabels = featureLabels[:]
        tmpstr = tmpstr + \
            printTree(getSubDataset(dataSet, bestFeat, value), subLabels)
        ans = ans+tmpstr+')'
    return ans


if __name__ == '__main__':
    featureLabels, dataSet = readDataset(
        './data.txt')
    numLabels = len(featureLabels)
    ans = '(' + printTree(dataSet, featureLabels) + ")"
    print(ans)
