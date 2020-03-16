/************************************************************************
*  mlp.cpp - Implements a multi-layer back-propagation neural network
*  CSCI964/CSCI464 2-Layer MLP
*  Ver1: Koren Ward - 15 March 2003
*  Ver2: Koren Ward - 21 July  2003 - Dynamic memory added
*  Ver3: Koren Ward - 20 March 2005 - Net paramaters in datafile added
*  Ver4: Wangzhihui Mei - 5 March 2020 - 3, 4 & 5 layer mlp & test fn added
*  Copyright - University of Wollongong - 2005
*************************************************************************/
#include <iostream>
#include <iomanip>
#include <fstream>
#include <cstdlib>
#include <cstdio>
#include <cmath>
#include <ctime>
#include <string>

using namespace std;

const int MAXN = 50;			// Max neurons in any layer
const int MAXPATS = 5000; // Max training patterns
// mlp paramaters
long NumIts;	 // Max training iterations
int NumHN;		 // Number of hidden layers
int NumHN1;		 // Number of neurons in hidden layer 1
int NumHN2;		 // Number of neurons in hidden layer 2
int NumHN3;		 // Number of neurons in hidden layer 3
int NumHN4;		 // Number of neurons in hidden layer 4
float LrnRate; // Learning rate
float Mtm1;		 // Momentum(t-1)
float Mtm2;		 // Momentum(t-2)
float ObjErr;	// Objective error

// mlp weights
float **w1, **w11, **w111; // 1st layer wts
float **w2, **w22, **w222; // 2nd layer wts
float **w3, **w33, **w333; // 3rd layer wts
float **w4, **w44, **w444; // 4th layer wts
float **w5, **w55, **w555; // 5th layer wts

void TrainNet(float **x, float **d, int NumIPs, int NumOPs, int NumPats);
void TrainNet2(float **x, float **d, int NumIPs, int NumOPs, int NumPats, int Ordering);
void TrainNet3(float **x, float **d, int NumIPs, int NumOPs, int NumPats, int Ordering);
void TrainNet4(float **x, float **d, int NumIPs, int NumOPs, int NumPats, int Ordering);

void TestNet(float **x, float **d, int NumIPs, int NumOPs, int NumPats);
void TestNet2(float **x, float **d, int NumIPs, int NumOPs, int NumPats);
void TestNet3(float **x, float **d, int NumIPs, int NumOPs, int NumPats);
void TestNet4(float **x, float **d, int NumIPs, int NumOPs, int NumPats);
float **Aloc2DAry(int m, int n);
void Free2DAry(float **Ary2D, int n);
int random_between(int min, int max)
{
	//srand((unsigned)time(NULL));
	return (rand() % (max - min + 1)) + min;
}
void InitArray(int *arr, int n)
{
	for (int i = 0; i < n; i++)
	{
		arr[i] = i;
	}
}
void PrintArray(int *arr, int n)
{
	for (int i = 0; i < n; i++)
	{
		cout << arr[i] << " ";
	}
	cout << endl;
}

void RandomArray(int *arr, int n, int ordering)
{

	if (ordering == 0)
	{
		for (int i = 0; i < n; i++)
		{
			arr[i] = i;
		}
	}
	else if (ordering == 1)
	{
		for (int i = n - 1; i != 0; i--)
		{
			int j = random_between(0, i);
			int tmp = arr[i];
			arr[i] = arr[j];
			arr[j] = tmp;
		}
	}
	else if (ordering == 2)
	{
		int ii = random_between(0, n - 1);
		int jj = random_between(0, n - 1);
		int tmp = arr[ii];
		arr[ii] = arr[jj];
		arr[jj] = tmp;
	}
	else
	{
		for (int i = 0; i < n; i++)
		{
			arr[i] = i;
		}
	}
}

void TrainNet(float **x, float **d, int NumIPs, int NumOPs, int NumPats, int Ordering)
{
	if (NumHN == 1)
	{
		TrainNet2(x, d, NumIPs, NumOPs, NumPats, Ordering);
	}
	else if (NumHN == 2)
	{
		TrainNet3(x, d, NumIPs, NumOPs, NumPats, Ordering);
	}
	else if (NumHN == 3)
	{
		TrainNet4(x, d, NumIPs, NumOPs, NumPats, Ordering);
	}
	else
	{
		cout << "Exceed hidden layer limit" << endl;
	}
}

