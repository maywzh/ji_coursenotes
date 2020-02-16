/*
Date: 6/1/2016
Programer: Urs Evora
Implementation file for ANN.
*/

#include <vector>
#include <iostream> 	// debug
#include <memory>			// smart pointers

#include "ANN.h"
#include "Neuron.h"
#include "Instance.h"

ANN::ANN(const int& numFeatures, const std::vector<int>& layers, const double& learningRate,
const std::string& name  )
	:numIn(numFeatures), learningRate(learningRate),numOut(layers[layers.size() - 1]),
	name(name){
	// Initialize layers of the network
	for( int i = 0; i < layers.size(); i++ ){
		std::vector<Neuron*> layer;
		// Initialize neurons for each layer.
		for( int j = 0; j < layers[i]; j++ ){
			// Input layer is dependent on number of Features.
			if( i == 0 ){
				layer.push_back(new Neuron(numFeatures, learningRate));
			}
			else{
				layer.push_back(new Neuron( layers[i-1], learningRate));
			}
		}
		// Add to network.
		network.push_back(layer);
	}
}


ANN::ANN( const ANN& rhs )
	:numIn(rhs.numIn), numOut(rhs.numOut), learningRate( rhs.learningRate ){
	std::vector<Neuron*> layer;
	for( int i = 0; i < rhs.network.size(); ++i){
		// Make new copies of Neuron
		for( int j = 0; j < rhs.network[i].size(); ++j){
			layer.push_back(new Neuron(*rhs.network[i][j]));
		}
		network.push_back(layer);
		layer.clear();
	}
}

ANN::~ANN(){
	for( std::vector<std::vector<Neuron*> >::iterator itr = network.begin(); itr != network.end(); ++itr){
		// Delete neurons
		for( int i = 0; i < itr->size(); ++i){
			delete (*itr)[i];
		}
	}
}




void ANN::activate(const std::vector<double>& instance, std::vector<double>& result ){
	result.clear();
	// Layer loop
	for( int i = 0; i < network.size(); i++){
		// Neuron loop. For every neuron, activate on output of previous layer
		// or instance if input layer.
		std::vector<double> lastOutputs;
		if( i != 0 ){ getOutputs( i - 1, lastOutputs);} 
		for( int j = 0; j < network[i].size(); j++ ){
			// if input layer, pass instance.
			if( i == 0 ){
				network[i][j]->activate( instance );
			}
			// Otherwise pass last layers outputs
			else{
				// If last activation, save outputs for return
				if( i == network.size() - 1 ){
					result.push_back(network[i][j]->activate(lastOutputs));
				}
				else{
					network[i][j]->activate(lastOutputs);
				}
			}
		}
	}
	//std::cout << "DONE" << std::endl;
}


void ANN::activate(const Instance& instance, std::vector<double>& result ){
	activate( *(instance.data), result );
}


void ANN::train(const std::vector<double>& instance, const std::vector<double>& expected,
	std::vector<double>& result ){
	activate( instance, result );
	std::vector<double> error;
	// Two delta vectors to 
	std::vector<double> delta1;
	std::vector<double> delta2;
	// Matricies for forward synapse
	std::vector<double> ones(network[network.size()-1].size(), 1.0);
	std::vector<std::vector<double>*> fs1; 
	std::vector<std::vector<double>*> fs2;
	bool deltaSet = false; // Flags for deltas
	calculateError( expected, result, error );
	//std::cout << "Error: " << error[0] << std::endl;
	//std::cout << "Error: " << error[1] << std::endl;
	//std::cout << "Error: " << error[2] << std::endl;
	for( int i = network.size() - 1; i >= 0; i--){
		// Get forward synapse before back prop
		if( !deltaSet ){ 
			deltaSet = true;
			delta1.clear();
			if( i != 0 ){
				getFS(i - 1, fs2);
			}
		}
		else{
			deltaSet = false;
			delta2.clear();
			if( i != 0 ){
				getFS(i - 1, fs1);
			}
		}
		for( int j = 0; j < network[i].size(); j++ ){
			// If output layer. Delta = error
			//std::cout << "I: " << i << " J: " << j << std::endl;
			if( i == network.size() - 1){
				delta1.push_back(network[i][j]->backProp(error, ones));
			}
			else{
				// Use second delta if odd i
			 	if( !deltaSet ){
			 		//std::cout << "HERE" << std::endl;
					delta2.push_back(network[i][j]->backProp(delta1, *fs2[j])); 
				}
				else{
					delta1.push_back(network[i][j]->backProp(delta2, *fs1[j]));
				}
			}
		}
	}
	// clear vector
	for( std::vector<std::vector<double>*>::iterator itr = fs1.begin(); itr != fs1.end(); ++itr){
		delete (*itr);
	}
	// clear vector
	for( std::vector<std::vector<double>*>::iterator itr = fs2.begin(); itr != fs2.end(); ++itr){
		delete (*itr);
	}
}
	

void ANN::train(const Instance& instance, std::vector<double>& result ){
	train( *(instance.data), *(instance.expected), result );
}

bool ANN::checkInstance( const Instance& inst ) const{
	return inst.classes->size() == this->getNumOut() && inst.data->size() == this->getNumIn();
}
	
void ANN::getOutputs( const int& layer, std::vector<double>& result ) const{
	result.clear();
	for( int i = 0; i < network[layer].size(); i++ ){
		result.push_back(network[layer][i]->getOutput());
	}
}

void ANN::getFS(const int& layer, std::vector<std::vector<double>*>& result ) const{
	// clear vector
	for( std::vector<std::vector<double>*>::iterator itr = result.begin(); itr != result.end(); ++itr){
		delete (*itr);
	}
	result.clear();
	// Loop through each neuron in current layer.
	for( int i = 0; i < network[layer].size(); i++ ){
		// Loop through each neuron in forward layer.
		std::vector<double>* fs = new std::vector<double>(network[layer+1].size());
		for( int j = 0; j < network[layer + 1].size(); j++ ){
			(*fs)[j] = network[layer+1][j]->getSynapse(i);
		}
		result.push_back(fs);
	}
}

void ANN::calculateError( const std::vector<double>& expected, const std::vector<double>& outputs,
		std::vector<double>& error){
	error.clear();
	for(int i = 0; i < expected.size(); ++i ){
		error.push_back( -(expected[i] - outputs[i]));
	}	
}

std::string ANN::getName() const {
	return name;
}

int ANN::getNumOut() const{
	return numOut; 
}

int ANN::getNumIn() const{
	return numIn;
}

int ANN::getNumHidLayers() const{
	return network.size();
}

int ANN::getNumNeurons( const int& layer ) const{
	return network[layer].size();
}

void ANN::getNetSynapse() const{
	for( int i = 0; i < network.size(); ++i ){
		std::cout << "Layer: " << i << std::endl;
		for(int j = 0; j < network[i].size(); ++j){
			std::cout << "Neuron: " << j << std::endl;
			if( i == 0 ){
				for( int k = 0; k < numIn; ++k ){
					std::cout << network[i][j]->getSynapse(k) << std::endl;
				}
			}
			else{
				for( int k = 0; k < network[i - 1].size(); ++k ){
					std::cout << network[i][j]->getSynapse(k) << std::endl;
				}
			}
		}
	}
}

bool operator==( const ANN& left, const ANN& right ){
	return left.getName() == right.getName();
}

bool operator==( const ANN& left, const std::string& right){
	return left.getName() == right;
}

