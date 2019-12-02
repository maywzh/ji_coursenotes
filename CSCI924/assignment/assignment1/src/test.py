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
    featurelist.pop()        
    return featurelist, datalist

def getMajorClass(dataClassList):
    """
    Sort by category quantity after classification
    """
    
    counts = Counter()
    for dataClass in dataClassList:
        counts[dataClass] += 1        
    return counts.most_common(1)[0][0]

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


labels, dataSet = readDataset('data.txt') 
# print(labels)
# print(dataSet)

# dataClassList = [dataInstance[-1] for dataInstance in dataSet]

# print(getEntropy(dataSet))
print()