/*
5/30/2016
Programmer: Urs Evora
Testing functions for Neuron and ANN.
*/

#include <iostream>
#include <vector>
// #include <math.h>  //Linux compling
#include <time.h>			// random
#include <algorithm>	//random_shuffle

#include "shell.h"
#include "Neuron.h"
#include "ANN.h"
#include "Instance.h"
#include "utils.h"
#include "preprocessor.h"
#include <cmath>

// Tests if randomD is within acceptable range

bool testRandom( int num ){
	double result;
	for(int i = 0; i < num; i++){
		result = randD();
		if(result > 1 || !std::isfinite(result) || result < 0 ){ 
			std::cout << "Random Failed. result: " << result << std::endl;
			return false; 
		}
	}
	return true;
}

// Tests if sigmoid is within acceptable range (0 - 1)

bool testSigmoid( double num ){
	double result;
	double adder = 0.00000000000001;	// arbitrary 
	double x = 0;
	while( x < num ){
		result = sigmoid(x);
		//std::cout << "X: " << x << " Result: " << result << std::endl;
		if( result > 1 || !std::isfinite(result) || result < 0 ){
			std::cout << "Sigmoid Failed. result: " << result << " x: " << 
			std::endl;
			return false;
		}
		result = sigmoid(-x);
		if( result > 1 || !std::isfinite(result) || result < 0 ){
			std::cout << "Sigmoid Failed. result: " << result << " x: " << 
			std::endl;
			return false;
		}
		x += adder;
		adder *= 10;
	}
	return true; 
}

// Tests Neuron activation with multiple sizes and learning rates
// with sudo data. Assumes randD works. Checks if activation is NaN
// or tends to infinity.
bool testActivation(int num){
	double learningRate = 0.1;
	double result;
	for(int size = 0 ; size < num; size++ ){
		// Make test input
		std::vector<double> testInst;
		for(int i = 0; i < size; i++){
			testInst.push_back(randD());
		}
		// Test neuron
		for( ; learningRate < 0.8; learningRate += 0.1){
			Neuron n(size, learningRate);
			result = n.activate( testInst );
			if( result <= -1 || !std::isfinite(result) || result >= 1){
				std::cout << "Activation failed. Displaying input vector... \n";
				for( int i = 0; i < testInst.size(); i++ ){
					std::cout << testInst[i] << std::endl;
				}
				std::cout << "Result: " << result << " Size: " << size << 
				" Learning Rate: "<< learningRate << std::endl;
				return false;
			}
		}
	}
	return true;
}

// Tests back propagation in similar manner activation is tested. 
// Calls both activation and backprop methods.
bool testBackProp(int num){
	
	double result;
	for(int size = 1 ; size < num; size++ ){
		// Make test input
		std::vector<double> testInst;
		std::vector<double> testDelta;
		std::vector<double> testFS;
		for(int i = 0; i < size; i++){
			testInst.push_back(randD());
			testDelta.push_back(randD());
			testFS.push_back(randD());
		}
		// Test neuron
		for( double learningRate = 0.1; learningRate < 0.8; learningRate += 0.1){
			Neuron n(size, learningRate);
			n.activate( testInst );
			double oldSynapse = n.getSynapse(0);
			result = n.backProp(testDelta, testFS);
			//std::cout << result << std::endl;
			if( !std::isfinite(result) || result == 0){
				std::cout << "Result: " << result << " Size: " << size << 
				" Learning Rate: "<< learningRate << std::endl;
				std::cout << "BackProp failed. Displaying delta vector... \n";
				for( int i = 0; i < testDelta.size(); i++ ){
					std::cout << testDelta[i] << std::endl;
				}
				std::cout << "Displaying testFS vector... \n";
				for( int i = 0; i < testFS.size(); i++ ){
					std::cout << testFS[i] << std::endl;
				}
				return false;
			}
			if( n.getSynapse(0) == oldSynapse ){ 
				std::cout << "Synapse failed to update." << std::endl;
				return false;
			}
		}
	}
	return true;
}

