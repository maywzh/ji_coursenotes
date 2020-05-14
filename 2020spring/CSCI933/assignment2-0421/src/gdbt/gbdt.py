# 导入pandas模块，sklearn中model_select模块
import numpy as np
import pandas as pd
from sklearn.ensemble import GradientBoostingClassifier
from sklearn.model_selection import train_test_split
import matplotlib.pylab as plt
import joblib
# 读取数据
data = pd.read_csv('diabetes.csv')
# 将特征划分到 X 中，标签划分到 Y 中
x = data.iloc[:, [0, 1, 2, 3, 4, 5, 6, 7]]
y = data.iloc[:, [8]]
# 使用train_test_split函数划分数据集(训练集占75%，测试集占25%)
x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.25)
#print(x_train,x_test,y_train,y_test)

gbdt = GradientBoostingClassifier(learning_rate=0.01,
                                  n_estimators=1000,
                                  subsample=0.9,
                                  min_samples_split=2,
                                  min_samples_leaf=6,
                                  max_depth=100,
                                  init=None,
                                  random_state=None,
                                  max_features=None,
                                  verbose=0,
                                  max_leaf_nodes=None,
                                  warm_start=False)
gbdt.fit(x_train, y_train.values.ravel())
print(gbdt.score(x_test, y_test))
y_pred = gbdt.predict(x_test)