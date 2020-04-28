#include "svm.h"
#include <ctype.h>
#include <fstream>
#include <iostream>
#include <math.h>
#include <stdlib.h>
#include <vector>
using namespace std;

#define Malloc(type, n) (type *)malloc((n) * sizeof(type))

struct svm_parameter param; // set by parse_command_line
struct svm_problem prob;    // set by read_problem
struct svm_model *model;
struct svm_node *x_space;
svm_node **testFeatures;
double *testLabels;
svm_node *featureVecs;
svm_node *labels;

int main() {
  int NFeature, NLabel, NTrain, NTest;
  char Line[500], Tmp[20], FName[20];
  ifstream fin;
  int i, j;
  cout << "Enter data filename: ";
  cin >> FName;
  cin.ignore();
  fin.open(FName);
  if (!fin.good()) {
    cout << "File not found!\n";
    exit(1);
  }
  fin >> NFeature >> NLabel >> NTrain >> NTest; // 测试样例数
  prob.l = NTrain;
  prob.x = Malloc(svm_node *, prob.l);
  prob.y = Malloc(double, prob.l);
  double temp;
  cout << "Loading training data" << endl;
  for (i = 0; i < NTrain; i++) {
    svm_node *featureVec = new svm_node[NFeature + 1];
    // read feature
    for (j = 0; j < NFeature; j++) {
      fin >> temp;
      cout << temp << " ";
      featureVec[j].index = j + 1;
      featureVec[j].value = temp;
    }
    featureVec[NFeature].index = -1; // the last index should be -1
    prob.x[i] = featureVec;
    // read label
    fin >> temp;
    cout << temp << endl;
    prob.y[i] = temp;
  }

  cout << "Loading testing data" << endl;
  testFeatures = Malloc(svm_node *, NTest);
  testLabels = new double[NTest];
  double testLabel;
  double acc;
  for (i = 0; i < NTest; i++) {
    svm_node *testFeatureVec = new svm_node[NFeature + 1];
    // read feature
    for (j = 0; j < NFeature; j++) {
      fin >> temp;
      cout << temp << " ";
      testFeatureVec[j].index = j + 1;
      testFeatureVec[j].value = temp;
    }
    testFeatureVec[NFeature].index = -1; // the last index should be -1
    testFeatures[i] = testFeatureVec;
    fin >> testLabel;

    testLabels[i] = testLabel;
  }
  fin.close();

  cout << "Data loaded" << endl << "Loading parameter" << endl;

  param.svm_type = 0; // -s svm类型：SVM设置类型(默认0)0 -- C-SVC 1
                      // --v-SVC 2 – 一类SVM 3 -- e-SVR 4 -- v-SVR

  param.C = 2; //　　-c cost：设置C-SVC，e -SVR和v-SVR的参数(损失函数)(默认1
  param.gamma = 2;
  // -g
  // r(gama)：核函数中的gamma函数设置(针对多项式/rbf/sigmoid核函数)(默认1/n_features)

  param.kernel_type = RBF;
  //-t 核函数类型：核函数设置类型(默认2) 0 – 线性：u'v 1 –
  //多项式：(r*u'v + coef0)^degree 2 – RBF函数：exp(-gamma|u-v|^2) 3
  //–sigmoid：tanh(r*u'v + coef0)
  param.degree = 3;
  //　　-d degree：核函数中的degree设置(针对多项式核函数)(默认3)

  param.coef0 =
      0; //　　-r coef0：核函数中的coef0设置(针对多项式/sigmoid核函数)((默认0)

  param.nu = 0.5; //　　-n nu：设置v-SVC，一类SVM和v- SVR的参数(默认0.5)

  param.cache_size =
      100; //　　-m cachesize：设置cache内存大小，以MB为单位(默认40)

  param.eps = 1e-3; //　　-e eps：设置允许的终止判据(默认0.001)

  param.shrinking = 1; //　　-h shrinking：是否使用启发式，0或1(默认1)

  param.probability =
      0; //-b 概率估计：是否计算SVC或SVR的概率估计，可选值0 或1，默认0；

  /*nr_weight, weight_label, and weight are used to change the penalty
    for some classes (If the weight for a class is not changed, it is
    set to 1). This is useful for training classifier using unbalanced
    input data or with asymmetric misclassification cost.
 */
  param.nr_weight = 0;
  param.weight_label = NULL;
  param.weight =
      NULL; //　　-wi weight：设置第几类的参数C为weight*C(C-SVC中的C)(默认1)

  // Train model
  model = svm_train(&prob, &param);
  svm_save_model("model.txt", model);

  // Test model
  int passtest = 0;
  for (i = 0; i < NTest; i++) {
    double predictValue = svm_predict(model, testFeatures[i]);
    cout << "index:" << i << " predict: " << predictValue
         << " actual: " << testLabels[i] << endl;
    if (predictValue == testLabels[i])
      passtest++;
  }
  acc = passtest / (NTest * 1.0);
  cout << "acc=" << acc << endl;

  // Free Memory
  delete prob.y;
  for (int i = 0; i < NTrain; i++) {
    delete[] prob.x[i];
  }
  delete[] prob.x;
  for (int i = 0; i < NTest; i++)
    delete[] testFeatures[i];
  delete[] testFeatures;
  delete[] testLabels;
  svm_free_and_destroy_model(&model);

  return 0;
}