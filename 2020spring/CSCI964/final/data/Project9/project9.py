import pandas as pd
import seaborn as sns
import numpy as np
import matplotlib.pyplot as plt
from pandas.plotting import scatter_matrix
from sklearn.impute import SimpleImputer
import tensorflow as tf
from sklearn.model_selection import StratifiedShuffleSplit
from sklearn.model_selection import GridSearchCV
from sklearn.metrics import confusion_matrix
from sklearn.metrics import classification_report
from tensorflow import keras
from tensorflow import set_random_seed
from numpy.random import seed
from datetime import datetime

columns1 = ["Elevation", "Aspect", "Slope", "Horizontal_Distance_To_Hydrology", 
         "Vertical_Distance_To_Hydrology", "Horizontal_Distance_To_Roadways", 
         "Hillshade_9am", "Hillshade_Noon", "Hillshade_3pm", 
         "Horizontal_Distance_To_Fire_Points", "Rawah", "Neota", "Comanche Peak", "Cache la Poudre"]

columns2 = ["Soil_Type {}".format(i) for i in range(40)] + ["Cover_Type"]
columns =columns1
columns.extend(columns2)

data = pd.read_csv('covtype.csv',header=None, names=columns)

data_headers = data.columns.values.tolist()
new_feature_type = list()
for i in range(len(data_headers)):
    if i == 3 or i == 4:
        new_feature_type.append('float32')
    elif i < 10:
        new_feature_type.append('int16')
    else:
        new_feature_type.append('uint8')
new_feature_type_mapping = dict(zip(data_headers,
                                      new_feature_type))
data = data.astype(dtype=new_feature_type_mapping)

train = data[:16000].copy()

def covtype_distribut_plot(elevations_df, covtype_mapping):
    custom_palette = ['#F97EDB', '#49C0EA', '#B49EFC', '#CDAB40',
                      '#F69089', '#76BF3F', '#4CC9A6']
    sns.set_style('darkgrid')
    bins = range(1800,4000,60)
    for covtype_id, covtype_name in covtype_mapping.items():
        palette_idx = covtype_id - 1        
       
        by_one_covtype = elevations_df.groupby('Cover_Type').apply(lambda x: x[ x['Cover_Type'] == covtype_id ])
        ax = sns.distplot(by_one_covtype.Elevation,
                          bins=bins,
                          color=custom_palette[palette_idx], label=covtype_name,
                          hist_kws=dict(alpha=0.8, edgecolor="none"),
                          kde=False)

    plt.legend(loc='right', bbox_to_anchor=(1.2, 0.8), ncol=1)
    ax.set(xlabel='Elevation (meters)', ylabel='Count')
    plt.tight_layout()
    plt.show()


elevations = train.loc[:, ['Elevation', 'Cover_Type']]
covtype_label_name_dict = {1: 'Spruce/Fir',
                           2: 'Lodgepole Pine',
                           3: 'Ponderosa Pine',
                           4: 'Cottonwood/Willow',
                           5: 'Aspen',
                           6: 'Douglas-fir',
                           7: 'Krummholz'}
#covtype_distribut_plot(elevations, covtype_label_name_dict)

df_covtype = data.iloc[16000:]
df_covtype = pd.concat([train, df_covtype])

hv_distances_labels = ['Horizontal_Distance_To_Hydrology',
                       'Vertical_Distance_To_Hydrology']
hv_dist_hydro_arr = df_covtype[hv_distances_labels].values
euc_distance_to_hydro = np.linalg.norm(hv_dist_hydro_arr, axis=1)
df_covtype.insert(3,
                  'Distance_To_Hydrology',
                  np.around(euc_distance_to_hydro, decimals=4))
df_covtype.drop(columns=hv_distances_labels, inplace=True)

one_hot_covtype = pd.get_dummies(df_covtype.Cover_Type, prefix='CovT')
df_covtype.drop(columns='Cover_Type', inplace=True)
df_covtype_ohe = df_covtype.join(one_hot_covtype)

df_covtype_ohe.drop(labels=['Aspect', 'Slope'], axis=1, inplace=True)


def train_test_split(df_covtype_ohe):
    count = int(len(df_covtype_ohe)*0.7)
    X_train = df_covtype_ohe[:count].copy()
    X_train, y_train = X_train.iloc[:, :51], X_train.iloc[:, 51:]
    X_test = df_covtype_ohe[count:].copy()
    X_test, y_test = X_test.iloc[:, :51], X_test.iloc[:, 51:]
    return X_train, X_test, y_train, y_test

X_train, X_test, y_train, y_test = train_test_split(df_covtype_ohe)


def train_test_normalize(X_train, X_test):
    numerical_columns = ['Elevation',
                         'Distance_To_Hydrology',
                         'Horizontal_Distance_To_Roadways',
                         'Hillshade_9am', 'Hillshade_Noon', 'Hillshade_3pm',
                         'Horizontal_Distance_To_Fire_Points']
    X_train_num_cols_mean = X_train[numerical_columns].mean()
    X_train_num_cols_std = X_train[numerical_columns].std()
    X_train_std = (X_train[numerical_columns] - X_train_num_cols_mean) / X_train_num_cols_std
    ohe_features = X_train.columns.difference(other=numerical_columns, sort=False)
    X_train_std = pd.concat([X_train_std, X_train[ohe_features]], axis=1)
    X_test_std = (X_test[numerical_columns] - X_train_num_cols_mean) / X_train_num_cols_std
    X_test_std = pd.concat([X_test_std, X_test[ohe_features]], axis=1)
    return X_train_std, X_test_std