// Tests constructor, copy constructor, and destructor.
// Num: number of input features. Range: Max possible size of
// hidden layers multiplied by num. Assumes randD() functions.
// numLayers: number of layers in network.
bool testANNConstructors(int num, int range, int numLayers){
	std::vector<int> layers;
	for( int i = 1; i <= num; ++i ){
		layers.clear();	
		// Initialize layers
		for( int j = 0; j < numLayers; ++j){
			layers.push_back( (int)ceil( randD() * i * range ) + 1);
		}
		for(double learningRate = 0.1; learningRate < 0.8; learningRate += 0.1 ){
			ANN net1( i, layers, learningRate );
			ANN net2 = net1;
			if( net1.getNumIn() != net2.getNumIn() ){
			std::cout << "getNumIn() Failed. Net1: " << net1.getNumIn() <<
			" Net2: " << net2.getNumIn() << std::endl;
			return false;
			}
			if( net1.getNumOut() != net2.getNumOut() ){
				std::cout << "getNumOut() Failed. Net1: " << net1.getNumOut() <<
				" Net2: " << net2.getNumOut() << std::endl;
				return false;
			}
			if( net1.getNumHidLayers() != net2.getNumHidLayers() ){
				std::cout << "getNumHidLayers() Failed. Net1: " << net1.getNumHidLayers() <<
				" Net2: " << net2.getNumHidLayers() << std::endl;
				return false;
			}
			for( int k = 0; k < net1.getNumHidLayers(); ++k){
				if( net1.getNumNeurons(k) != net2.getNumNeurons(k) ){
					std::cout << "getNumNeurons() Failed. Net1: " << net1.getNumNeurons(k) <<
					" Net2: " << net2.getNumNeurons(k) << std::endl;
					return false;
				}
			}
		}  
	}
	return true;
}

// Tests activate() function and copy constructor function.
// Num: number of input features. Range: Max possible size of
// hidden layers multiplied by num. Assumes randD() functions.
// numLayers: number of layers in network.
// iterations: number of activations tested.
bool testANNActivate(int num, int range, int numLayers, int iterations, double learningRate){
	std::vector<int> layers;
	// Initialize layers
	for( int j = 0; j < numLayers; ++j){
		layers.push_back( (int)ceil( randD() * num * range ));
	}
	ANN net1( num, layers, learningRate );
	ANN net2 = net1;
	std::vector<double> instance;
	for( int i = 0; i < iterations; ++i){
		// Generate random instances
		instance.clear();
		for( int j = 0; j < net1.getNumIn(); ++j){
			instance.push_back(randD());
		}	
		std::vector<double> result1;
		std::vector<double> result2;
		net1.activate( instance, result1 );
		net2.activate( instance, result2 );
		for( int j = 0; j < result1.size(); ++j ){
			if( result1[j] != result2[j] || !std::isfinite(result1[j]) ){
				std::cout << "Activation failed. Result1[" << j << "]: " << result1[j]
				<< " Result2[" << j << "]: " << result2[j] << std::endl;
				std::cout << "Net1 Stats \n";
				std::cout << "Number of Layers: " << net1.getNumHidLayers() << std::endl;
				std::cout << "Number inputs: " << net1.getNumIn() << std::endl;
				std::cout << "Number outputs: " << net1.getNumOut() << std::endl;
				std::cout << "Net2 Stats \n";
				std::cout << "Number of Layers: " << net2.getNumHidLayers() << std::endl;
				std::cout << "Number inputs: " << net2.getNumIn() << std::endl;
				std::cout << "Number outputs: " << net2.getNumOut() << std::endl;
				return false;
			}
		}
	}
	return true;
}