// Trains 2 layer back propagation neural network
void TrainNet2(float **x, float **d, int NumIPs, int NumOPs, int NumPats, int Ordering)
{
	// x[][]=>input data, d[][]=>desired output data

	float *h1 = new float[NumHN1];																				 // O/Ps of hidden layer
	float *y = new float[NumOPs];																					 // O/P of Net
	float *ad1 = new float[NumHN1];																				 // HN1 back prop errors
	float *ad2 = new float[NumOPs];																				 // O/P back prop errors
	float PatErr, MinErr, AveErr = 0.0, MaxErr, lastAveErr, PcntErr = 0.0; // Pattern errors
	int p, i, j;																													 // for loops indexes
	long ItCnt = 0;																												 // Iteration counter
	long NumErr = 0;																											 // Error counter (added for spiral problem)

	cout << "TrainNet2: IP:" << NumIPs << " H1:" << NumHN1 << " OP:" << NumOPs << endl;

	// Allocate memory for weights
	w1 = Aloc2DAry(NumIPs, NumHN1); // 1st layer wts
	w11 = Aloc2DAry(NumIPs, NumHN1);
	w111 = Aloc2DAry(NumIPs, NumHN1);
	w2 = Aloc2DAry(NumHN1, NumOPs); // 2nd layer wts
	w22 = Aloc2DAry(NumHN1, NumOPs);
	w222 = Aloc2DAry(NumHN1, NumOPs);

	// Init wts between -0.5 and +0.5
	srand(time(0));
	for (i = 0; i < NumIPs; i++)
		for (j = 0; j < NumHN1; j++)
			w1[i][j] = w11[i][j] = w111[i][j] = float(rand()) / RAND_MAX - 0.5;
	for (i = 0; i < NumHN1; i++)
		for (j = 0; j < NumOPs; j++)
			w2[i][j] = w22[i][j] = w222[i][j] = float(rand()) / RAND_MAX - 0.5;
	// Initailize the array
	int *arr = new int[NumPats];
	InitArray(arr, NumPats);
	if (Ordering >= 2)
		RandomArray(arr, NumPats, 1);
	ofstream trainfile;
	trainfile.open("./trainfile.txt");
	// Perform learning iterable learning epochs
	for (;;)
	{
		lastAveErr = AveErr;
		MinErr = 3.4e38;
		AveErr = 0;
		MaxErr = -3.4e38;
		NumErr = 0;
		// bool WrongClassified = NumErr > 1 / 10 * NumPats; // if 1/10 samples are recorded, the epoch/pattern is wrong classified
		if (Ordering == 0)
		{
		}
		else if (Ordering == 1)
		{
			RandomArray(arr, NumPats, 1);
		}
		else if (Ordering == 2)
		{
			RandomArray(arr, NumPats, 2);
		}
		else
		{
			// if PcntErr > 10% => the pattern is wrong classified.
			if (PcntErr <= 10.0)
				RandomArray(arr, NumPats, 1);
		}
		//Training
		for (int idx = 0; idx < NumPats; idx++)
		{
			p = arr[idx];
			for (i = 0; i < NumHN1; i++)
			{
				float in = 0;
				for (j = 0; j < NumIPs; j++)
					in += w1[j][i] * x[p][j];
				h1[i] = (float)(1.0 / (1.0 + exp(double(-in)))); // Sigmoid fn
			}
			for (i = 0; i < NumOPs; i++)
			{
				float in = 0;
				for (j = 0; j < NumHN1; j++)
				{
					in += w2[j][i] * h1[j];
				}
				y[i] = (float)(1.0 / (1.0 + exp(double(-in)))); // Sigmoid fn
			}
			// Cal error for this pattern
			PatErr = 0.0;
			for (i = 0; i < NumOPs; i++)
			{
				float err = y[i] - d[p][i]; // actual-desired O/P
				if (err > 0)
					PatErr += err;
				else
					PatErr -= err;
				NumErr += ((y[i] < 0.5 && d[p][i] >= 0.5) || (y[i] >= 0.5 && d[p][i] < 0.5)); //added for binary classification problem
			}
			if (PatErr < MinErr)
				MinErr = PatErr;
			if (PatErr > MaxErr)
				MaxErr = PatErr;
			AveErr += PatErr;

			// Learn pattern with back propagation
			for (i = 0; i < NumOPs; i++)
			{ // Modify layer 2 wts
				ad2[i] = (d[p][i] - y[i]) * y[i] * (1.0 - y[i]);
				for (j = 0; j < NumHN1; j++)
				{
					w2[j][i] += LrnRate * h1[j] * ad2[i] +
											Mtm1 * (w2[j][i] - w22[j][i]) +
											Mtm2 * (w22[j][i] - w222[j][i]);
					w222[j][i] = w22[j][i];
					w22[j][i] = w2[j][i];
				}
			}
			for (i = 0; i < NumHN1; i++)
			{ // Modify layer 1 wts
				float err = 0.0;
				for (j = 0; j < NumOPs; j++)
					err += ad2[j] * w2[i][j];
				ad1[i] = err * h1[i] * (1.0 - h1[i]);
				for (j = 0; j < NumIPs; j++)
				{
					w1[j][i] += LrnRate * x[p][j] * ad1[i] +
											Mtm1 * (w1[j][i] - w11[j][i]) +
											Mtm2 * (w11[j][i] - w111[j][i]);
					w111[j][i] = w11[j][i];
					w11[j][i] = w1[j][i];
				}
			}
		} // end for each pattern
		ItCnt++;
		AveErr /= NumPats;
		PcntErr = NumErr / float(NumPats) * 100.0;
		cout.setf(ios::fixed | ios::showpoint);
		cout << setprecision(6) << setw(6) << ItCnt << ": " << setw(12) << MinErr << setw(12) << AveErr << setw(12) << MaxErr << setw(12) << PcntErr << endl;
		trainfile.setf(ios::fixed | ios::showpoint);
		trainfile << MinErr << setw(12) << AveErr << setw(12) << MaxErr << setw(12) << PcntErr << endl;
		if (((abs(AveErr - lastAveErr) <= ObjErr) && (AveErr < 0.02)) || (ItCnt == NumIts))
		{
			cout << abs(AveErr - lastAveErr) << endl;
			break;
		};
	} // end main learning loop
	// Free memory
	trainfile.close();
	delete[] arr;
	delete[] h1;
	delete[] y;
	delete[] ad1;
	delete[] ad2;
}

