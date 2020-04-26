#include "svm.h"
#include <ctype.h>
#include <fstream>
#include <iostream>
#include <stdlib.h>
#include <vector>
using namespace std;

#define Malloc(type, n) (type *)malloc((n) * sizeof(type))

struct svm_parameter param; // set by parse_command_line
struct svm_problem prob;    // set by read_problem
struct svm_model *model;
struct svm_node *x_space;
svm_node **testFeatures;
int *testLabels;
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
  testLabels = new int[NTest];
  int testLabel;
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
    cout << testLabel << endl;
    testLabels[i] = testLabel;
  }
  fin.close();

  cout << "Data loaded" << endl << "Loading parameter" << endl;

  param.svm_type = C_SVC;
  param.kernel_type = RBF;
  param.degree = 3;
  param.gamma = 8.0; // 1/num_features
  param.coef0 = 0;
  param.nu = 0.5;
  param.cache_size = 100;
  param.C = 2048;
  param.eps = 1e-3;
  param.p = 0.1;
  param.shrinking = 1;
  param.probability = 0;
  param.nr_weight = 0;
  param.weight_label = NULL;
  param.weight = NULL;

  // Train model
  model = svm_train(&prob, &param);
  svm_save_model("model.txt", model);

  // Test model
  int passtest = 0;
  for (i = 0; i < NTest; i++) {
    int predictValue = svm_predict(model, testFeatures[i]);
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