// Tests back propagation. Variables the same as
// test activate. If neural nets diverge, then error occured.
bool testANNTrain(int num, int range, int numLayers, int iterations, double learningRate){
	std::vector<int> layers;
	// Initialize layers
	for( int j = 0; j < numLayers; ++j){
		layers.push_back( (int)ceil(randD() * num * range));
		//std::cout <<  ceil(randD() * num * range) << std::endl;
	}
	ANN net1( num , layers, learningRate );
	ANN net2 = net1;
	std::vector<double> instance;
	std::vector<double> expected;
	for( int i = 0; i < iterations; ++i){
		// Generate random instances
		instance.clear();
		expected.clear();
		for( int j = 0; j < net1.getNumIn(); ++j){
			instance.push_back(randD());
		}	
		// Generate expected values
		for( int j = 0; j < net1.getNumOut(); ++j){
			if(randD() > 0.5){
				expected.push_back( 1.0 );
			}
			else{ expected.push_back( 0.0 ); }
		}
		std::vector<double> result1;
		std::vector<double> result2;
		net1.train( instance, expected ,result1 );
		net2.train( instance, expected ,result2 );
		for( int j = 0; j < result1.size(); ++j ){
			if( result1[j] != result2[j] || !std::isfinite(result1[j])){
				std::cout << "Training failed. Result1[" << j << "]: " << result1[j]
				<< " Result2[" << j << "]: " << result2[j] << std::endl;
				std::cout << "Net1 Stats \n";
				std::cout << "Number of Layers: " << net1.getNumHidLayers() << std::endl;
				std::cout << "Number inputs: " << net1.getNumIn() << std::endl;
				std::cout << "Number outputs: " << net1.getNumOut() << std::endl;
				std::cout << "Net2 Stats \n";
				std::cout << "Number of Layers: " << net2.getNumHidLayers() << std::endl;
				std::cout << "Number inputs: " << net2.getNumIn() << std::endl;
				std::cout << "Number outputs: " << net2.getNumOut() << std::endl;
				return false;
			}
		}
	}
	return true;
}

// Generates xor training test. Network is 2 layers
// 3 neuron hidden layer and 1 output neuron. 
void trainXOR(int iterations, double learningRate){
	// Initialize network
	std::vector<int> layers;
	layers.push_back(5);
	//layers.push_back(5);
	layers.push_back(1);
	ANN net( 2, layers, learningRate );
	// Train
	std::vector<double> instance;
	std::vector<double> expected;
	std::vector<double> result;
	for( int i = 0; i < iterations; ++i ){
		instance.clear();
		expected.clear();
		instance.push_back(randD());
		instance.push_back(randD());
		if( (instance[0] > 0.5 && instance[1] < 0.5) || (instance[0] < 0.5 && instance[1] > 0.5) ){ expected.push_back(1.0); }
		else{ expected.push_back( 0.0 ); }
		net.train( instance, expected, result );
		if( i % (iterations/10) == 0 ){
			//net.getNetSynapse();
			std::cout << "Training instance: " << i << std::endl;
			std::cout << "x: " << instance[0] << std::endl;
			std::cout << "y: " << instance[1] << std::endl;
			std::cout << "Expected: " << expected[0] << std::endl;
			std::cout << "Result: " << result[0] << std::endl;
			
		}
	}
}

// Tests instances and methods.
bool testInstances( int num, int dataSize, int eSize, int strLen ){
	std::vector<Instance> instances;
	genRandInsts( num, dataSize, eSize, strLen, instances );
	// Check if feature name and class match
	int index1 = randI(instances.size()), index2 = randI(instances.size());
	// Ensure indexs are unique
	while( index1 == index2 ){ index2 = randI(instances.size());}
	Instance inst1 = instances[index1], inst2 = instances[index2];
	// Test if features and class names are the same
	for( int i = 0; i < dataSize; ++i ){
		if( inst1.getFeatName(i) != inst2.getFeatName(i) ){
			std::cout << "Features names do not match. Inst1: " << inst1.getFeatName(i) <<
			" Inst2: " << inst2.getFeatName(i) << std::endl;
			return false;
		}
	}
	for( int i = 0; i < eSize; ++i ){
		if(inst1.getClassName(i) != inst2.getClassName(i) ){
			std::cout << "Class names do not match. Inst1: " << inst1.getClassName(i) <<
			" Inst2: " << inst2.getClassName(i) << std::endl;
			return false;
		}
	}
	// Test in ANN
	std::vector<int> layers;
	layers.push_back( dataSize );
	layers.push_back( randI(dataSize) + dataSize );
	layers.push_back( eSize );
	ANN net( dataSize, layers, 0.2 );
	std::vector<double> result;
	for( Instance& i : instances ){
		net.train( i, result );
	}
	return true;
}