// Trains 3 layer back propagation neural network
void TrainNet3(float **x, float **d, int NumIPs, int NumOPs, int NumPats, int Ordering)
{
	// Trains 2 layer back propagation neural network
	// x[][]=>input data, d[][]=>desired output data

	float *h1 = new float[NumHN1];	// O/Ps of hidden layer 1
	float *h2 = new float[NumHN2];	// O/Ps of hidden layer 2
	float *y = new float[NumOPs];		// O/P of Net
	float *ad1 = new float[NumHN1]; // HN1 back prop errors
	float *ad2 = new float[NumHN2]; // HN2 back prop errors
	float *ad3 = new float[NumOPs]; // O/P back prop errors
	float PatErr;										// Absolute error sum of the pattern
	float MinErr;										// Minimum epoch error
	float AveErr = 0.0;							// Aveage error in one epoch
	float MaxErr;										// maximum epoch error
	float lastAveErr;								// lastAveage error in one epoch

	int p, i, j;		 // for loops indexes
	long ItCnt = 0;	// Iteration counter
	long NumErr = 0; // Error counter (added for spiral problem)

	cout << "TrainNet2: IP:" << NumIPs << " H1:" << NumHN1 << " H2:" << NumHN2 << " OP:" << NumOPs << endl;

	// Allocate memory for weights
	w1 = Aloc2DAry(NumIPs, NumHN1); // 1st layer wts
	w11 = Aloc2DAry(NumIPs, NumHN1);
	w111 = Aloc2DAry(NumIPs, NumHN1);
	w2 = Aloc2DAry(NumHN1, NumHN2); // 2nd layer wts
	w22 = Aloc2DAry(NumHN1, NumHN2);
	w222 = Aloc2DAry(NumHN1, NumHN2);
	w3 = Aloc2DAry(NumHN2, NumOPs); // 3nd layer wts
	w33 = Aloc2DAry(NumHN2, NumOPs);
	w333 = Aloc2DAry(NumHN2, NumOPs);

	// Init wts between -0.5 and +0.5
	srand(time(0));
	for (i = 0; i < NumIPs; i++)
		for (j = 0; j < NumHN1; j++)
			w1[i][j] = w11[i][j] = w111[i][j] = float(rand()) / RAND_MAX - 0.5;
	for (i = 0; i < NumHN1; i++)
		for (j = 0; j < NumHN2; j++)
			w2[i][j] = w22[i][j] = w222[i][j] = float(rand()) / RAND_MAX - 0.5;
	for (i = 0; i < NumHN2; i++)
		for (j = 0; j < NumOPs; j++)
			w3[i][j] = w33[i][j] = w333[i][j] = float(rand()) / RAND_MAX - 0.5;
	// Initailize the array
	int *arr = new int[NumPats];
	InitArray(arr, NumPats);
	if (Ordering >= 2)
		RandomArray(arr, NumPats, 1);
	ofstream trainfile;
	trainfile.open("./trainfile.txt");
	// Perform learning iterable learning epochs
	for (;;)
	{
		lastAveErr = AveErr;
		MinErr = 3.4e38;
		AveErr = 0;
		MaxErr = -3.4e38;
		NumErr = 0;
		bool WrongClassified = NumErr > 1 / 10 * NumPats; // if 1/10 samples are recorded, the epoch/pattern is wrong classified
		if (Ordering == 0)
		{
		}
		else if (Ordering == 1)
		{
			RandomArray(arr, NumPats, 1);
		}
		else if (Ordering == 2)
		{
			RandomArray(arr, NumPats, 2);
		}
		else
		{
			if (!WrongClassified)
				RandomArray(arr, NumPats, 1);
		}
		// Training
		for (int idx = 0; idx < NumPats; idx++)
		{
			p = arr[idx];
			//forward propagation
			for (i = 0; i < NumHN1; i++)
			{
				float in = 0;
				for (j = 0; j < NumIPs; j++)
					in += w1[j][i] * x[p][j];
				h1[i] = (float)(1.0 / (1.0 + exp(double(-in)))); // Sigmoid fn
			}
			for (i = 0; i < NumHN2; i++)
			{
				float in = 0;
				for (j = 0; j < NumHN1; j++)
				{
					in += w2[j][i] * h1[j];
				}
				h2[i] = (float)(1.0 / (1.0 + exp(double(-in)))); // Sigmoid fn
			}
			for (i = 0; i < NumOPs; i++)
			{
				float in = 0;
				for (j = 0; j < NumHN2; j++)
				{
					in += w3[j][i] * h2[j];
				}
				y[i] = (float)(1.0 / (1.0 + exp(double(-in)))); // Sigmoid fn
			}
			// Cal error for this pattern
			PatErr = 0.0;
			for (i = 0; i < NumOPs; i++)
			{
				float err = y[i] - d[p][i]; // actual-desired O/P
				if (err > 0)
					PatErr += err;
				else
					PatErr -= err;
				NumErr += ((y[i] < 0.5 && d[p][i] >= 0.5) || (y[i] >= 0.5 && d[p][i] < 0.5)); //added for binary classification problem
			}
			if (PatErr < MinErr)
				MinErr = PatErr;
			if (PatErr > MaxErr)
				MaxErr = PatErr;
			AveErr += PatErr;
			// backward propagation
			// Out layer -> 2th hidden layer : NumOPs -> NumHN2
			for (i = 0; i < NumOPs; i++)
			{
				ad3[i] = (d[p][i] - y[i]) * y[i] * (1.0 - y[i]);
				for (j = 0; j < NumHN2; j++)
				{
					w3[j][i] += LrnRate * h2[j] * ad3[i] +
											Mtm1 * (w3[j][i] - w33[j][i]) +
											Mtm2 * (w33[j][i] - w333[j][i]);
					w333[j][i] = w33[j][i]; // The last last time weight
					w33[j][i] = w3[j][i];		// the last time weight
				}
			}
			// 2th hidden layer -> 1st hidden layer : HumHN2 -> NumHN1
			for (i = 0; i < NumHN2; i++)
			{
				float err = 0.0;
				for (j = 0; j < NumOPs; j++)
					err += ad3[j] * w3[i][j];
				ad2[i] = err * h2[i] * (1.0 - h2[i]);
				for (j = 0; j < NumHN1; j++)
				{
					w2[j][i] += LrnRate * ad2[i] * h1[j] +
											Mtm1 * (w2[j][i] - w22[j][i]) +
											Mtm2 * (w22[j][i] - w222[j][i]);
					w222[j][i] = w22[j][i];
					w22[j][i] = w2[j][i];
				}
			}
			// 1st hidden layer -> Input layer : NumHN1 -> NumIOs
			for (i = 0; i < NumHN1; i++)
			{
				float err = 0.0;
				for (j = 0; j < NumHN2; j++)
					err += ad2[j] * w2[i][j];
				ad1[i] = err * h1[i] * (1.0 - h1[i]);
				for (j = 0; j < NumIPs; j++)
				{
					w1[j][i] += LrnRate * ad1[i] * x[p][j] +
											Mtm1 * (w1[j][i] - w11[j][i]) +
											Mtm2 * (w11[j][i] - w111[j][i]);
					w111[j][i] = w11[j][i];
					w11[j][i] = w1[j][i];
				}
			}
		} // end for each pattern

		ItCnt++;
		AveErr /= NumPats;
		float PcntErr = NumErr / float(NumPats) * 100.0;
		cout.setf(ios::fixed | ios::showpoint);
		cout << setprecision(6) << setw(6) << ItCnt << ": " << setw(12) << MinErr << setw(12) << AveErr << setw(12) << MaxErr << setw(12) << PcntErr << endl;
		trainfile.setf(ios::fixed | ios::showpoint);
		trainfile << MinErr << setw(12) << AveErr << setw(12) << MaxErr << setw(12) << PcntErr << endl;
		if (((abs(AveErr - lastAveErr) <= ObjErr) && (AveErr < 0.02)) || (ItCnt == NumIts))
		{
			cout << abs(AveErr - lastAveErr) << endl;
			break;
		};

	} // end main learning loop
	// Free memory
	trainfile.close();
	delete[] arr;
	delete[] h1;
	delete[] h2;
	delete[] y;
	delete[] ad1;
	delete[] ad2;
}

