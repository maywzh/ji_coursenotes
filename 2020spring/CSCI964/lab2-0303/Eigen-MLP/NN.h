/*****************************************************************
DEEP MLP
Written by Matthieu Courbariaux in 2014

Specifications of the model :
- layers fully connected
- hidden layers activation function : Maxout
- output layer activation function : Softmax
- hidden layers weights initialized randomly
- hidden layer bias initialized to 0
- output layer initialized to 0
- Stochastic Gradient Descent with mini batches
- loss function : NLL
- dropout on input and hidden layers
- regularization : max column norm
*******************************************************************/

#ifndef NNetwork
#define NNetwork

#include "dataset.h"
#include "layer.h"
#include <Eigen/Core>
using Eigen::MatrixXf;

class neuralNetwork
{

public:
	
	MatrixXf x;
	
	maxout_layer** hidden_layer;
	softmax_layer * output_layer;
	
	int n_hidden_layers;
	int batch_size;	
	int input_units;
	int output_units;
	int maxout_units;
	int maxout_pieces;
	float dropout_input;
	float dropout_hidden;
	float max_col_norm;	

	//constructor & destructor
	neuralNetwork(int p_hidden_layer, int p_input_units, int p_output_units, int p_maxout_units, int p_maxout_pieces, 
		int p_batch_size, float p_dropout_input, float p_dropout_hidden, float p_max_col_norm);
		
	~neuralNetwork(){}

	//weight operations
	void init();
	void fProp(MatrixXf* p_x, bool test);
	void bProp(MatrixXf* t, float learningRate, float momentum);
	void test(dataSet* set, float* error, float* nll);// Return the NN accuracy on the set
	void train(dataSet* set, float LR, float momentum);
	void save();
	void load();
};

#endif
