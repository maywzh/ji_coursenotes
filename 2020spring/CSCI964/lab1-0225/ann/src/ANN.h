/*
Date: 5/29/2016
Programer: Urs Evora
Header file for ANN.
*/


#ifndef ANN_H
#define ANN_H

#include <vector>
#include "Neuron.h"
#include "Instance.h"

class ANN{
 
public:
	//ANN(const int& numFeatures, const std::vector<int>& layers, const double& learningRate);
	
	// Contructor for ANN. NumFeatures: number of input nodes for the network.
	// Layers: The size of passed vector determines number of layers. Integers
	// provided in each index determine number of neurons in each layer. Output
	// layer is last layer in vector.
	ANN(const int& numFeatures, const std::vector<int>& layers, const double& learningRate,
	const std::string& name = "UNNAMED");
	
	// Copy constructor
	ANN( const ANN& rhs );
	
	//Destructor
	~ANN(); 

	// Trains ANN on passed instance by classifying and performing back 
	// propagation. instance: vector of features, must be equal
	// to numFeatures. expected: Desired/expected classifications of output 
	// neurons. Also expected to be of same size of output layer.
	void train(const std::vector<double>& instance, const std::vector<double>& expected,
	std::vector<double>& result );
	
	// Wrapper to other train function. Uses Instance class instead.
	void train(const Instance& instance, std::vector<double>& result );
	
	// Wrapper to other activate function. Uses Instance class instead.
	void activate(const Instance& instance, std::vector<double>& result );
	
	// Activates on given inputs. No back propagation. See train() for parameter
	// definitions.
	void activate(const std::vector<double>& instance, std::vector<double>& result);

	// Checks if the instance fits Instance set
	bool checkInstance( const Instance& inst ) const;
		
	// Returns name of the ANN
	std::string getName() const;
	
	// Returns number of output neurons.
	int getNumOut() const;
	// Returns number of input neurons.
	int getNumIn() const;
	// Returns number of layers (hidden + output layers).
	int getNumHidLayers() const;
	// Returns number of neurons in a layer. layer: layer index number.
	int getNumNeurons( const int& layer ) const;
	
	// Returns synapse weights for all layers.
	void getNetSynapse() const;


private:
	const int numIn;
	const int numOut;
	const double learningRate;
	const std::string name;
	std::vector<std::vector<Neuron*> > network;
	
	// Returns layer's outputs. Clears result vector before adding data.
	// Assumes valid layer number.
	void getOutputs( const int& layer, std::vector<double>& result ) const;
	
	// Generates a matrix consisting of a layer's synapse. Clears provided matrix
	// before modifying. Each sub vector is with respect to lower layer's synapse.
	// Cannot be last index.
	void getFS(const int& layer, std::vector<std::vector<double>*>& result ) const;
	
	// Returns layer's error. Clears result vector before adding data.
	// Assumes valid layer number.
	//void getDeltas( const int& layer, std::vector<double>& result )const;
	
	// Calculates the error between the output and the expected value. Clears passed
	// in error vector before calculating.
	// Expected: Expected value vector. outputs: output value vector from last activation.
	// error: resulting vector.
	void calculateError( const std::vector<double>& expected, const std::vector<double>& outputs,
		std::vector<double>& error);
	

};

bool operator==( const ANN& left, const ANN& right );

bool operator==( const ANN& left, const std::string& right);


#endif
