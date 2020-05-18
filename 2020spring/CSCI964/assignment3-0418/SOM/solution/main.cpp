#include <algorithm>
#include <chrono> // std::chrono::system_clock
#include <cmath>
#include <fstream>
#include <iostream>
#include <random> // std::default_random_engine
#include <sstream>
#include <string>
#include <vector>
using namespace std;
struct info {
  int simpleLength;
  int simpleNumber;
};
double generator() {
  // srand((unsigned)time(NULL));
  double a = rand() % 1000 * 0.001;
  return a;
}
// Load the MNIST dataset in;
struct info dlmread(string path, vector<vector<double>> &data) {
  // find simpleNumber
  fstream f(path);
  string oneLine;
  getline(f, oneLine, '\n');
  istringstream issOneLine(oneLine);
  string temp;
  int simpleNumber = 0;
  while (getline(issOneLine, temp, ' ')) {
    simpleNumber++;
  }
  f.seekp(0);

  string line;
  // init simple vector
  for (int i = 0; i < simpleNumber; i++) {
    vector<double> temp;
    data.push_back(temp);
  }

  // fill into
  int simpleLength = 0;
  while (getline(f, line, '\n')) {
    istringstream iss(line);
    string temp;
    simpleLength++;
    int count = 0;
    while (getline(iss, temp, ' ')) {
      data[count++].push_back(atof(temp.c_str()));
    }
  }
  f.close();
  struct info simpleInfo;
  simpleInfo.simpleLength = simpleLength;
  simpleInfo.simpleNumber = simpleNumber;

  return simpleInfo;
}

// init the weight vector of each neuron
void initWeightVertor(int simpleLength, vector<vector<double>> &data) {
  for (int i = 0; i < data.size(); i++) {
    vector<double> temp;
    for (int i = 0; i < simpleLength; i++) {
      temp.push_back(generator());
    }
    data[i] = temp;
  }
}

void computeSquaredEuclideanDistances(vector<double> &result,
                                      vector<double> &simple,
                                      vector<vector<double>> &weights) {
  for (int i = 0; i < result.size(); i++) {
    result[i] = 0.0;
    for (int j = 0; j < simple.size(); j++) {
      result[i] = result[i] + pow(simple[j] - weights[i][j], 2);
    }
  }
}

// Compute the value of the neighborhood function h();
void computeH(vector<double> &result, vector<double> &sqEucDistNeighborhood,
              double sigma_t) {
  for (int i = 0; i < result.size(); i++) {
    result[i] = exp(-(sqEucDistNeighborhood[i] / (2 * sigma_t * sigma_t)));
  }
  int c = 0;
}

// update weights
void updateWeight(vector<vector<double>> &weights,
                  vector<double> &sqEucDistNeighborhood, vector<double> &simple,
                  double eta_t) {
  for (int i = 0; i < weights.size(); i++) {
    for (int j = 0; j < weights[i].size(); j++) {

      weights[i][j] = weights[i][j] + eta_t * sqEucDistNeighborhood[i] *
                                          (simple[j] - weights[i][j]);
    }
  }
}

void savePictureData(string path, vector<vector<double>> &weights) {
  std::ofstream fs(path, std::fstream::out | std::fstream::trunc);

  for (int i = 0; i < weights.size(); i++) {
    for (int j = 0; j < weights[i].size() - 1; j++) {
      fs << weights[i][j] << " ";
    }
    fs << weights[i][weights[i].size() - 1] << "\n";
  }
  fs.close();
}