void testIris( int iterations, double learningRate, bool inputMode){
	std::vector<Instance> instances;
	if(readCSV( "iris.data", instances )){
		// Set up network
		std::vector<int> layers = { 15, 3 };
		std::cout << "EXPRECTED" << instances[0].getExpectedSize() << std::endl;
		ANN net( instances[0].getDataSize(), layers, learningRate );
		// Train
		for( int i = 0; i < iterations; ++i ){
		std::random_shuffle( instances.begin(), instances.end() );
			for( int j = 0; j < instances.size(); ++j ){
				std::vector<double> result;
				net.train(instances[j], result );
				if( i % (iterations/100) == 0  && j == 0){
					std::cout << "Iteration: " << i << std::endl;
					std::cout << "Training Instance: " << j << std::endl;
					for( int k = 0; k < instances[j].getDataSize(); ++k ){
						std::cout << (*instances[j].features)[k] << ": " << (*instances[j].data)[k] <<
						 std::endl;
					}
					for( int k = 0; k < instances[j].getExpectedSize(); ++k ){
						std::cout << (*instances[j].classes)[k] << ": " << (*instances[j].expected)[k] << 
						" Result: " << result[k] <<  std::endl;
					}
				}
			}
	 	}
 	}
 	else{ std::cout << "Failed to read file." << std::endl; }
}

/* Tests arg parser for shell. Takes user input endlessly and prints out
the parsed arguments until user enters an empty string or an error occurs.
*/
void testArgParser(){
	std::string uin;
	std::vector<Arg> args;
	std::getline(std::cin, uin);
	while( uin != "" ){
		if(parseArgs(uin, args) < 0 ){ break; }
		for( Arg& a : args ){
			switch( a.type ){
				case CMD:
					std::cout << "CMD: ";
					break;
				case FLAG:
					std::cout << "FLAG: ";
					break;
				case DSC:
					std::cout << "DSC: ";
					break;
				case VAL:
					std::cout << "VAL: ";
					break;
				case REDIR:
					std::cout << "REDIR: ";
					break;	
				default:
					std::cout << "UNKNOWN: ";
					break;	
			}
			std::cout << a.value << std::endl;
		}
		args.clear();
		uin.clear();
		std::getline(std::cin, uin);
	}
}


int main(){
	srand(time(NULL));
	std::cout << "Testing Neuron..." << std::endl;
	std::cout << "Testing Random with 10000 numbers." << std::endl;
	testRandom( 10000 );
	std::cout << "Testing sigmoid with 10000 numbers." << std::endl;
	testSigmoid( 10000 );
	std::cout << "Testing activation up to size 50." << std::endl;
	//testActivation( 50 );
	std::cout << "Testing back prop up to size 50." << std::endl;
	//testBackProp(50);
	std::cout << "Testing ANN constructors up to 5 layers, with up to 50 neurons per layer." << std::endl;
	//testANNConstructors( 50, 2, 5 );
	std::cout << "Testing ANN activation up to 5 layers, with up to 50 neurons per layer." << 
	" With up to 100 iterations. "<< std::endl;
	//testANNActivate( 50, 1, 5, 100, 0.4 );
	std::cout << "Testing ANN training up to 5 layers, with up to 50 neurons per layer." << 
	" With up to 100 iterations. "<< std::endl;
	//testANNTrain(50, 1, 5, 100, 0.4 );
	//std::cout << "Testing XOR for 100000 iterations and 0.2 learning rate." << std::endl;
	//trainXOR( 1000000, 0.2 );
	//std::cout << "Testing 100 instances and a 3 layer ANN with instances." << std::endl; 
	//testInstances( 100, 15, 3, 8 );
	//std::cout << "Testing Iris with up to 10000 iterations and 0.2 learning rate. " << std::endl;
	//testIris( 10000, 0.1, false );
	std::cout << "Testing arguement parser. Enter empty string to end test." << std::endl;
	testArgParser();
	std::cout << "Test complete." << std::endl;
	return 0;
}
