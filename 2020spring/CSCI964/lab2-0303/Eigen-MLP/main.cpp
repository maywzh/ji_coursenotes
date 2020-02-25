
#include <iostream>
#include "dataset.h"
#include "train.h"
#include <Eigen/Core>
using namespace std;

int main(int argc, char* argv[])
{
	cout << endl << "-- BEGINNING OF PROGRAM --" << endl<<endl;	
	
	// set the number of threads for openmp
	// I have 12 cores on 2 sockets
	// 12 cores -> 30 secondes per epoch
	// 2 cores -> 35 secondes per epoch
	// 1 core -> 45 secondes per epoch
	Eigen::setNbThreads(4);
    // int n = 1;
    // Eigen::setNbThreads(atoi(argv[n++]));
	cout<<"Number of threads: "<<Eigen::nbThreads()<<endl<<endl;	
	
	cout<<"Hyper-parameters: "<<endl<<endl;
	
	// MLP parameters
	int nHLayer = 3; // min = 1, otherwise it is not a MLP
	cout<<"Number of hidden layers: "<<nHLayer<<endl;	
	int maxout_units = 240; 
	cout<<"Maxout units: "<<maxout_units<<endl;
	int maxout_pieces = 5;
	cout<<"Maxout pieces: "<<maxout_pieces<<endl;
	
	// SGD parameters
	float learningRate = .1;
	cout<<"Learning rate: "<<learningRate<<endl;
	float LR_decay = .992;
	cout<<"Learning rate decay factor: "<<LR_decay<<endl;
	float momentum = .9;
	cout<<"Momentum: "<<momentum<<endl;
	int nEpochs = 1000;
	cout<<"nEpochs: "<<nEpochs<<endl;
	int batch_size = 100;
	cout<<"Batch size: "<<batch_size<<endl;
	float dropout_input = .8;
	cout<<"Dropout input layer: "<<dropout_input<<endl;
	float dropout_hidden = .5;
	cout<<"Dropout hidden layers: "<<dropout_hidden<<endl;
	float max_col_norm = 2.;
	cout<<"Max column norm: "<<max_col_norm<<endl;
	
	// load trainingSet
	dataSet *trainingSet; //create data set pointer
	trainingSet = new dataSet;
	trainingSet->loadPatterns("/data/lisa/data/mnist/train-images-idx3-ubyte", batch_size);
	trainingSet->loadTargets("/data/lisa/data/mnist/train-labels-idx1-ubyte", batch_size);
	
	// split training set to create validation set
	dataSet *validationSet = trainingSet->split(batch_size);

	// load testSet
	dataSet *testSet; //create data set pointer
	testSet = new dataSet;
	testSet->loadPatterns("/data/lisa/data/mnist/t10k-images-idx3-ubyte", batch_size);
	testSet->loadTargets("/data/lisa/data/mnist/t10k-labels-idx1-ubyte", batch_size);
	
	// neural network creation
	neuralNetwork* NN; // create a neural network pointer
	NN = new neuralNetwork(nHLayer, 784, 10, maxout_units, maxout_pieces, 
		batch_size, dropout_input, dropout_hidden, max_col_norm);
	
	// neural network training
	trainNetwork(NN, trainingSet, validationSet, testSet, 
		learningRate, LR_decay, momentum, 
		nEpochs);
	
	cout << endl << "-- END OF PROGRAM --" << endl << endl;
	return 1;
}
