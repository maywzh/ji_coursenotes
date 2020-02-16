/*
Date: 5/29/2016
Programer: Urs Evora
Implementation file for Neurons.
*/

#include <vector>
#include <iostream> 	// debug
//#include <stdlib.h> 	// random
#include <math.h> 		// exp
#include <time.h>			// time
#include "Neuron.h"
#include "utils.h"	

Neuron::Neuron(const int& numSynapse, const double& learningRate )
	:learningRate(learningRate),bias(randD()), delta(NULL), lastOutput(NULL){
	// Initialize synapse and last inputs
	//srand(time(NULL));
	for(int i = 0; i < numSynapse; i++){
		if(randD() > 0.5){	
			synapse.push_back(randD());
		}
		else{	
			synapse.push_back(-randD());
		}
		lastInputs.push_back(0);
	}
}

double Neuron::activate(const std::vector<double>& inputs){
	// Check if inputs are correct size	
	if( inputs.size() != synapse.size() ){ return -1; };
	lastInputs = inputs;
	double sum = bias;
	for( int i = 0; i < inputs.size(); i++ ){
		sum += inputs[i] * synapse[i];
	}
	lastOutput = sigmoid(sum);
	return lastOutput;
}

double Neuron::backProp(const std::vector<double>& deltaIn, 
const std::vector<double>& forwardSynapse){
	// Check if deltas equal forwardSynapse
	if( deltaIn.size() != forwardSynapse.size() ){ return -1; }
	// Calculate delta (node error)	
	double error = 0;
	for( int i = 0; i < deltaIn.size(); i++ ){
		error += deltaIn[i] * forwardSynapse[i];
	}
	delta = error * lastOutput * (1 - lastOutput);
	//delta = error * ( 1 - lastOutput * lastOutput );
	// Update synapse weights
	for( int i = 0; i < synapse.size(); i++ ){
		double temp = synapse[i] - learningRate * delta * lastInputs[i];
		//std::cout << "Temp: " << temp << std::endl;
		synapse[i] = temp;
	}
	bias = bias - learningRate * delta;
	return delta;
}

double Neuron::getSynapse(const int& index) const{
	// Check if valid index
	if( index >= synapse.size() ){ return -1;}
	return synapse[index];
}

double Neuron::getDelta() const{
	return delta;
}

double Neuron::getOutput() const{
	return lastOutput;
}



double sigmoid(const double& x){
	return 1.0/(1 + exp(-x));
	//return 2.0/(1 + exp(-2 * x));
}


