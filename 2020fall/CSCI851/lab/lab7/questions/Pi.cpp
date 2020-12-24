//
// by Floyd Reed July 10, 2002
// after writing this I found a website 
// http://www.daimi.aau.dk/~u951581/pi/MonteCarlo/pimc.html
// that uses almost identical reasoning.  The only real difference
// is I used a quarter of a circle to make it easier to program.
//

#include <stdio.h>
#include <iostream.h>
#include <stdlib.h>	// required for rand function
#include <time.h>	// required for srand seed with time
#include <math.h>	// required for square root calculation

int main(int nNumberofArgs, char* argv[])
{
	srand (time(NULL));		// uses time to seed random generator
	int nCArea = 0;
	int nGuess = 0;
	double dPi;
	cout << "CirclePi, version 2\n";
	cout << "This program attempts to calculate pi by a\n";
	cout << "  very inefficient 'guessing'  or 'Monte Carlo'\n";
	cout << "  method using the relationship between pi and\n";
	cout << "  the area of a circle.\n";
//	cout << "Enter number of guesses to make, the more the\n";
//	cout << "  better the estimate: ";
	nGuess = atoi(argv[1]);
//	cin >> nGuess;
	for (int nI=1; nI<=nGuess; nI++)
	{
		// generate x coordinate
		float fRandomx = rand();		// creates a random number, rand only returns integers so must convert to float to get 0 - 1 range
		float fTotalx = RAND_MAX;		// maximum value of random number
		float fX = fRandomx/fTotalx;	// crates a random zero to 1 fraction
		// generate y coordinate
		float fRandomy = rand();		// creates a random number, rand only returns integers so must convert to float to get 0 - 1 range
		float fTotaly = RAND_MAX;		// maximum value of random number
		float fY = fRandomy/fTotaly;	// crates a random zero to 1 fraction
		// calculate distance
		double dDistance = sqrt((fX*fX)+(fY*fY));	// distance from (0,0) equation
		//cout << "x=";   // you can "turn these on" to see all the calculations
		//cout << fX;
		//cout << "\ty=";
		//cout << fY;
		//cout << " \td=";
		//cout << fDistance;
		if (dDistance <= 1) {nCArea++;}		// counts distances within the quarter circle
		double dCArea = nCArea;
		double dI = nI;
		dPi = 4*dCArea/dI;
		//cout << " \tpi=";
		//cout << fPi;
		//cout << "\n";
	}
	cout << " = pi = \n";			// for some reason this prints after the printf command
	printf("\n%.6f", dPi);
//	cout << "\n(I tried it for 1 billion - it took 4 minutes\n  and estimated pi as 3.141526)\nType 1 and return to close.";
//	cin >> nGuess;
	cout << endl << endl;
	return 0;
}

