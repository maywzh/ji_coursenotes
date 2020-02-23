#ifndef _NEURALNET_H_
#define _NEURALNET_H_
#include "matrix.h"

class NeuralNet {
public:
	// constructor
	NeuralNet(int input_size, int output_size, std::vector<int> hidden_sizes, Matrix inputs, Matrix outputs);
	NeuralNet(int input_size, int output_size, std::vector<int> hidden_sizes, std::vector<Matrix> weights, std::vector<Matrix> biases, Matrix inputs);
	// activation functions
	static double sigmoid(double n, bool deriv = false);
	static double relu(double n, bool deriv = false);
	static double htan(double n, bool deriv = false);

	template<typename F> static double activate(F f, double n, bool deriv = false) {
		return f(n, deriv);
	}

	template<typename F> static std::vector<double> activate(F f, std::vector<double> v, bool deriv = false) {
		std::vector<double> result = v;
		for (auto &n: result) {
			if (deriv) {
				n = f(n, true);
			}
			else {
				n = f(n, false);
			}
		}

		return result;
	}

	template<typename F> static Matrix activate(F f, Matrix m, bool deriv = false) {
		std::vector<std::vector<double>> vector = m.getVector();
		for (auto &v: vector) {
			if (deriv) {
				v = activate(f, v, true);
			}
			else {
				v = activate(f, v);
			}
		}

		Matrix result {m.getRows(), m.getCols(), vector};

		return result;
	}

	// loss function (average sum of squares)
	double loss();

	// propogation
	Matrix feedForward(Matrix input);
	void backProp(int batch_size = 0);
	void setInitialWeight(std::vector<Matrix> &weights){

}
	// ith weight matrix accessor
	Matrix getWeights(int i);

	// using the model
	void train(int epochs);
	Matrix predict(Matrix input);
	// stream operator
	friend std::ostream &operator<<(std::ostream &out, const NeuralNet &nn);

private:
	const int input_size;
	const int output_size;
	const std::vector<int> hidden_sizes;

	std::vector<Matrix> intermediates;

	Matrix inputs;
	std::vector<Matrix> weights;
	std::vector<Matrix> biases;
	Matrix outputs;
};

#endif