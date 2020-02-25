
#include <math.h>
#include <iostream>
#include <random>
#include <time.h>
#include "layer.h"
#include <ctime>
using namespace std;

void layer::save()
{
	w_best = w;
	b_best = b;
}

void layer::load()
{
	w = w_best;
	b = b_best;
}

void layer::fprop_weighted_sum(bool test)
{
    
    clock_t start_time;
    float elapsed_time;
    
    // cin.get();
    
	if(test) z = (*x) * w.transpose() * scale + MatrixXf::Constant(batch_size,1,1) * b;
	else
	{
		dropout();
		*x = (*x).cwiseProduct(dropout_mask);
		z = (*x) * w.transpose() + MatrixXf::Constant(batch_size,1,1) * b;
	}
}

void layer::bprop_weighted_sum()
{		
	// we don't need that part for the first hidden layer
	*dEdx = dEdz * w;
	*dEdx = (*dEdx).cwiseProduct(dropout_mask);
}

void layer::update(float LR, float momentum)
{		
	// gradient of parameters
	dEdb = MatrixXf::Constant(1,batch_size, 1) * dEdz; // dE/db = dz/db * dE/dz with dz/db = 1
	dEdw = dEdz.transpose() * (*x); // dE/dw = dz/dw * dE/dz with dz/dw = x
	
	// update
	update_b = update_b * momentum + dEdb * (LR * (1-momentum));
	update_w = update_w * momentum + dEdw * (LR * (1-momentum));
	b = b + update_b;
	w = w + update_w;

	// regularization
	column_normalization();
}

void layer::dropout()
{
	for (int i = 0; i<dropout_mask.rows(); ++i) 
	{
		for (int j = 0; j < dropout_mask.cols(); ++j) 
		{	
			if ( rand() <= activation_rate * RAND_MAX ) dropout_mask(i,j) = true;
			else dropout_mask(i,j) = false;
		}
	}
}

// in fact not columns, lines: I don't use the same conventions for my weight matrix than Ian
// It is like every neuron has a maximum incoming energy
void layer::column_normalization()
{
	float norm;
	
	for(int i=0;i<w.rows();i++)
	{
		norm = 0;
		
		for (int j = 0; j <w.cols(); ++j)
		{
			norm += w(i,j) * w(i,j);
		}
		
		norm = sqrt(norm);
		
		if(norm>max_col_norm)
		{
			norm = max_col_norm/norm;
			
			for (int j = 0; j <w.cols(); ++j)
			{
				w(i,j) = w(i,j) * norm;
			}
			
		}
		
		else
		{
			for (int j = 0; j <w.cols(); ++j)
			{
				w(i,j) = w(i,j);
			}
		}
	}
}

maxout_layer::maxout_layer(int p_n_inputs, int p_n_units, int p_n_pieces,
		MatrixXf* p_x, MatrixXf* p_dEdx, 
		int p_batch_size, float p_activation_rate, float p_scale, float p_max_col_norm)
{
	n_inputs = p_n_inputs;
	n_units = p_n_units;
	n_pieces = p_n_pieces;
	
	batch_size = p_batch_size;
	activation_rate = p_activation_rate;
	scale = p_scale;
	max_col_norm = p_max_col_norm;
	
	x = p_x;
	dEdx = p_dEdx;
	
	// Dynamic memory allocations
	w.resize(n_units*n_pieces,n_inputs);
	w_best.resize(n_units*n_pieces,n_inputs);
	dEdw.resize(n_units*n_pieces,n_inputs); 
	update_w.resize(n_units*n_pieces,n_inputs);
	
	b.resize(1,n_units*n_pieces);
	b_best.resize(1,n_units*n_pieces);
	dEdb.resize(1,n_units*n_pieces); 
	update_b.resize(1,n_units*n_pieces);
	
	z.resize(batch_size,n_units*n_pieces);
	dEdz.resize(batch_size,n_units*n_pieces);
	
	y.resize(batch_size,n_units);
	dEdy.resize(batch_size,n_units);
	
	dropout_mask.resize(batch_size,n_inputs);
}


void maxout_layer::maxout()
{
	for(int i=0;i<y.rows();i++)
	{
		for (int j = 0; j <y.cols(); ++j)
		{						
			y(i,j) = z(i,j*n_pieces);
			
			for (int k = 1; k <n_pieces; k++)
			{
				if(z(i,j*n_pieces+k)>y(i,j))y(i,j) = z(i,j*n_pieces+k);
			}	
		}
	}
}

