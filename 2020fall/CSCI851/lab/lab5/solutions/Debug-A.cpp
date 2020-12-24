#include <iostream>
#include <cmath>
using namespace std;

#define e 2.718281828459045 // macro for Euler's number
#define min(a, b) (((a) < (b)) ? (a) : (b)) // macro that returns the smallest number of the two

int main(int argc, char* argv[]) {
    if (argc != 3) {
        cerr << "Enter two integers after the program name please!" << endl;
        return 1;
    }

    int a = atoi(argv[1]);
    int b = atoi(argv[2]);

    cout << "log10(10) should be 1 : " << log10(10.0) << endl;
    cout << "log(e) should be 1    : " << log(e) << endl;

    cout << "Lower input : " << min(a, b) << endl;
    cout << "Higher input : " << abs(min(-a, -b)) << endl;

    cout << (a * b) << endl;
    cout << pow(10, log10(a) + log10(b)) << endl;
    cout << pow(e, log(a) + log(b)) << endl;

    return a;
}
