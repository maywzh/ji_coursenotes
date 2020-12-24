#include <iostream>
using namespace std;

// This function is passed as an argument to myFunction()
int bar(int n) {
    cout << (n * 2) << endl;
}

// This function takes an integer and a function as arguments
void myFunction(int n, int (*foo)(int)) {
    foo(n);
}

int main() {
    myFunction(9, bar);

    return 0;
}
