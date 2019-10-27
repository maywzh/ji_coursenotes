"""
LIU ZHANGJUNCHAO
2019124052
"""
from math import log
import operator
def createDataSet1():  # upload sample data
    dataSet = [['High', 'yes', 'AboveAverage', 'no'],
               ['High', 'No', 'Average', 'YES'],
               ['High', 'No', 'AboveAverage','no'],
               ['High', 'No', 'Average', 'YES'],
               ['Medium', 'yes', 'AboveAverage','YES'],
               ['Medium', 'yes', 'Average','YES'],
               ['Medium', 'No', 'BelowAverage','YES'],
               ['Medium', 'No', 'AboveAverage','no'],
               ['Low', 'yes', 'Average','YES'],
               ['Low', 'yes', 'BelowAverage','no'],
               ['Low', 'yes', 'BelowAverage','no'],
               ['Low', 'No', 'AboveAverage','YES'],
               ['Low', 'No', 'BelowAverage','YES'],
               ['Low', 'No', 'BelowAverage','YES'],
               ]
    features = ['Turnover', 'Reissued','Dividend']     # Three characteristics
    return dataSet, features
# Calculate the information entropy of data
def calcShannonEnt(dataSet):
    numEntries = len(dataSet)  # Number of data bars
    labelCounts = {}
    for featVec in dataSet:
        currentLabel = featVec[-1]             # Last word (category) of each row of data
        if currentLabel not in labelCounts.keys():
            labelCounts[currentLabel] = 0      # Initialize the number of each category in the dictionary
        labelCounts[currentLabel] += 1         # Count how many classes there are and the number of each class
    shannonEnt = 0
    for key in labelCounts:
        prob = float(labelCounts[key]) / numEntries  # Calculating the entropy of a single class
        shannonEnt -= prob * log(prob, 2)            # Add up the entropy of each class
    return shannonEnt
# Data classified by a feature
def splitDataSet(DATASet, TEMP, VALUE):
    retDataSet = []
    for featVec in DATASet:
        if featVec[TEMP] == VALUE:
            reducedFeatVec = featVec[:TEMP]
            reducedFeatVec.extend(featVec[TEMP + 1:])  # The operation of these two steps does not include the divided feature attribute
            retDataSet.append(reducedFeatVec)

    return retDataSet
# Sort by category quantity after classification;
def majorityCnt(classList):
    classCount = {}
    for vote in classList:
        if vote not in classCount.keys():
            classCount[vote] = 0
        classCount[vote] += 1
    sortedClassCount = sorted(classCount.items(), key=operator.itemgetter(1), reverse=True)
    print(sortedClassCount)
    return sortedClassCount[0][0]

# Build decision tree (ID3 decision tree)
def createTree(dataSet, labels):
    classList = [example[-1] for example in dataSet]
    if classList.count(classList[0]) == len(classList):  # Return the same category in the final leaf node
        return ' ('+classList[0]+')'
    if len(dataSet[0]) == 1:
        return ' ('+majorityCnt(classList)+')'
    bestFeat = chooseBestFeatureToSplit(dataSet)         # Index for selecting the best feature
    bestFeatLabel = labels[bestFeat]
    rs=''
    myTree = {bestFeatLabel: {}}                         # The classification results are saved in the form of dictionaries
    del (labels[bestFeat])
    featValues = [example[bestFeat] for example in dataSet]
    Uvals = set(featValues)
    for value in Uvals:
        rs1='('+str(bestFeatLabel)+' '+str(value)
        subLabels = labels[:]
        rs1=rs1+createTree(splitDataSet(dataSet,bestFeat,value),subLabels)
        rs=rs+rs1+')'
    return rs
# Choose the best classification feature
def chooseBestFeatureToSplit(dataSet):
    numFeatures = len(dataSet[0]) - 1          # Number of features obtained
    BasedEntropy = calcShannonEnt(dataSet)     # Primitive information entropy
    BestInfoGain = 0
    BestFeatures = -1
    for i in range(numFeatures):              # Ergodic two features
        featList = [example[i] for example in dataSet]
        uniqueVals = set(featList)            # Introduction set
        NewEntropy = 0

        for value in uniqueVals:
            subDataSet = splitDataSet(dataSet, i, value)     # Data set classified according to a feature
            prob = len(subDataSet) / float(len(dataSet))
            NewEntropy += prob * calcShannonEnt(subDataSet)  # Conditional empirical entropy after feature classification
        INFOGain = BasedEntropy - NewEntropy        # The difference between the original entropy and the entropy classified according to the feature is the information gain divided according to the feature.
        if (INFOGain > BestInfoGain):               # If the entropy decreases the most after a feature is divided, then the sub feature is the optimal classification feature.
            bestInfoGain = INFOGain
            BestFeatures = i
    return BestFeatures                             # The index of the optimal feature is returned
if __name__ == '__main__':
    dataSet, labels = createDataSet1()  # Create presentation data
    labels2=labels.copy()
    d=createTree(dataSet, labels)  # Output decision tree model results
    attribute=[]
    for i in range(len(labels2)):
        attribute.append([])
        for j in dataSet:
            if j[i] not in attribute[i]:
                attribute[i].append(j[i])
    d='('+d+')'
    print(d)