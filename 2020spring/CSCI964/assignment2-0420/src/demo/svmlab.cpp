#include "svm.h"
#include <ctype.h>
#include <fstream>
#include <iostream>
#include <stdlib.h>
#include <vector>
using namespace std;

const int MAXN = 50;      // Max neurons in any layer
const int MAXPATS = 5000; // Max training patterns
// mlp paramaters
long NumIts; // Max training iterations

#define Malloc(type, n) (type *)malloc((n) * sizeof(type))

struct svm_parameter param; // set by parse_command_line
struct svm_problem prob;    // set by read_problem
struct svm_model *model;
struct svm_node *x_space;
int dataSize, NFeature, Nlabel, NTrain, NTest;
std::vector<std::vector<double>> tdata;
std::vector<int> labels;

void readData(string FName) {
  ifstream fin;
  int i, j;

  char Line[ 500 ], Tmp[ 20 ], FName[ 20 ];

  fin.open(FName);
  if (!fin.good()) {
    cout << "File not found!\n";
    exit(1);
  }
  // read data specs...
  do {
    fin.getline(Line, 500);
  } while (Line[ 0 ] == ';'); // eat comments
  fin >> Tmp >> NFeature;     // number of features
  fin >> Tmp >> Nlabel;       // number of labels
  fin >> Tmp >> NTrain;       // 训练样例数
  fin >> Tmp >> NTest;        // 测试样例数

  // Distribute Space for Problem
  prob.l = NTrain;
  prob.x = Malloc(svm_node *, prob.l);
  prob.y = Malloc(double, prob.l);

  int temp;
  svm_node *features = new svm_node[ NFeature ];
  for (i = 0; i < NTrain; i++) {
    std::vector<double> featureVec;
    // read feature
    for (j = 0; j < NFeature; j++) {
      fin >> temp;
      featureVec.push_back(temp);
    }
    // read label
    for (j = 0; j < Nlabel; j++) {
      fin >> temp;
      labels.push_back(temp);
    }
    tdata.push_back(featureVec);
  }
  fin.close();
  ofstream paramfile;
}

// features[ j ].index = j + 1;
// features[ j ].value = temp;
// 对样本每一维的值进行归一化，目的是：
// A、避免一些特征值范围过大而另一些特征值范围过小；
// B、避免在训练时为了计算核函数而计算内积的时候引起数值计算的困难。

int main() {

  string FName;
  cout << "Enter data filename: ";
  cin >> FName;
  cin.ignore();
  readData(FName);
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------------

  cout << "data size = " << tdata.size() << endl;
  cout << "labels size = " << labels.size() << endl;
  // initialize the size of the problem with just an int
  // here we need to give some memory to our structures
  // @param prob.l = number of labels
  // @param elements = number of features for each label
  x_space =
      Malloc(struct svm_node,
             (NFeature + Nlabel) * prob.l); // memory for pairs of index/value

  // here we are going to initialize it all a bit

  // initialize the different lables with an array of labels
  for (int i = 0; i < prob.l; ++i) {
    prob.y[ i ] = labels[ i ];
    cout << "prob.y[" << i << "] = " << prob.y[ i ] << endl;
  }
  // initialize the svm_node vector with input data array as follows:
  int j = 0; // counter to traverse x_space[i];
  for (int i = 0; i < prob.l; ++i) {
    // set i-th element of prob.x to the address of x_space[j].
    // elements from x_space[j] to x_space[j+data[i].size] get filled right
    // after next line
    prob.x[ i ] = &x_space[ j ];
    for (int k = 0; k < tdata[ i ].size(); ++k, ++j) {
      x_space[ j ].index = k + 1;           // index of value
      x_space[ j ].value = tdata[ i ][ k ]; // value
      cout << "x_space[" << j << "].index = " << x_space[ j ].index << endl;
      cout << "x_space[" << j << "].value = " << x_space[ j ].value << endl;
    }
    x_space[ j ].index = -1; // state the end of data vector
    x_space[ j ].value = 0;
    cout << "x_space[" << j << "].index = " << x_space[ j ].index << endl;
    cout << "x_space[" << j << "].value = " << x_space[ j ].value << endl;
    j++;
  }

  // ok, let's try to print it
  for (int i = 0; i < prob.l; ++i) {
    cout << "line " << i << endl;
    cout << prob.y[ i ] << "---";
    for (int k = 0; k < NFeature; ++k) {
      int index = (prob.x[ i ][ k ].index);
      double value = (prob.x[ i ][ k ].value);
      cout << index << ":" << value << " ";
    }
    cout << endl;
  }
  cout << "all ok" << endl;

  // set all default parameters for param struct
  param.svm_type = C_SVC;
  param.kernel_type = RBF;
  param.degree = 3;
  param.gamma = 0; // 1/num_features
  param.coef0 = 0;
  param.nu = 0.5;
  param.cache_size = 100;
  param.C = 1;
  param.eps = 1e-3;
  param.p = 0.1;
  param.shrinking = 1;
  param.probability = 0;
  param.nr_weight = 0;
  param.weight_label = NULL;
  param.weight = NULL;

  // try to actually execute it
  model = svm_train(&prob, &param);

  return 0;
}