X_train_std, X_test_std = train_test_normalize(X_train, X_test)

X_train_std = X_train_std.to_numpy().astype(np.float32)
X_test_std = X_test_std.to_numpy().astype(np.float32)
y_train = y_train.to_numpy().astype(np.float32)
y_test = y_test.to_numpy().astype(np.float32)

validation_strat = StratifiedShuffleSplit(n_splits=10, test_size=0.25, random_state=10)

def bottleneck_model(hidden_layers=3, h1_size=46, h2_size=30, h3_size=15,
                      n_features=51, n_classes=7, learning_rate=0.3):
    model = keras.Sequential()
    model.add(keras.layers.Dense(h1_size, activation='relu', input_dim=n_features))
    model.add(keras.layers.Dense(n_features, activation='relu'))
    model.add(keras.layers.Dense(h2_size, activation='relu'))
    model.add(keras.layers.Dense(h3_size, activation='relu'))
    model.add(keras.layers.Dense(n_classes, activation='softmax'))
    sgd = keras.optimizers.SGD(lr=learning_rate)
    model.compile(optimizer=sgd, loss='categorical_crossentropy', metrics=['accuracy'])
    return model

selected_model = bottleneck_model()
cv_train_acc = []
cv_val_acc = []
cv_train_loss = []
cv_val_loss = []
best_epochs = 100
best_batch_size = 128
sss = StratifiedShuffleSplit(n_splits=10, test_size=0.25, random_state=1)
cv_fold_counter = 0
for train_index, valid_index in sss.split(X_train_std, y_train):
    X_train_std_minus_validation = X_train_std[train_index]
    X_validation = X_train_std[valid_index]
    y_train_minus_validation = y_train[train_index]
    y_validation = y_train[valid_index]
    history = selected_model.fit(X_train_std_minus_validation,
                                 y_train_minus_validation,
                                 epochs=best_epochs,
                                 batch_size=best_batch_size,
                                 validation_data=(X_validation, y_validation),
                                 verbose=0)
    cv_train_acc.append(history.history['acc'])
    cv_val_acc.append(history.history['val_acc'])
    cv_train_loss.append(history.history['loss'])
    cv_val_loss.append(history.history['val_loss'])
    cv_fold_counter += 1
    print(f'{cv_fold_counter}-fold completed.')


cv_train_acc_arr = np.array(cv_train_acc).flatten()
cv_val_acc_arr = np.array(cv_val_acc).flatten()
cv_train_acc_arr = cv_train_acc_arr[0:10*best_epochs:best_epochs]
cv_val_acc_arr = cv_val_acc_arr[0:10*best_epochs:best_epochs]

cv_train_loss_arr = np.array(cv_train_loss).flatten()
cv_val_loss_arr = np.array(cv_val_loss).flatten()
cv_train_loss_arr = cv_train_loss_arr[0:10*best_epochs:best_epochs]
cv_val_loss_arr = cv_val_loss_arr[0:10*best_epochs:best_epochs]


plt.figure()
plt.plot(range(1, cv_train_acc_arr.shape[0] + 1), cv_train_acc_arr, 'bo', label='Training acc')
plt.plot(range(1, cv_val_acc_arr.shape[0] + 1), cv_val_acc_arr, 'b', label='Validation acc')
plt.ylim(0.5, 1)
plt.title('Two hidden model train/val accuracy - 10-fold cv')
plt.ylabel('Accuracy')
plt.xlabel('Number of folds')
plt.grid()
plt.legend(loc='upper left')
plt.show()


'''
plt.figure()
plt.plot(range(1, cv_train_loss_arr.shape[0] + 1), cv_train_loss_arr, 'bo', label='Training loss')
plt.plot(range(1, cv_val_loss_arr.shape[0] + 1), cv_val_loss_arr, 'b', label='Validation loss')
plt.title('Two hidden model train/val loss - 10-fold cv')
plt.ylabel('Loss')
plt.xlabel('Number of folds')
plt.grid()
plt.legend(loc='upper right')
plt.show()
'''

y_pred = selected_model.predict(X_test_std)
y_pred_cat = np.argmax(y_pred, axis=1)
y_true_cat = np.argmax(y_test, axis=1)

target_names = ['Spruce/Fir', 'Lodgepole Pine',
                'Ponderosa Pine', 'Cottonwood/Willow',
                'Aspen', 'Douglas-fir', 'Krummholz']
print(classification_report(y_true_cat, y_pred_cat, target_names=target_names))

'''
import seaborn as sns
cm = confusion_matrix(y_true_cat, y_pred_cat)
fig, ax = plt.subplots(figsize=(15,15))
heatmap = sns.heatmap(cm, fmt='g', cmap='Blues', annot=True, ax = ax)
ax.set_xlabel('Predicted class')
ax.set_ylabel('True class')
ax.set_title('Confusion Matrix')
ax.xaxis.set_ticklabels(target_names)
ax.yaxis.set_ticklabels(target_names)
'''