import numpy as np
import pandas as pd
from matplotlib import pyplot as plt
import seaborn as sns
from sklearn.preprocessing import LabelEncoder

filepath = '../data/car.csv'
names = ['buying', 'maint', 'doors', 'persons', 'lug_boot', 'safety', 'acceptability']

dataset = pd.read_csv(filepath, names=names)