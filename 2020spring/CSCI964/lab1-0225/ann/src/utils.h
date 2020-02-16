/*
6/9/2016
Programmer: Urs Evora
Utility functions for ANN.
*/


#ifndef UTILS_H
#define UTILS_H

#include <vector>
#include <string>
#include <iostream>
#include "Instance.h"

// Returns random double from (0 to 1)
double randD();

// Returns a random integer from [0 to max) (exclusive)
int randI( const int& max );

// Returns random character
char randC();

// Returns random string
std::string randS(const size_t& size);

// Generates random instances.
// num: number of instances to be generated.
// dataSize: number of features to be generated.
// eSize: number of expected outputs.
// strLen: length of random strings generated.
// instances: input/output vector of instances
void genRandInsts( const int& num, const int& dataSize, const int& eSize,
const int& strLen, std::vector<Instance>& instances );

// Returns a copy of a string in lower case 
std::string toLower( const std::string& str );

/* Prints result of ann activation to given ostream.*/
bool printResult( const std::vector<double>& result, const Instance& inst, std::ostream& os );

/*
 Checks if a comma seperated string can be converted into a vector of some element.
 elementCheck is a function pointer which takes a substring that checks if substring can
 be valid element.
 */
bool valCommaStr( const std::string& str, bool (*elementCheck)( const std::string& , const size_t&
, const size_t& ) );

/* Checks if substring is a valid integer. [ Low, high ) */
bool valIntStr( const std::string& str, const size_t& low, const size_t& high );

/* Converts a comma seperated string of integers to a vector of ints.
 Returns true when successful. */
bool strToIntVec( const std::string& str, std::vector<int>& result );

/* Checks if substring is a valid double. [Low, high ) */
bool valDoubleStr( const std::string& str, const size_t& low, const size_t& high );



#endif