void maxout_layer::maxout_derivative()
{	
	dEdz.setZero();
	int max_index;
	float max;
	
	for(int i=0;i<dEdz.rows();i++)
	{
		for (int j = 0; j <dEdz.cols()/n_pieces; ++j)
		{	
			max_index = 0;
			max = z(i,j*n_pieces);
			
			for (int k = 1; k<n_pieces; k++)
			{				
				if (z(i,j*n_pieces+k)>max) 
				{
					max = z(i,j*n_pieces+k);
					max_index = k;
				}
			}
			
			dEdz(i,j*n_pieces+max_index) = dEdy(i,j);
		}
	}
}


void maxout_layer::init()
{
	b.setZero();
	update_b.setZero();
	
	// init w randomly
	float range = sqrt(6. / ((float)(w.rows() + w.cols())));

	for (int i = 0; i<w.rows(); ++i) 
	{
		// initialize in [-range;range]
		for (int j = 0; j < w.cols(); ++j) 
		{	
			w(i,j) = ((float)rand() / (float)RAND_MAX) * 2 * range - range;
		}
	}
	
	update_w.setZero();
}

void maxout_layer::fprop(bool test)
{
	fprop_weighted_sum(test);
	maxout();
}

void maxout_layer::bprop(float LR, float momentum)
{
	maxout_derivative();
	if(dEdx != NULL) 
	{
		bprop_weighted_sum();
		*dEdx = (*dEdx).cwiseProduct(dropout_mask);
	}
	update(LR, momentum);
}

softmax_layer::softmax_layer(int p_n_inputs, int p_n_units,
		MatrixXf* p_x, MatrixXf* p_dEdx,
		int p_batch_size, float p_activation_rate, float p_scale, float p_max_col_norm)
{
	n_inputs = p_n_inputs;
	n_units = p_n_units;
	
	batch_size = p_batch_size;
	activation_rate = p_activation_rate;
	scale = p_scale;
	max_col_norm = p_max_col_norm;
	
	x = p_x;
	dEdx = p_dEdx;
	
	// Dynamic memory allocations
	w.resize(n_units,n_inputs);
	w_best.resize(n_units,n_inputs);
	dEdw.resize(n_units,n_inputs); 
	update_w.resize(n_units,n_inputs);
	
	b.resize(1,n_units);
	b_best.resize(1,n_units);
	dEdb.resize(1,n_units); 
	update_b.resize(1,n_units);
	
	z.resize(batch_size,n_units);
	dEdz.resize(batch_size,n_units);
	
	y.resize(batch_size,n_units);
	
	dropout_mask.resize(batch_size,n_inputs);
}

void softmax_layer::softmax()
{
	float sum;
	float buffer[z.cols()];
	
	for(int i=0;i<y.rows();i++)
	{
		sum = 0;
		
		for (int j = 0; j <y.cols(); ++j)
		{
			buffer[j] = z(i,j);
			buffer[j] = exp(buffer[j]);
			sum += buffer[j];
		}
		
		for (int j = 0; j < y.cols(); ++j)
		{			
			y(i,j) = (buffer[j]/sum);
		}
	}
}
	
void softmax_layer::init()
{
	b.setZero();
	update_b.setZero();
	
	w.setZero();
	update_w.setZero();
}

void softmax_layer::fprop(bool test)
{
	fprop_weighted_sum(test);	
	softmax();
}

void softmax_layer::bprop(MatrixXf* t, float LR, float momentum)
{	
	// The error function is the mean of NLL of the outputs
	// The output layer activation is Softmax
	// There is a simplification between the gradient of Softmax activation and the gradient of the NLL error
	dEdz = (*t - y)/n_units;
	if(dEdx != NULL) 
	{
		bprop_weighted_sum();
		*dEdx = (*dEdx).cwiseProduct(dropout_mask);
	}
	update(LR, momentum);
}

float softmax_layer::nll_sum(MatrixXf* t)
{
	float sum = 0;
	
	for (int i = 0; i<y.rows(); ++i) 
	{
		for (int j = 0; j < y.cols(); ++j) 
		{	
			if((*t)(i,j)==1.) sum -= log(y(i,j));
		}
	}
	
	return sum;
}

int softmax_layer::getLineMaxIndex(MatrixXf* X, int line)
{
	int maxIndex = 0;

	for (int i = 1; i < (*X).cols(); i++)
	{
		if ((*X)(line,i)>(*X)(line,maxIndex)) maxIndex = i;
	}

	return maxIndex;
}
