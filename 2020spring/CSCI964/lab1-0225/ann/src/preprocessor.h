/*
Date: 6/7/2016
Programer: Urs Evora
Header file for preprocessing functions.
*/

#ifndef PREPROCESSOR_H
#define PREPROCESSOR_H

#include <vector>
#include <string>
#include "Instance.h"


/* Reads an ARFF file completely and stores instances, expected values, 
features and output classes to vectors stored in memory. Might crash with 
very large files.
fileName: Name/path of file to be read.
instances: vector of specific features to be trained on.
evs: Expected Values that coorelate to each instance (might combine to single class)
classes: Output classifications and how they coorelate to output neurons.
features: Names of each feature coorelating to the instances.
*/
/*
void readARFF( const std::string& fileName, std::vector<vector<double>*>& instances,
std::vector<vector<double>*>& evs, std::vector<std::string>& classes, 
std::vector<std::string>& features );
*/


// Helper function that reads an input string and stores it in a vector.
void lineToStringVector( std::string& line, std::vector<std::string>& vect, const char delimiter );


// Helper function that takes vector of strings and converts it to vector of double.
// Stops at end index.
void stringVToDoubleV( const std::vector<std::string> & svect, std::vector<double>& dvect, size_t end );


// Helper function that fills in expected vector with true or false values by matching expected
// class name with position in classes vector.
void stringToExpectedV( const std::vector<std::string>& classes, std::vector<double>& expectedV, const std::string& expected, double trueVal, double falseVal );


/* Reads a CSV file completely and stores instances in Instances vector. 
CSV should be of the following format.
Line 1: Set name
Line 2: Comma seperated feature names
Line 3: Comma seperated class names
Line 4: Training Set/Test/Live set. Simply have "Train" or "Test" or "Live"
Line 5-END: Comma seperated data followed by comma seperated expected class if 
training or test set.
*/
int readCSV( const std::string& fileName, std::vector<Instance>& instances );





#endif
