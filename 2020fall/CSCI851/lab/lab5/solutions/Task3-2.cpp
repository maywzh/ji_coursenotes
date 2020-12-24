#include <iostream>
#include <cmath>
using namespace std;

// -DPI=3.14159 should be supplied in the compilation command

#ifndef PI
    #define PI 3.14159
#endif // PI

int main(int argc, char* argv[]) {
    if (argc != 2) {
        cerr << "Invalid argument count." << endl;
        return -1;
    }

    const double radius = atof(argv[1]);

    if (radius <= 0) {
        cerr << "Radius must be greater than 0." << endl;
        return -2;
    }

    cout << "Area of a circle: " << (PI * pow(radius, 2)) << endl;
    cout << "Volume of a sphere: " << (4.0/3 * PI * pow(radius, 3)) << endl;

    return 0;
}