// Trains 4 layer back propagation neural network
void TrainNet4(float **x, float **d, int NumIPs, int NumOPs, int NumPats, int Ordering)
{
	// x[][]=>input data, d[][]=>desired output data

	float *h1 = new float[NumHN1];	// O/Ps of hidden layer 1
	float *h2 = new float[NumHN2];	// O/Ps of hidden layer 2
	float *h3 = new float[NumHN3];	// O/Ps of hidden layer 2
	float *y = new float[NumOPs];		// O/P of Net
	float *ad1 = new float[NumHN1]; // HN1 back prop errors
	float *ad2 = new float[NumHN2]; // HN2 back prop errors
	float *ad3 = new float[NumHN3]; // HN3 back prop errors
	float *ad4 = new float[NumOPs]; // O/P back prop errors
	float PatErr;										// Absolute error sum of the pattern
	float MinErr;										// Minimum epoch error
	float AveErr = 0.0;							// Aveage error in one epoch
	float MaxErr;										// maximum epoch error
	float lastAveErr;								// lastAveage error in one epoch

	int p, i, j;		 // for loops indexes
	long ItCnt = 0;	// Iteration counter
	long NumErr = 0; // Error counter (added for spiral problem)

	cout << "TrainNet2: IP:" << NumIPs << " H1:" << NumHN1 << " H2:" << NumHN2 << " H3:" << NumHN3 << " OP:" << NumOPs << endl;

	// Allocate memory for weights
	w1 = Aloc2DAry(NumIPs, NumHN1); // 1st layer wts
	w11 = Aloc2DAry(NumIPs, NumHN1);
	w111 = Aloc2DAry(NumIPs, NumHN1);
	w2 = Aloc2DAry(NumHN1, NumHN2); // 2nd layer wts
	w22 = Aloc2DAry(NumHN1, NumHN2);
	w222 = Aloc2DAry(NumHN1, NumHN2);
	w3 = Aloc2DAry(NumHN2, NumHN3); // 3rd layer wts
	w33 = Aloc2DAry(NumHN2, NumHN3);
	w333 = Aloc2DAry(NumHN2, NumHN3);
	w4 = Aloc2DAry(NumHN3, NumOPs); // 4th layer wts
	w44 = Aloc2DAry(NumHN3, NumOPs);
	w444 = Aloc2DAry(NumHN3, NumOPs);

	// Init wts between -0.5 and +0.5
	srand(time(0));
	for (i = 0; i < NumIPs; i++)
		for (j = 0; j < NumHN1; j++)
			w1[i][j] = w11[i][j] = w111[i][j] = float(rand()) / RAND_MAX - 0.5;
	for (i = 0; i < NumHN1; i++)
		for (j = 0; j < NumHN2; j++)
			w2[i][j] = w22[i][j] = w222[i][j] = float(rand()) / RAND_MAX - 0.5;
	for (i = 0; i < NumHN2; i++)
		for (j = 0; j < NumHN3; j++)
			w3[i][j] = w33[i][j] = w333[i][j] = float(rand()) / RAND_MAX - 0.5;
	for (i = 0; i < NumHN3; i++)
		for (j = 0; j < NumOPs; j++)
			w4[i][j] = w44[i][j] = w444[i][j] = float(rand()) / RAND_MAX - 0.5;
	// Initailize the array
	int *arr = new int[NumPats];
	InitArray(arr, NumPats);
	if (Ordering >= 2)
		RandomArray(arr, NumPats, 1);
	ofstream trainfile;
	trainfile.open("./trainfile.txt");
	// Perform learning iterable learning epochs
	for (;;)
	{
		MinErr = 3.4e38;
		lastAveErr = AveErr;
		AveErr = 0;
		MaxErr = -3.4e38;
		NumErr = 0;
		bool WrongClassified = NumErr > 1 / 10 * NumPats; // if 1/10 samples are marked error, the epoch/pattern is wrong classified
		if (Ordering == 0)
		{
		}
		else if (Ordering == 1)
		{
			RandomArray(arr, NumPats, 1);
		}
		else if (Ordering == 2)
		{
			RandomArray(arr, NumPats, 2);
		}
		else
		{
			if (!WrongClassified)
				RandomArray(arr, NumPats, 1);
		}
		for (int idx = 0; idx < NumPats; idx++)
		{
			p = arr[idx];
			//forward propagation
			for (i = 0; i < NumHN1; i++)
			{
				float in = 0;
				for (j = 0; j < NumIPs; j++)
					in += w1[j][i] * x[p][j];
				h1[i] = (float)(1.0 / (1.0 + exp(double(-in)))); // Sigmoid fn
			}
			for (i = 0; i < NumHN2; i++)
			{
				float in = 0;
				for (j = 0; j < NumHN1; j++)
				{
					in += w2[j][i] * h1[j];
				}
				h2[i] = (float)(1.0 / (1.0 + exp(double(-in)))); // Sigmoid fn
			}
			for (i = 0; i < NumHN3; i++)
			{
				float in = 0;
				for (j = 0; j < NumHN2; j++)
				{
					in += w3[j][i] * h2[j];
				}
				h3[i] = (float)(1.0 / (1.0 + exp(double(-in)))); // Sigmoid fn
			}
			for (i = 0; i < NumOPs; i++)
			{
				float in = 0;
				for (j = 0; j < NumHN3; j++)
				{
					in += w4[j][i] * h3[j];
				}
				y[i] = (float)(1.0 / (1.0 + exp(double(-in)))); // Sigmoid fn
			}
			// Cal error for this pattern
			PatErr = 0.0;
			for (i = 0; i < NumOPs; i++)
			{
				float err = y[i] - d[p][i]; // actual-desired O/P
				if (err > 0)
					PatErr += err;
				else
					PatErr -= err;
				NumErr += ((y[i] < 0.5 && d[p][i] >= 0.5) || (y[i] >= 0.5 && d[p][i] < 0.5)); //added for binary classification problem
			}
			if (PatErr < MinErr)
				MinErr = PatErr;
			if (PatErr > MaxErr)
				MaxErr = PatErr;
			AveErr += PatErr;
			// backward propagation
			// Out layer -> 3th hidden layer : NumOPs -> NumHN3
			for (i = 0; i < NumOPs; i++)
			{
				ad4[i] = (d[p][i] - y[i]) * y[i] * (1.0 - y[i]);
				for (j = 0; j < NumHN3; j++)
				{
					w4[j][i] += LrnRate * h3[j] * ad4[i] +
											Mtm1 * (w4[j][i] - w44[j][i]) +
											Mtm2 * (w44[j][i] - w444[j][i]);
					w444[j][i] = w44[j][i]; // The last last time weight
					w44[j][i] = w4[j][i];		// the last time weight
				}
			}
			// 3rd hidden layer -> 2nd hidden layer : NumHN3 -> NumHN2
			for (i = 0; i < NumHN3; i++)
			{
				float err = 0.0;
				for (j = 0; j < NumOPs; j++)
					err += ad4[j] * w4[i][j];
				ad3[i] = err * h3[i] * (1.0 - h3[i]);
				for (j = 0; j < NumHN2; j++)
				{
					w3[j][i] += LrnRate * h2[j] * ad3[i] +
											Mtm1 * (w3[j][i] - w33[j][i]) +
											Mtm2 * (w33[j][i] - w333[j][i]);
					w333[j][i] = w33[j][i]; // The last last time weight
					w33[j][i] = w3[j][i];		// the last time weight
				}
			}
			// 3th hidden layer -> 2nd hidden layer : NumHN2 -> NumHN1
			for (i = 0; i < NumHN2; i++)
			{
				float err = 0.0;
				for (j = 0; j < NumHN3; j++)
					err += ad3[j] * w3[i][j];
				ad2[i] = err * h2[i] * (1.0 - h2[i]);
				for (j = 0; j < NumHN1; j++)
				{
					w2[j][i] += LrnRate * h1[j] * ad2[i] +
											Mtm1 * (w2[j][i] - w22[j][i]) +
											Mtm2 * (w22[j][i] - w222[j][i]);
					w222[j][i] = w22[j][i];
					w22[j][i] = w2[j][i];
				}
			}
			// 2nd hidden layer -> 1st hidden layer : HumHN1-> NumIPs
			for (i = 0; i < NumHN1; i++)
			{
				float err = 0.0;
				for (j = 0; j < NumHN2; j++)
					err += ad2[j] * w2[i][j];
				ad1[i] = err * h1[i] * (1.0 - h1[i]);
				for (j = 0; j < NumIPs; j++)
				{
					w1[j][i] += LrnRate * x[p][j] * ad1[i] +
											Mtm1 * (w1[j][i] - w11[j][i]) +
											Mtm2 * (w11[j][i] - w111[j][i]);
					w111[j][i] = w11[j][i];
					w11[j][i] = w1[j][i];
				}
			}
		} // end for each pattern

		ItCnt++;
		AveErr /= NumPats;
		float PcntErr = NumErr / float(NumPats) * 100.0;
		cout.setf(ios::fixed | ios::showpoint);
		cout << setprecision(6) << setw(6) << ItCnt << ": " << setw(12) << MinErr << setw(12) << AveErr << setw(12) << MaxErr << setw(12) << PcntErr << endl;
		trainfile.setf(ios::fixed | ios::showpoint);
		trainfile << MinErr << setw(12) << AveErr << setw(12) << MaxErr << setw(12) << PcntErr << endl;
		if (((abs(AveErr - lastAveErr) <= ObjErr) && (AveErr < 0.02)) || (ItCnt == NumIts))
		{
			cout << abs(AveErr - lastAveErr) << endl;
			break;
		};
	} // end main learning loop
	// Free memory
	trainfile.close();
	delete[] arr;
	delete[] h1;
	delete[] h2;
	delete[] h3;
	delete[] y;
	delete[] ad1;
	delete[] ad2;
}

