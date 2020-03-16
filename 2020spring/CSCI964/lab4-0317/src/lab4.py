import libsvm.commonutil as commonutil
import libsvm.svmutil as sut

y, x = sut.svm_read_problem("../data/iris_libsvm_random.txt")
model = sut.svm_train(y, x, '-t 3')
p_label, p_acc, p_val = sut.svm_predict(y, x, model)
