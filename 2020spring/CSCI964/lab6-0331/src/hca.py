from sklearn import datasets
from sklearn.cluster import AgglomerativeClustering
import matplotlib.pyplot as plt
from sklearn.metrics import confusion_matrix
import pandas as pd
from scipy.cluster.hierarchy import linkage, dendrogram

iris = datasets.load_iris()
irisdata = iris.data
z = linkage(irisdata, method='ward')
dendrogram(z)

print(irisdata)
clustering = AgglomerativeClustering(linkage='ward', n_clusters=3)

res = clustering.fit(irisdata)

print("各个簇的样本数目：")
print(pd.Series(clustering.labels_).value_counts())
print("聚类结果：")
print(confusion_matrix(iris.target, clustering.labels_))

plt.figure()
d0 = irisdata[clustering.labels_ == 0]
plt.plot(d0[:, 0], d0[:, 1], 'r.')
d1 = irisdata[clustering.labels_ == 1]
plt.plot(d1[:, 0], d1[:, 1], 'go')
d2 = irisdata[clustering.labels_ == 2]
plt.plot(d2[:, 0], d2[:, 1], 'b*')
plt.xlabel("Sepal.Length")
plt.ylabel("Sepal.Width")
plt.title("AGNES Clustering")
plt.show()