void TestNet(float **x, float **d, int NumIPs, int NumOPs, int NumPats)
{
	if (NumHN == 1)
	{
		TestNet2(x, d, NumIPs, NumOPs, NumPats);
	}
	else if (NumHN == 2)
	{
		TestNet3(x, d, NumIPs, NumOPs, NumPats);
	}
	else if (NumHN == 3)
	{
		TestNet4(x, d, NumIPs, NumOPs, NumPats);
	}
	else
	{
		cout << "Exceed hidden layer limit" << endl;
	}
}

void TestNet2(float **x, float **d, int NumIPs, int NumOPs, int NumPats)
{
	float PatErr;									 // Absolute error sum of the pattern
	float MinErr;									 // Minimum epoch error
	float AveErr;									 // Aveage error in one epoch
	float MaxErr;									 // maximum epoch error
	float *h1 = new float[NumHN1]; // O/Ps of hidden layer 1
	// float *h2 = new float[NumHN2]; // O/Ps of hidden layer 2
	// float *h3 = new float[NumHN3]; // O/Ps of hidden layer 2
	float *y = new float[NumOPs]; // O/P of Net
	int p, i, j;									// for loops indexes
	long ItCnt = 0;								// Iteration counter
	long NumErr = 0;							// Error counter (added for spiral problem)
	for (p = 0; p < NumPats; p++)
	{
		//forward propagation
		for (i = 0; i < NumHN1; i++)
		{
			float in = 0;
			for (j = 0; j < NumIPs; j++)
				in += w1[j][i] * x[p][j];
			h1[i] = (float)(1.0 / (1.0 + exp(double(-in)))); // Sigmoid fn
		}
		for (i = 0; i < NumOPs; i++)
		{
			float in = 0;
			for (j = 0; j < NumHN1; j++)
			{
				in += w2[j][i] * h1[j];
			}
			y[i] = (float)(1.0 / (1.0 + exp(double(-in)))); // Sigmoid fn
		}
		// Cal error for this pattern
		PatErr = 0.0;
		for (i = 0; i < NumOPs; i++)
		{
			float err = y[i] - d[p][i]; // actual-desired O/P
			if (err > 0)
				PatErr += err;
			else
				PatErr -= err;
			NumErr += ((y[i] < 0.5 && d[p][i] >= 0.5) || (y[i] >= 0.5 && d[p][i] < 0.5)); //added for binary classification problem
		}
		if (PatErr < MinErr)
			MinErr = PatErr;
		if (PatErr > MaxErr)
			MaxErr = PatErr;
		AveErr += PatErr / NumPats;
	}
	//AveErr /= NumPats;
	float PcntErr = NumErr / float(NumPats) * 100.0;
	cout.setf(ios::fixed | ios::showpoint);
	cout << "MinErr:" << setw(12) << MinErr << " AveErr:" << setw(12) << AveErr << " MaxErr:" << setw(12) << MaxErr << " PcntErr:" << setw(12) << PcntErr << endl;
	ofstream testfile;
	testfile.open("./testresult.txt");
	testfile << MinErr << setw(12) << AveErr << setw(12) << MaxErr << setw(12) << PcntErr << endl;
	testfile.close();
	delete[] h1;
	delete[] y;
}

