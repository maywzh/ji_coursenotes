import numpy as np
import pandas as pd
import random
import libsvm.commonutil as commonutil
import libsvm.svmutil as svmutil

from sklearn.datasets import dump_svmlight_file
df = pd.DataFrame([['green', 'M', 10.1, 'class1'], ['red', 'L', 13.5, 'class2'], ['blue', 'XL', 15.3, 'class1']])
df.columns = ['color', 'size', 'prize', 'label']
size_mapping = {'XL': 3, 'L': 2, 'M': 1}
df['size'] = df['size'].map(size_mapping)
class_mapping = {label: idx for idx, label in enumerate(set(df['label']))}
df['label'] = df['label'].map(class_mapping)
y = df.label  # y为数据的label值
dummy = pd.get_dummies(df.iloc[:, :])
# play one-hot
