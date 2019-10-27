def readData(filepath):
    datalist = []
    featurelist= []
    with open(filepath) as f:
        features = f.readline()
        
        featurelist = features.split()
        datalines = f.readlines()
        for dataline in datalines:
            datalist.append(dataline.split())
    return featurelist, datalist

print(readData('data.txt'))