void TestNet3(float **x, float **d, int NumIPs, int NumOPs, int NumPats)
{
	float PatErr;									 // Absolute error sum of the pattern
	float MinErr;									 // Minimum epoch error
	float AveErr;									 // Aveage error in one epoch
	float MaxErr;									 // maximum epoch error
	float *h1 = new float[NumHN1]; // O/Ps of hidden layer 1
	float *h2 = new float[NumHN2]; // O/Ps of hidden layer 2
	float *y = new float[NumOPs];	// O/P of Net
	int p, i, j;									 // for loops indexes
	long ItCnt = 0;								 // Iteration counter
	long NumErr = 0;							 // Error counter (added for spiral problem)
	for (p = 0; p < NumPats; p++)
	{
		//forward propagation
		for (i = 0; i < NumHN1; i++)
		{
			float in = 0;
			for (j = 0; j < NumIPs; j++)
			{
				in += w1[j][i] * x[p][j];
			}
			h1[i] = (float)(1.0 / (1.0 + exp(double(-in)))); // Sigmoid fn
		}
		for (i = 0; i < NumHN2; i++)
		{
			float in = 0;
			for (j = 0; j < NumHN1; j++)
			{
				in += w2[j][i] * h1[j];
			}
			h2[i] = (float)(1.0 / (1.0 + exp(double(-in)))); // Sigmoid fn
		}
		for (i = 0; i < NumOPs; i++)
		{
			float in = 0;
			for (j = 0; j < NumHN2; j++)
			{
				in += w3[j][i] * h2[j];
			}
			y[i] = (float)(1.0 / (1.0 + exp(double(-in)))); // Sigmoid fn
		}
		// Cal error for this pattern
		PatErr = 0.0;
		for (i = 0; i < NumOPs; i++)
		{
			float err = y[i] - d[p][i]; // actual-desired O/P
			if (err > 0)
				PatErr += err;
			else
				PatErr -= err;
			NumErr += ((y[i] < 0.5 && d[p][i] >= 0.5) || (y[i] >= 0.5 && d[p][i] < 0.5)); //added for binary classification problem
		}
		if (PatErr < MinErr)
			MinErr = PatErr;
		if (PatErr > MaxErr)
			MaxErr = PatErr;
		AveErr += PatErr / NumPats;
	}
	//AveErr /= NumPats;
	float PcntErr = NumErr / float(NumPats) * 100.0;
	cout.setf(ios::fixed | ios::showpoint);
	cout << "MinErr:" << setw(12) << MinErr << " AveErr:" << setw(12) << AveErr << " MaxErr:" << setw(12) << MaxErr << " PcntErr:" << setw(12) << PcntErr << endl;
	ofstream testfile;
	testfile.open("./testresult.txt");
	testfile << MinErr << setw(12) << AveErr << setw(12) << MaxErr << setw(12) << PcntErr << endl;
	testfile.close();
	delete[] h1;
	delete[] h2;
	delete[] y;
}