float diff(vector<vector<double>> &weights,
           vector<vector<double>> &weightsOld) {
  vector<double> result(weights.size());
  for (int i = 0; i < weights.size(); i++) {
    for (int j = 0; j < weights[i].size(); j++) {
      result[i] = result[i] + pow((weights[i][j] - weightsOld[i][j]), 2);
    }

    result[i] = sqrt(result[i]);
  }
  double res = 0;
  for (int i = 0; i < weights.size(); i++) {
    res = res + result[i];
  }

  return sqrt(res);
}
vector<int> indexToSubIndex(int index, int col, int row) {
  vector<int> subIndex(2);
  subIndex[0] = (index / col) + 1;
  subIndex[1] = (index % col) + 1;
  return subIndex;
}
void computeDistances(vector<double> &result, int center, int col, int row) {
  vector<int> centerSubIndex = indexToSubIndex(center, col, row);
  for (int i = 0; i < result.size(); i++) {
    vector<int> tempSubIndex = indexToSubIndex(i, col, row);
    result[i] = pow(centerSubIndex[0] - tempSubIndex[0], 2) +
                pow(centerSubIndex[1] - tempSubIndex[1], 2);
  }
}
int main(int argc, char const *argv[]) {
  int rowNum = 10;
  int colNum = 10;
  int neuronNum = rowNum * colNum;
  // two phrases
  int epochNumOrd = 1000;
  int epochNumCov = 2000;
  // Initialise the learning rate and define the rate in each epoch t;
  double eta_0 = 0.1;
  double eta_t = eta_0;
  // Define the attenuation speed of the learning rate with epoches;
  double tau_2 = 1000;

  // Initialise the sigma value of the neighbourhood function h();
  // sigma_0 is initialised as the "radius" of the lattice;
  double sigma_0 =
      sqrt((0.5 * rowNum) * (0.5 * rowNum) + (0.5 * colNum) * (0.5 * colNum));
  // Define the sigma value in each epoch t;
  double sigma_t = sigma_0;
  // Define the attenuation speed of sigma with epoches;
  double tau_1 = 1000 / log(sigma_0);

  // Load the MNIST dataset in;
  vector<vector<double>> simples;
  struct info simpleInfo = dlmread("./SOM_MNIST_data.txt", simples);
  cout << "MNIST data are successfully loaded." << endl;

  // Define the weight vector of each neuron and randomly initialise them
  vector<vector<double>> weights(rowNum * colNum);
  initWeightVertor(simpleInfo.simpleLength, weights);
  vector<vector<double>> weightsOld = weights;
  savePictureData("./data.txt", weights);
  // Start training the SOM neural network, where t indexes the epoch;

  // std::ofstream  ds("./distance.txt", std::fstream::out |
  // std::fstream::trunc);

  for (int i = 1; i <= epochNumOrd + epochNumCov; i++) {

    // At each epoch, randomly shuffle data first;
    unsigned seed = chrono::system_clock::now().time_since_epoch().count();
    shuffle(simples.begin(), simples.end(), default_random_engine(seed));
    for (int j = 0; j < simpleInfo.simpleNumber; j++) {
      // Calculate the (squared) Euclidean distance of x from each neuron;
      vector<double> sqEucDist(weights.size(), 0);
      computeSquaredEuclideanDistances(sqEucDist, simples[j], weights);
      //  Obtain the coordinates of the winning neuron in the 2D lattice;
      int winnerIndex =
          min_element(sqEucDist.begin(), sqEucDist.end()) - sqEucDist.begin();
      // Calculate the (squared) Euclidean distance of this winnung neuron from
      // all neurons;
      //  This is to obtain the neighborhood of the winning neuron;
      vector<double> sqEucDistNeighborhood(weights.size(), 0);
      computeDistances(sqEucDistNeighborhood, winnerIndex, colNum, rowNum);

      //  Compute the value of the neighborhood function h();
      vector<double> h(weights.size(), 0);
      computeH(h, sqEucDistNeighborhood, sigma_t);

      // Updating the weight vectors of all neurons;
      updateWeight(weights, h, simples[j], eta_t);
    }

    if (eta_t > 0.01) {
      eta_t = eta_0 * exp(-i / tau_2);
    } else {
      eta_t = 0.01;
    }

    sigma_t = sigma_0 * exp(-i / tau_1);
    // ds << diff(weights,weightsOld) << " ";
    // ds.close();
    std::ofstream ds("./distance.txt", std::fstream::out | std::fstream::app);
    ds << diff(weights, weightsOld) << " ";
    ds.close();
    weightsOld = weights;
    if (i % 500 == 1) {
      cout << "Now in epoch-" << i << endl;
      savePictureData("./data" + std::to_string(i) + ".txt", weights);
    }
  }
  // ds << "\n";
  // ds.close();
  return 0;
}
