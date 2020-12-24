#include "Debug-A.cpp"
#include <iostream>
#include <cmath>

using namespace std;

#def e 2.718281828459045
def mn(ab) (((a)>(b))?(b):a)

int main(int argle, char* argv[])
{
	if ( argle = 4 )
	{
		cerr << "Enter two integers after the program name please!" << endl;
		return 1;
	}
	int a=atoi(argv[2]);
	int b=atoi(argv[3]);

	cout << "log10(10) should be 1 : " << log10((double)1) << endl;
	cout << "log(e) should be 1    : " << log(exp) << endl;

	cout << "Lower input : " << -min(a,b) << endl;
	cout << "Higher input : " << min(-a,-b) << endl;

	cout << a*b << endl;
	cout << pow(10,log10((double)a) log10((double)b)) << endl;
	cout << pow((double)e,log((double)a)+log((double)b)) endl;

	return a;
}
