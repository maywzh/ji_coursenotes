#include "matrix.h"
#include "neuralnet.h"
#include <iostream>

using namespace std;

int main()
{
	Matrix input{1, 2, {{1, 2}}};
	Matrix WeightIH1{2, 2, {{3, 2}, {1, 4}}};
	Matrix WeightIH2{2, 2, {{3, 5}, {2, 1}}};
	Matrix bias1{1, 2, {{1, 1}}};
	Matrix bias2{1, 2, {{1, 1}}};
	Matrix inputs{1, 2, {{1, 2}}};
	vector<Matrix> weights{WeightIH1, WeightIH2};
	vector<Matrix> biases{bias1, bias2};
	vector<int> hidden{2, 2};
	NeuralNet nn{2, 2, hidden, weights, biases, inputs};
	nn.feedForward(input);
	cout << nn;
}