void TestNet4(float **x, float **d, int NumIPs, int NumOPs, int NumPats)
{
	float PatErr;									 // Absolute error sum of the pattern
	float MinErr;									 // Minimum epoch error
	float AveErr;									 // Aveage error in one epoch
	float MaxErr;									 // maximum epoch error
	float *h1 = new float[NumHN1]; // O/Ps of hidden layer 1
	float *h2 = new float[NumHN2]; // O/Ps of hidden layer 2
	float *h3 = new float[NumHN3]; // O/Ps of hidden layer 2
	float *y = new float[NumOPs];	// O/P of Net
	int p, i, j;									 // for loops indexes
	long ItCnt = 0;								 // Iteration counter
	long NumErr = 0;							 // Error counter (added for spiral problem)
	for (p = 0; p < NumPats; p++)
	{
		//forward propagation
		for (i = 0; i < NumHN1; i++)
		{
			float in = 0;
			for (j = 0; j < NumIPs; j++)
			{
				in += w1[j][i] * x[p][j];
			}
			h1[i] = (float)(1.0 / (1.0 + exp(double(-in)))); // Sigmoid fn
		}
		for (i = 0; i < NumHN2; i++)
		{
			float in = 0;
			for (j = 0; j < NumHN1; j++)
			{
				in += w2[j][i] * h1[j];
			}
			h2[i] = (float)(1.0 / (1.0 + exp(double(-in)))); // Sigmoid fn
		}
		for (i = 0; i < NumHN3; i++)
		{
			float in = 0;
			for (j = 0; j < NumHN2; j++)
			{
				in += w3[j][i] * h2[j];
			}
			h3[i] = (float)(1.0 / (1.0 + exp(double(-in)))); // Sigmoid fn
		}
		for (i = 0; i < NumOPs; i++)
		{
			float in = 0;
			for (j = 0; j < NumHN3; j++)
			{
				in += w4[j][i] * h3[j];
			}
			y[i] = (float)(1.0 / (1.0 + exp(double(-in)))); // Sigmoid fn
		}
		// Cal error for this pattern
		PatErr = 0.0;
		for (i = 0; i < NumOPs; i++)
		{
			float err = y[i] - d[p][i]; // actual-desired O/P
			if (err > 0)
				PatErr += err;
			else
				PatErr -= err;
			NumErr += ((y[i] < 0.5 && d[p][i] >= 0.5) || (y[i] >= 0.5 && d[p][i] < 0.5)); //added for binary classification problem
		}
		if (PatErr < MinErr)
			MinErr = PatErr;
		if (PatErr > MaxErr)
			MaxErr = PatErr;
		AveErr += PatErr / NumPats;
	}
	//AveErr /= NumPats;
	float PcntErr = NumErr / float(NumPats) * 100.0;
	cout.setf(ios::fixed | ios::showpoint);
	cout << "MinErr:" << setw(12) << MinErr << " AveErr:" << setw(12) << AveErr << " MaxErr:" << setw(12) << MaxErr << " PcntErr:" << setw(12) << PcntErr << endl;
	ofstream testfile;
	testfile.open("./testresult.txt");
	testfile << MinErr << setw(12) << AveErr << setw(12) << MaxErr << setw(12) << PcntErr << endl;
	testfile.close();
	delete[] h1;
	delete[] h2;
	delete[] h3;
	delete[] y;
}

