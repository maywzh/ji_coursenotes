/* 
Date: 6/10/2016
Programer: Urs Evora
Implementation file for preprocessing and file reading functions.
*/

#include <vector>
#include <string>
#include <fstream>			//File reading
#include <memory>				// smart pointers
#include <iostream>			//debug
#include "Instance.h"
#include "preprocessor.h"

void lineToStringVector( std::string& line, std::vector<std::string>& vect, const char delimiter ){
	std::size_t bPos = 0;
	std::size_t fPos = line.find(delimiter); 
	while( fPos != std::string::npos ){
		vect.push_back( line.substr(bPos, fPos-bPos) );
		bPos = fPos + 1;
		fPos = line.find(delimiter, bPos);
	}
	// Check for last item
	if( line.size() - bPos > 0 ){
		vect.push_back( line.substr(bPos) );
	}
}

void stringVToDoubleV( const std::vector<std::string>& svect, std::vector<double>& dvect, size_t end ){
	for( size_t i = 0; i < end; ++i){
		dvect.push_back( std::stod(svect[i]));
	}
}

void stringToExpectedV( const std::vector<std::string>& classes, std::vector<double>& expectedV, const std::string& expected, double trueVal, double falseVal ){
	for( size_t i = 0; i < classes.size(); ++i){
		if( expected == classes[i] ){ expectedV.push_back( trueVal );}
		else{ expectedV.push_back( falseVal ); }	
	} 
}

int readCSV( const std::string& fileName, std::vector<Instance>& instances ){
	std::string setName;
	std::shared_ptr<std::vector<std::string> > features(new std::vector<std::string>());
	std::shared_ptr<std::vector<std::string> > classes(new std::vector<std::string>());
	
	std::ifstream file;
	char delimiter = ',';
	bool classified;
	std::string line;
	
	file.open(fileName);
	if( file.is_open() ){
		// Get set name
		if( std::getline( file, line) ){
			setName = line;	
		} 
		else{
			file.close(); 
			return -1;
		}
		// Get features
		if( std::getline( file, line) ){
			lineToStringVector( line, *features, delimiter );	
		} 
		else{
			file.close(); 
			return -1;
		}
		// Get classes
		if( std::getline( file, line) ){
			lineToStringVector( line, *classes, delimiter );	
		} 
		else{
			file.close(); 
			return -1;
		}
		// Read flags
		if( std::getline( file, line) ){
			if( line == "Test" || line == "Train" ){ classified = true; }
			else if( line == "Live" ){ classified = false; }
			else{ 
				file.close();
				return -1;
			}
		} 
		else{
			file.close(); 
			return -1;
		}
		// Read data
		while( std::getline( file, line ) ){
			std::vector<double>* data = new std::vector<double>();
			std::vector<double>* expected = new std::vector<double>();
			std::vector<std::string> temp;
			lineToStringVector( line, temp, delimiter );
			stringVToDoubleV( temp, *data, temp.size() - 1 );
			stringToExpectedV( *classes, *expected, temp[temp.size() -1 ], 1.0, 0.0 );
			instances.push_back(Instance( setName, data, expected, features, classes ));
		}
		
		file.close();
		return 1;
	}
	else{ return -1; }
}



