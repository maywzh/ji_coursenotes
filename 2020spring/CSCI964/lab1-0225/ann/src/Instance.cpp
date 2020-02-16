/*
Date: 6/8/2016
Programer: Urs Evora
Implementation file for instance class and functions.
*/

#include <vector>
#include <memory>
#include <string>
#include "Instance.h"


Instance::Instance( const std::string& name,  std::vector<double>* data,
		std::vector<double>* expected,  std::shared_ptr<std::vector<std::string> >& features,
		 std::shared_ptr<std::vector<std::string> >& classes )
		:name(name), data(data), expected(expected), features(features), classes(classes){
		
		}
		
Instance::Instance( const Instance& rhs )
	:name(rhs.name){
	//this->name = rhs.name;
	std::vector<double>* tData = new std::vector<double>();
	std::vector<double>* eData = new std::vector<double>();
	// Make new copy of data and expected on the heap
	for(const double d : *(rhs.data) ){
		tData->push_back(d);
	}
	for(const double d: *(rhs.expected)){
		eData->push_back(d);
	}
	// Assign members
	data = std::unique_ptr<std::vector<double> >(tData);
	expected = std::unique_ptr<std::vector<double> >(eData);
	features = std::shared_ptr<std::vector<std::string> >(rhs.features);
	classes = std::shared_ptr<std::vector<std::string> >(rhs.classes);
}

Instance& Instance::operator=( const Instance& rhs ){
	if( this != &rhs ){
		// clear old pointers
		data.reset();
		expected.reset();
		features.reset();
		classes.reset();
		std::vector<double>* tData = new std::vector<double>();
		std::vector<double>* eData = new std::vector<double>();
		// Make new copy of data and expected on the heap
		for(const double d : *(rhs.data) ){
			tData->push_back(d);
		}
		for(const double d: *(rhs.expected)){
			eData->push_back(d);
		}
		// Assign members
		name = rhs.name;
		data = std::unique_ptr<std::vector<double> >(tData);
		expected = std::unique_ptr<std::vector<double> >(eData);
		features = std::shared_ptr<std::vector<std::string> >(rhs.features);
		classes = std::shared_ptr<std::vector<std::string> >(rhs.classes);
	}
	return *this;
}

Instance::~Instance(){
	// clear old pointers
		data.reset();
		expected.reset();
		features.reset();
		classes.reset();
}

double Instance::operator[]( const int& index ) const{
	return (*data)[index];
}

double Instance::getExpected( const int& index ) const{
	return (*expected)[index];
}

size_t Instance::getDataSize() const{
	return data->size();
}

size_t Instance::getExpectedSize() const{
	return expected->size();
}

std::string Instance::getFeatName( const int& index ) const{
	return (*features)[index];
}


std::string Instance::getClassName( const int& index ) const{
	return (*features)[index];
}

InstanceSet::InstanceSet( std::string name, SetType type, std::vector<Instance> instances )
	: name(name), type(type), instances(instances){}
		
InstanceSet::InstanceSet( std::string name, SetType type )
	: name(name), type(type){}
		
std::string InstanceSet::getName() const{ return name; }
	
bool operator==( const InstanceSet& left, const InstanceSet& right ){
	return left.getName() == right.getName();
}

bool operator==( const InstanceSet& left, const std::string& right ){
	return left.getName() == right;
}



