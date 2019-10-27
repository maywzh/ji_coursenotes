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

labels, dataSet = readDataset('data.txt') 
print(labels)
print(dataSet)

dataClassList = [dataInstance[-1] for dataInstance in dataSet]

print(getMajorClass(dataClassList))