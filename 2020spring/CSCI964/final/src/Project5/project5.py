import os
import pandas as pd
import torch
import torch.nn as nn
import torch.nn.functional as F
import torch.optim as optim
import numpy as np
from sklearn.metrics import accuracy_score
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
import seaborn as sns

files = os.listdir('learn/')
cnt = 2
data = []
for file in files:
    with open('learn/' + file, 'r') as fi:  #from path read file
        for line in fi:
            seg = line.strip().split()  #split the line by blank
            tmp = []
            for i in range(len(seg)):
                if i == cnt:
                    continue
                tmp.append(float(seg[i]))  #save the number to list
            data.append(tmp)  #save one instance to list
print(len(data))
print(len(data[0]))
df = pd.DataFrame(data)
#print some data information

# #df.head()
# label = df[0]  #choose label
# data = df.drop([0, 1], axis=1)  #choose data

# for column in data.columns:
#     data[column] = (data[column] - data[column].min()) / (data[column].max() -
#                                                           data[column].min())
#     #normalize the data from 0 to 1
# print(label)
# print(data)

# #print(data)
# class NN(nn.Module):
#     def __init__(self):  #
#         super(NN, self).__init__()
#         self.fc1 = nn.Linear(6, 50 * 3)
#         self.fc2 = nn.Linear(50 * 3, 50 * 3)
#         self.fc3 = nn.Linear(50 * 3, 10)

#     def forward(self, x):
#         x = F.relu(self.fc1(x))  #build the neutrel network
#         x = F.relu(self.fc2(x))
#         x = self.fc3(x)
#         return x

# print(set(label))
# data = np.array(data)
# label -= 1
# label = np.array(label)
# model = NN()
# criterion = nn.CrossEntropyLoss()  #set ce to calculate loss
# optimizer = torch.optim.Adam(
#     model.parameters(), lr=0.0001)  #set optimizer to optimze net.parameters()
# l = []
# acc = []
# X_train, X_test, y_train, y_test = train_test_split(data,
#                                                     label,
#                                                     test_size=0.3,
#                                                     random_state=66)
# #split data to train and test set
# for epoch in range(10000):  # loop over the dataset multiple times
#     running_loss = 0.0
#     for i in range(0, len(X_train), 500):
#         inputs = X_train[i:min(i + 500, len(X_train))]  #choose a batch data
#         labels = y_train[i:min(i + 500, len(X_train))]  #choose a batch label
#         inputs = torch.Tensor(inputs)  #transform data to tensor
#         labels = torch.LongTensor(labels)  #transform label to tensor
#         optimizer.zero_grad()
#         outputs = model(inputs)  #forward to calculate model output
#         #print(set(outputs))
#         #print(set(labels))
#         loss = criterion(outputs, labels)  #calculate loss
#         loss.backward()  #backward
#         optimizer.step()  #optimize update
#         running_loss += loss.item()

#     if epoch % 10 == 0:  #every 10 epoch to calculte loss and accuracy
#         print(running_loss / 10 / len(X_train))
#         l.append(running_loss / 10 / len(X_train))  #save the loss
#         running_loss = 0.0
#         model.eval()
#         test_output = model(torch.Tensor(X_test))  #predict
#         pred_y = torch.max(
#             test_output,
#             1)[1].data.numpy().squeeze()  #transform tensor to list
#         #model.train()
#         print('acc', accuracy_score(pred_y, y_test))
#         acc.append(accuracy_score(pred_y, y_test))  #save accuracy
#         #print(recall_score(pred_y,label))
# print('Finished Training')
# # plt.plot(l, label='loss')
# # plt.legend()
# # plt.show()
# # plt.plot(acc, label='accuracy')
# # plt.legend()
# # plt.show()