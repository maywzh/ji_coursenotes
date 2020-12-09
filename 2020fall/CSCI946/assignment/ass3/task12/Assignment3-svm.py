import numpy as np
from sklearn import svm
from sklearn.datasets  import load_digits
from sklearn.model_selection  import train_test_split
mnist = load_digits()
x,test_x,y,test_y = train_test_split(mnist.data,mnist.target,test_size=0.25,random_state=40)
model = svm.LinearSVC(penalty='l2', loss='squared_hinge', C=1.5, multi_class='ovr',fit_intercept=True, random_state=None,max_iter=5000)
svmmodel=model.fit(x, y)
z = model.predict(test_x)
print('acc:',np.sum(z==test_y)/z.size)