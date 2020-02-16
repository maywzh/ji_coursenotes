/*
Date: 5/30/2016
Programer: Urs Evora
Main file for ANN.
*/

#include <iostream>
#include "Neuron.h"



int main(){
	std::cout << "Done" << std::endl;
	Neuron n(5, 0.5);
	std::cout << n.getDelta() << std::endl;
	return 0;
}
