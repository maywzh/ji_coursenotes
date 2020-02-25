
#include <iostream>
#include <fstream>
#include <ctime> // seed random
#include <algorithm>  // max
#include <string>
#include "NN.h"
#include "dataset.h"
#include "layer.h"
#include <Eigen/Core>

using Eigen::MatrixXf;
using namespace std;

// constructor
neuralNetwork::neuralNetwork(int p_hidden_layer, 
	int p_input_units, int p_output_units, int p_maxout_units, int p_maxout_pieces, 
	int p_batch_size, float p_dropout_input, float p_dropout_hidden, float p_max_col_norm)
{	
	n_hidden_layers = p_hidden_layer;
	batch_size = p_batch_size;
	input_units = p_input_units;
	output_units = p_output_units;
	maxout_units = p_maxout_units;
	maxout_pieces = p_maxout_pieces;
	dropout_input = p_dropout_input;
	dropout_hidden = p_dropout_hidden;
	max_col_norm = p_max_col_norm;
	
	// memory allocations
	hidden_layer = new maxout_layer*[n_hidden_layers];
	hidden_layer[0] = new maxout_layer(input_units, maxout_units, maxout_pieces, 
							&x, NULL,
							batch_size, dropout_input, 1., max_col_norm);
	for(int i = 1; i<n_hidden_layers;i++) hidden_layer[i] = new maxout_layer(maxout_units, maxout_units, maxout_pieces, 
							&(hidden_layer[i-1]->y), &(hidden_layer[i-1]->dEdy),
							batch_size, dropout_hidden, dropout_hidden, max_col_norm);										
	output_layer = new softmax_layer(maxout_units, output_units,
							&(hidden_layer[n_hidden_layers-1]->y), &(hidden_layer[n_hidden_layers-1]->dEdy),
							batch_size, dropout_hidden, dropout_hidden, max_col_norm);
	
	x.resize(batch_size,input_units);
}

// Initialization
void neuralNetwork::init()
{
	//seed random number generator
	//srand((unsigned int)time(0));
	for (int i = 0; i < n_hidden_layers;i++) hidden_layer[i]->init();
	output_layer->init();
}

void neuralNetwork::fProp(MatrixXf* p_x, bool test)
{	
	// save the input
	x = *p_x;
	
	// forward propagate the activation through the layers
	for (int i = 0; i < n_hidden_layers; i++) hidden_layer[i]->fprop(test);
	output_layer->fprop(test);
}

void neuralNetwork::bProp(MatrixXf* t, float LR, float momentum)
{
	// backpropagate the error through the layers
	output_layer->bprop(t,LR,momentum);
	for (int i = n_hidden_layers-1; i >= 0; i--) hidden_layer[i]->bprop(LR,momentum);
}

void neuralNetwork::train(dataSet* set, float LR, float momentum)
{
	// for every training pattern batch
	for (int j = 0; j < set->size; j++)
	{	
		//feed inputs through network
		fProp(set->pattern[j],false);
		
		// backpropagate error gradient and update weights
		bProp(set->target[j],LR, momentum);
	}
}

// Return the NN accuracy on the set
void neuralNetwork::test(dataSet* set, float* error, float* nll)
{
	*error = 0;
	*nll = 0;
	int outputIndex;
	int targetIndex;
	
	// for every batch
	for (int i = 0; i < set->size; i++)
	{
		// feed inputs through network
		fProp(set->pattern[i], true);		
		
		// count the errors on the batch
		for (int k =0; k<batch_size;k++)
		{
			// get the best bet of the NN
			outputIndex = output_layer->getLineMaxIndex(&(output_layer->y),k);
			
			// get the right answer
			targetIndex = output_layer->getLineMaxIndex(set->target[i],k);

			// increment error for a incorrect result
			if (targetIndex != outputIndex) *error += 1;
		}
		
		// nll sum of the batch
		*nll += output_layer->nll_sum(set->target[i]);		
	}

	// compute the error rate
	*error /= set->size * batch_size;
	*error *= 100;
	
	// compute the mean nll on the dataset
	*nll /= set->size * batch_size;
}

void neuralNetwork::save()
{
	for (int k = 0; k < n_hidden_layers; k++) hidden_layer[k]->save();
	output_layer->save();
}

void neuralNetwork::load()
{
	for (int k = 0; k < n_hidden_layers; k++) hidden_layer[k]->load();
	output_layer->load();
}

