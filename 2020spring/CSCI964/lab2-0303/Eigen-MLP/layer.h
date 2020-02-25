
#ifndef NNLayer
#define NNLayer

#include <Eigen/Core>
using Eigen::MatrixXf;
using namespace std;

class layer
{

public:
	
	int n_inputs;
	int n_units;
	
	int batch_size;
	float activation_rate;
	float scale;
	float max_col_norm;
	
	MatrixXf w; // weight matrix
	MatrixXf w_best;
	MatrixXf dEdw; 
	MatrixXf update_w;
	
	MatrixXf b; // bias vector
	MatrixXf b_best;
	MatrixXf dEdb; 
	MatrixXf update_b;
	
	MatrixXf* x;
	MatrixXf y;
	
	MatrixXf* dEdx;
	
	MatrixXf z;
	MatrixXf dEdz;
	
	MatrixXf dropout_mask;
	
	layer(){}
	~layer(){}
	
	void save();
	void load();
	void fprop_weighted_sum(bool test);
	void bprop_weighted_sum();
	void update(float LR, float momentum);
	
	// dropout
	void dropout();

	// L2 constraint on the inputs of each unit
	void column_normalization();
};

class maxout_layer: public layer
{

public:
	
	int n_pieces;
	MatrixXf dEdy;
	
	maxout_layer(){}
	~maxout_layer(){}
	
	maxout_layer(int p_n_inputs, int p_n_units, int p_n_pieces,
			MatrixXf* x, MatrixXf* dEdx,
			int p_batch_size, float p_activation_rate, float p_scale, float p_max_col_norm);
	
	void maxout();
	void maxout_derivative();
	void init();
	void fprop(bool test);
	void bprop(float LR, float momentum);
};

class softmax_layer: public layer
{

public:
	
	softmax_layer(){}
	~softmax_layer(){}
	
	softmax_layer(int p_n_inputs, int p_n_units,
			MatrixXf* x, MatrixXf* dEdx,
			int p_batch_size, float p_activation_rate, float p_scale, float p_max_col_norm);
	
	void softmax();
	void init();
	void fprop(bool test);
	void bprop(MatrixXf* t, float LR, float momentum);
	
	// cost functions
	int getLineMaxIndex(MatrixXf* X, int line);
	float nll_sum(MatrixXf* t);
};

#endif
