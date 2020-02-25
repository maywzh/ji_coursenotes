
#ifndef _DATASET
#define _DATASET

#include <Eigen/Core>
using Eigen::MatrixXf;

//dataSet class
class dataSet
{
	
public:

	int size;
	int nTarget;
	int nPattern;
	MatrixXf** pattern; //input patterns
	MatrixXf** target; //target results

	dataSet(){}

	void loadPatterns(const char* filename, int batch_size);
	void loadTargets(const char* filename, int batch_size);
	int ReverseInt(int i);
	dataSet* split(int batch_size);
};

#endif
