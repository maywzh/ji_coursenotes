#include "mylibrary.h"

#include <iostream>
using namespace std;

int main() {
    // These comments reflect what the program should do.
    // functionA should take 3 integers from the user.
    // functionB should add those 3 integers together.

    int one, two, three, sum;
    functionOne(one, two, three);
    sum = functionTwo(one, two, three);
    cout << "The product of " << one << ", " << two << ", and " << three << " is " << sum;

    return 0;
}
