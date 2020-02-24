#include "neuralnet.h"
#include <math.h>
#include <iostream>

using namespace std;

NeuralNet::NeuralNet(int input_size, int output_size, std::vector<int> hidden_sizes, Matrix inputs, Matrix outputs) : input_size{input_size}, output_size{output_size}, hidden_sizes{hidden_sizes}, inputs{inputs}, outputs{outputs}
{
	int prev_dim = inputs.getCols();
	for (unsigned int i = 0; i < hidden_sizes.size(); ++i)
	{
		Matrix weight_layer{prev_dim, hidden_sizes[i]};
		prev_dim = hidden_sizes[i];
		weight_layer.initNormal();
		weights.emplace_back(weight_layer);
		intermediates.emplace_back(Matrix{0, 0});
	}

	Matrix last_layer{prev_dim, outputs.getCols()};
	last_layer.initNormal();
	weights.emplace_back(last_layer);
	intermediates.emplace_back(Matrix{0, 0});
}

NeuralNet::NeuralNet(int input_size, int output_size, std::vector<int> hidden_sizes, std::vector<Matrix> &weights, std::vector<Matrix> &biases, Matrix inputs) : input_size{input_size}, output_size{output_size}, hidden_sizes{hidden_sizes}, inputs{inputs}
{
	int totalsize = weights.size();
	int m, n, bm, bn;
	for (unsigned int i = 0; i < totalsize; i++)
	{
		m = weights[i].getRows();
		n = weights[i].getCols();
		bm = biases[i].getRows();
		bn = biases[i].getCols();
		Matrix weight_layer{m, n, weights[i].getVector()};
		Matrix bias{bm, bn, biases[i].getVector()};
		this->weights.push_back(weight_layer);
		this->biases.push_back(bias);
		intermediates.push_back(Matrix{0, 0});
	}

}

double NeuralNet::sigmoid(double n, bool deriv)
{
	if (deriv)
	{
		return sigmoid(n) * (1 - sigmoid(n));
	}
	else
	{
		return 1 / (1 + exp(-n));
	}
}

double NeuralNet::relu(double n, bool deriv)
{
	if (deriv)
	{
		return n > 0 ? 1 : 0;
	}
	else
	{
		return n > 0 ? n : 0;
	}
}

double NeuralNet::htan(double n, bool deriv)
{
	if (deriv)
	{
		return 1 - pow(tanh(n), 2);
	}
	else
	{
		return tanh(n);
	}
}

Matrix NeuralNet::feedForward(Matrix input)
{
	Matrix result = input;
	for (unsigned int i = 0; i < weights.size(); ++i)
	{
		result = result * weights[i] + biases[i];
		result = activate(sigmoid, result);
		intermediates[i] = result;
	}

	return result;
}

void NeuralNet::backProp(int batch_size)
{
	vector<Matrix> input_batch;
	vector<Matrix> output_batch;

	if (batch_size == 0)
	{
		input_batch.emplace_back(inputs);
		output_batch.emplace_back(outputs);
	}
	else
	{
		int batches = ceil(inputs.getRows() / batch_size);
		for (int i = 0; i < batches; ++i)
		{
			int a = i * batch_size;
			int b = min(inputs.getRows() - 1, a + batch_size - 1);

			vector<vector<double>> input_batch_vector;
			vector<vector<double>> output_batch_vector;

			for (int i = a; i <= b; ++i)
			{
				input_batch_vector.emplace_back(inputs.getVector()[i]);
				output_batch_vector.emplace_back(outputs.getVector()[i]);
			}

			Matrix in_matrix{batch_size, inputs.getCols(), input_batch_vector};
			Matrix out_matrix{batch_size, outputs.getCols(), output_batch_vector};

			input_batch.emplace_back(in_matrix);
			output_batch.emplace_back(out_matrix);
		}
	}

	for (unsigned int i = 0; i < input_batch.size(); ++i)
	{
		Matrix input = input_batch[i];
		Matrix output = output_batch[i];

		Matrix error = output - feedForward(input);
		for (int i = intermediates.size() - 1; i >= 0; --i)
		{
			Matrix delta = error.unitMultiply(activate(sigmoid, intermediates[i], true));
			if (i == 0)
			{
				weights[i] = weights[i] + input.transpose() * delta;
			}
			else
			{
				weights[i] = weights[i] + intermediates[i - 1].transpose() * delta;
			}

			error = delta * weights[i].transpose();
		}
	}
}

double square(double n)
{
	return pow(n, 2.0);
}

double NeuralNet::loss()
{
	Matrix result = feedForward(inputs);
	Matrix delta = outputs - result;
	delta.apply(square);
	int size = delta.getRows() * delta.getCols();

	return delta.sum() / size;
}

Matrix NeuralNet::getWeights(int i)
{
	return weights[i];
}

void NeuralNet::train(int epochs)
{
	for (int i = 0; i < epochs; ++i)
	{
		backProp(4);
		if (i % 1000 == 0)
		{
			cout << "Error: " << loss() << " after " << i << " epochs" << endl;
		}
	}
}

Matrix NeuralNet::predict(Matrix input)
{
	Matrix result = input;
	for (unsigned int i = 0; i < weights.size(); ++i)
	{
		result = result * weights[i];
		result = activate(sigmoid, result);
	}

	return result;
}

ostream &operator<<(ostream &out, const NeuralNet &nn)
{
	for (int i = 0; i < nn.weights.size(); i++)
	{
		cout << i << "th weight matrix" << endl;
		cout << nn.weights[i];
	}
	cout << "input:" << endl;
	cout << nn.inputs;
	for (int i = 0; i < nn.intermediates.size(); i++)
	{
		cout << i << "th intermediate layer" << endl;
		cout << nn.intermediates[i];
	}
}