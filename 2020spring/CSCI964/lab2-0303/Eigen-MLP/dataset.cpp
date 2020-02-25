
#include "dataset.h"
#include <iostream>
#include <fstream>
#include <string>
#include <Eigen/Core>
using Eigen::MatrixXf;
using namespace std;

void dataSet::loadPatterns(const char* filename, int batch_size)
{

	ifstream file(filename, ios::binary); 

	if (file.is_open())
	{
		int magic_number = 0;
		int n_rows = 0;
		int n_cols = 0;

		// read the informations of the files
		file.read((char*)&magic_number, sizeof(magic_number));
		magic_number = ReverseInt(magic_number);
		file.read((char*)&size, sizeof(size));
		size = ReverseInt(size);
		file.read((char*)&n_rows, sizeof(n_rows));
		n_rows = ReverseInt(n_rows);
		file.read((char*)&n_cols, sizeof(n_cols));
		n_cols = ReverseInt(n_cols);
		nPattern = n_rows*n_cols;	
		
		size = (int) (size/batch_size);		
		
		// dynamic allocation of memory
		pattern = new MatrixXf*[size];
		for (int i = 0; i < size; i++) 
		{
			pattern[i] = new MatrixXf(batch_size, nPattern);
		}

		// fill the array with the data
		for (int i = 0; i<size; ++i)
		{
			for (int j = 0; j<batch_size; ++j)
			{
				for(int k = 0; k<nPattern; k++)
				{
					unsigned char temp = 0;
					file.read((char*)&temp, sizeof(temp));
					(*(pattern[i]))(j,k) = (float)(temp)/255.0;
				}
			}
		}

		// success !
		// cout <<endl<<"Success Reading Input file : " << filename << endl;
	}
	else
	{
		// failure !
		cout <<endl<< "Error Opening Input File: " << filename << endl;
		char c;
		cin>>c;
	}
}

void dataSet::loadTargets(const char* filename, int batch_size)
{
	ifstream file(filename, ios::binary);

	if (file.is_open())
	{
		int magic_number = 0;

		// read the informations of the files
		file.read((char*)&magic_number, sizeof(magic_number));
		magic_number = ReverseInt(magic_number);
		file.read((char*)&size, sizeof(size));
		size = ReverseInt(size);
		
		
		size = (int) (size/batch_size);		
		nTarget = 10;

		// dynamic allocation of memory
		target = new MatrixXf*[size];
		for (int i = 0; i < size; i++) 
		{
			target[i] = new MatrixXf(batch_size, nTarget);
		}

		// fill the array with the data
		for (int i = 0; i<size; ++i)
		{
			for (int j = 0; j<batch_size; ++j)
			{
				for (int k = 0; k<nTarget; ++k)
				{
					(*(target[i]))(j,k) = 0;
				}
				unsigned char temp = 0;
				file.read((char*)&temp, sizeof(temp));
				(*(target[i]))(j,temp) = 1;
			}
		}

		// success !
		// cout << "Success Reading Input file : " << filename << endl;
	}
	else
	{
		// failure !
		cout << "Error Opening Input File: " << filename << endl;
		char c;
		cin>>c;
	}
}

int dataSet::ReverseInt(int i)
{
	unsigned char ch1, ch2, ch3, ch4;
	ch1 = i & 255;
	ch2 = (i >> 8) & 255;
	ch3 = (i >> 16) & 255;
	ch4 = (i >> 24) & 255;
	return((int)ch1 << 24) + ((int)ch2 << 16) + ((int)ch3 << 8) + ch4;
}

dataSet* dataSet::split(int batch_size)
{
	dataSet* new_data_set = new dataSet;
	
	new_data_set->nTarget = nTarget;
	new_data_set->nPattern = nPattern;
	
	new_data_set->size = (int) (10000/batch_size);
	size = (int) (50000/batch_size);
	
	new_data_set->pattern = &pattern[size];
	new_data_set->target = &target[size];
	
	return new_data_set;
}