// 分配一个m*n的二维数组
float **Aloc2DAry(int m, int n)
{
	//Allocates memory for 2D array
	float **Ary2D = new float *[m];
	if (Ary2D == NULL)
	{
		cout << "No memory!\n";
		exit(1);
	}
	for (int i = 0; i < m; i++)
	{
		Ary2D[i] = new float[n];
		if (Ary2D[i] == NULL)
		{
			cout << "No memory!\n";
			exit(1);
		}
	}
	return Ary2D;
}

// 释放数组空间
void Free2DAry(float **Ary2D, int n)
{
	//Frees memory in 2D array
	for (int i = 0; i < n; i++)
		delete[] Ary2D[i];
	delete[] Ary2D;
}

int main()
{
	ifstream fin;
	int i, j, NumIPs, NumOPs, NumTrnPats, NumTstPats, Ordering;
	char Line[500], Tmp[20], FName[20];
	cout << "Enter data filename: ";
	cin >> FName;
	cin.ignore();
	fin.open(FName);
	if (!fin.good())
	{
		cout << "File not found!\n";
		exit(1);
	}
	//read data specs...
	do
	{
		fin.getline(Line, 500);
	} while (Line[0] == ';');						//eat comments
	sscanf(Line, "%s%d", Tmp, &NumIPs); // 输入层神经元数
	fin >> Tmp >> NumOPs;								// 输出层神经元数
	fin >> Tmp >> NumTrnPats;						// 训练样例数
	fin >> Tmp >> NumTstPats;						// 测试样例数
	fin >> Tmp >> NumIts;								// 最大epoch数
	fin >> Tmp >> NumHN;								// 隐层数
	i = NumHN;
	if (i-- > 0)
		fin >> Tmp >> NumHN1; // 第一隐层神经元数
	if (i-- > 0)
		fin >> Tmp >> NumHN2; // 第二隐层神经元数
	if (i-- > 0)
		fin >> Tmp >> NumHN3; // 第三隐层神经元数
	if (i-- > 0)
		fin >> Tmp >> NumHN4; // 第四隐层神经元数
	fin >> Tmp >> LrnRate;	//学习率
	fin >> Tmp >> Mtm1;			// 动量一
	fin >> Tmp >> Mtm2;			// 动量二
	fin >> Tmp >> ObjErr;		// 最大误差
	fin >> Tmp >> Ordering; // 样例读取顺序
	// 判定超参数合法性
	if (NumIPs < 1 || NumIPs > MAXN || NumOPs < 1 || NumOPs > MAXN ||
			NumTrnPats < 1 || NumTrnPats > MAXPATS || NumTrnPats < 1 || NumTrnPats > MAXPATS ||
			NumIts < 1 || NumIts > 20e6 || NumHN1 < 0 || NumHN1 > 50 ||
			LrnRate < 0 || LrnRate > 1 || Mtm1 < 0 || Mtm1 > 10 || Mtm2 < 0 || Mtm2 > 10 || ObjErr < 0 || ObjErr > 10)
	{
		cout << "Invalid specs in data file!\n";
		exit(1);
	}
	float **IPTrnData = Aloc2DAry(NumTrnPats, NumIPs);
	float **OPTrnData = Aloc2DAry(NumTrnPats, NumOPs);
	float **IPTstData = Aloc2DAry(NumTstPats, NumIPs);
	float **OPTstData = Aloc2DAry(NumTstPats, NumOPs);
	// 按行读取训练的数据 前 NumIPs 个为输入神经元(feature) 后 NumOPs 个为输出神经元(target)
	for (i = 0; i < NumTrnPats; i++)
	{
		for (j = 0; j < NumIPs; j++)
			fin >> IPTrnData[i][j];
		for (j = 0; j < NumOPs; j++)
			fin >> OPTrnData[i][j];
	}
	// 按行读取测试的数据 前 NumIPs 个为输入神经元(feature) 后 NumOPs 个为输出神经元(target)
	for (i = 0; i < NumTstPats; i++)
	{
		for (j = 0; j < NumIPs; j++)
			fin >> IPTstData[i][j];
		for (j = 0; j < NumOPs; j++)
			fin >> OPTstData[i][j];
	}
	fin.close();
	ofstream paramfile;
	paramfile.open("./param.txt");
	paramfile << "LR=" << LrnRate << " Mtm1=" << Mtm1 << " Mtm2=" << Mtm2;
	if (NumHN == 1)
		paramfile << " HL1=" << NumHN1 << endl;
	else if (NumHN == 2)
		paramfile << " HL1=" << NumHN1 << " HL2=" << NumHN2 << endl;
	else if (NumHN == 3)
		paramfile << " HL1=" << NumHN1 << " HL2=" << NumHN2 << " HL3=" << NumHN3 << endl;
	paramfile.close();
	TrainNet(IPTrnData, OPTrnData, NumIPs, NumOPs, NumTrnPats, Ordering);
	cout << "Testing mlp" << endl;

	TestNet(IPTstData, OPTstData, NumIPs, NumOPs, NumTstPats);

	Free2DAry(IPTrnData, NumTrnPats);
	Free2DAry(OPTrnData, NumTrnPats);
	Free2DAry(IPTstData, NumTstPats);
	Free2DAry(OPTstData, NumTstPats);
	cout << "End of program.\n";
	//system("PAUSE"); // win32
	//int c = getchar(); // alternative to system("PAUSE") in UNIX
	return 0;
}