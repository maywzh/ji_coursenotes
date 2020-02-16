/*
Date: 5/29/2016
Programer: Urs Evora
Header file for Neurons.
*/

#ifndef NEURON_H
#define NEURON_H

#include <vector>

class Neuron{
public:
	// Contructor for Neuron. numSynapse: number of inputs synapse required for 
	// this neuron. Typically this is the number of neurons in the previous layer,
	// or number of features.
	Neuron(const int& numSynapse, const double& learningRate );
	
	//Activates neuron and synapse. inputs: vector of input features.
	double activate(const std::vector<double>& inputs);

	//Back propagate
	double backProp(const std::vector<double>& deltaIn, const std::vector<double>& forwardSynapse); 
	
	// Returns the weight of requested synapse.
	double getSynapse(const int& index) const;
	
	// Returns output from last activation.
	double getOutput() const;

	// Returns delta from last back propagation.
	double getDelta() const;
private:
	std::vector<double> synapse;
	double bias;
	const double learningRate;
	// stores last activation's inputs. Used for back propagation and debugging.
	std::vector<double> lastInputs;
	// stores	last activation's output. Also used for back propagation and debugging.
	double lastOutput;
	// error from last back propagation.	
	double delta;

	// Helper function which updates weights of the synapse during back propagate.
	//void updateSynapse();
};


// Returns random double between 0 and 1.
//double randD();
// Calculates sigmoid function
double sigmoid(const double& x);
#endif
