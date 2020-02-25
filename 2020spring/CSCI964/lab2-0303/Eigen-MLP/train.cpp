
#include "train.h"
#include "dataset.h"
#include <iostream>
using namespace std;

// Train the NN using gradient descent
void trainNetwork(neuralNetwork* NN, dataSet* trainingSet, dataSet* validationSet, dataSet* testSet, 
	float learningRate, float LR_decay, float momentum,
	int nEpochs)
{
    int best_epoch;
	float LR = learningRate;
	float best_LR = learningRate;
	float validation_error;
	float best_validation_error = 100.;
	float validation_nll;
    float best_validation_nll = 1;
	float test_error;
	float test_nll;
	float train_error;
	float train_nll;
    double elapsed_time;
	
	// initialize the neural network
	NN->init();
	
	// phase 1:
	cout << endl << "Training on the training set for "<<nEpochs<<" epochs..." << endl;
	
	for(int epoch=1; epoch<=nEpochs;epoch++)
	{		
        elapsed_time = omp_get_wtime();
        
		// train the model on the train set
		NN->train(trainingSet, LR, momentum);
		
		// validation test
		NN->test(validationSet,&validation_error, &validation_nll);
		
        elapsed_time = omp_get_wtime()-elapsed_time;
        
		// monitoring
		cout <<endl<<"Epoch "<<epoch;
		cout <<endl<<"	elapsed_time = " << elapsed_time<<"s";
		cout <<endl<<"	learning rate = " << LR;
		cout <<endl<<"	validation_nll = "<< validation_nll;
		cout <<endl<<"	validation error rate = "<< validation_error <<"%";
		
		// Save the model
		if (validation_error <= best_validation_error)
		{	
            best_validation_error=validation_error;
            cout <<endl<<"	Saving the model... ";
			NN->save();
		}
		
		// update LR
		LR *= LR_decay;
	}
	
    cout <<endl<<endl<<"Testing on the test set..." << endl;
    
	// load the best parameters
	NN->init();
	NN->load();
	
	// get the train NLL
	NN->test(validationSet,&validation_error, &validation_nll);
    cout <<endl<<"	validation_nll = "<< validation_nll;
    cout <<endl<<"	validation error rate = "<< validation_error <<"%";
    NN->test(testSet,&test_error, &test_nll);
    cout <<endl<<"	test_nll = "<< test_nll;
    cout <<endl<<"	test error rate = "<< test_error <<"%"<< endl;
}


