#导包

import re
from gensim.models import word2vec
import numpy as np
import pandas as pd
from sklearn.model_selection import  train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.ensemble import RandomForestClassifier,GradientBoostingClassifier,ExtraTreesClassifier
from sklearn.metrics import precision_score,recall_score,roc_auc_score
from mlxtend.classifier import StackingClassifier
from sklearn import svm
from sklearn import metrics

from sklearn.neural_network import MLPClassifier

import matplotlib.pylab as plt

data=pd.read_csv("AlanBryd.csv").astype(str)
'''
clean the dataset 
'''

def remove_pattern(input_txt, pattern):
    r = re.findall(pattern, input_txt)
    for i in r:
        input_txt = re.sub(i, '', input_txt)

    return input_txt
data['comment'] = np.vectorize(remove_pattern)(data['comment'], "@[\w]*")
data['comment']= data['comment'].str.replace("[^a-zA-Z#]", " ")
data['comment'] = data['comment'].apply(lambda x: ' '.join([w for w in x.split() if len(w)>3]))




text = data['comment']
sentences = []
for item in text:
    sentence = str(item).split(' ')
    sentences.append(sentence)
#训练
model = word2vec.Word2Vec(sentences,size = 200)

def buildWordVector(imdb_w2v,text, size):
    vec = np.zeros(size).reshape((1, size))
    count = 0.
    #print text
    for word in text.split():
        #print word
        try:
            vec += imdb_w2v[word].reshape((1, size))
            count += 1.
        except KeyError:
            print (word)
            continue
    if count != 0:
        vec /= count
    return vec
result = buildWordVector(model, data.loc[1]['comment'] , 200)
for i in range(1,len(data)):
    result = np.concatenate((result, buildWordVector(model, data.loc[i]['comment'] , 200)), axis = 0)
#读取出数据
#把series 转换成dataframe格式，并且将200维的特征都赋值

vectors = pd.DataFrame(result)

vectors.to_csv('word2vec.csv',index=False)

vectors =pd.read_csv('word2vec.csv')
data = pd.concat([data, vectors], axis = 1)
del data['comment']
y=data['id']
x=data.drop('id',axis=1)

x_train,x_test,y_train,y_test=train_test_split(x,y,test_size=0.25)

model1 = GradientBoostingClassifier(
    n_estimators=1000,
    subsample=0.8,
    loss='deviance',
    max_features='sqrt',
)

model2=svm.SVC()

model3=RandomForestClassifier(
    oob_score=True,
    n_estimators=400,
    max_features='sqrt',
)
model5=ExtraTreesClassifier()


clf1 = LogisticRegression(random_state=1)
model7=StackingClassifier(
    classifiers=[model1,model3,model5],
    meta_classifier=clf1

)

def p_score(model):
    model.fit(x_train, y_train)
    y_pred =model.predict(x_train)
    train_error = np.mean(y_pred != y_train)
    print("model train err is %f" % train_error)

    y_pred_test=model.predict(x_test)
    print('auc is ',roc_auc_score(y_test,y_pred_test))
    print("precision is ",precision_score(y_test, y_pred_test, average='macro'))
    print("recall is ",recall_score(y_test, y_pred_test, average='macro'))  # 0.3333333333333333
    test_error=np.mean(y_pred_test != y_test)
    print(" test err is ",test_error)


print("gbdt score:")
p_score(model1)

print("svm score:")
p_score(model2)
print("RF score:")
p_score(model3)

print("ET score:")
p_score(model5)

print("staking(GBDT ET RF - LR) score：")
p_score(model7)


y_test=y_test.astype(int)
pred=model1.predict(x_test)
pred=pred.astype(int)
fpr, tpr, threshold = metrics.roc_curve(y_test, pred)
roc_auc = metrics.auc(fpr, tpr)

plt.figure(figsize=(6,6))
plt.title('Validation ROC')
plt.plot(fpr, tpr, 'b', label = 'Val AUC = %0.3f' % roc_auc)
plt.legend(loc = 'lower right')
plt.plot([0, 1], [0, 1],'r--')
plt.xlim([0, 1])
plt.ylim([0, 1])
plt.ylabel('True Positive Rate')
plt.xlabel('False Positive Rate')
plt.show()
#print(x_train)
#print(y_train)


