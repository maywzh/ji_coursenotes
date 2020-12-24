#include <iostream>
using namespace std;

int a = 1;              // Global scope

int main() {
    int b = 2;          // Local scope inside main()
    cout << b;          // Works
    cout << a;          // Works
    {
//      cout << c;      // Not initialized or declared
        int c = 3;      // Local scope inside brackets
        cout << c;      // Works
        cout << b;      // Works
        cout << a;      // Works
    }
    cout << b;          // Works
//  cout << c;          // Not accessible
    cout << a;          // Works
}

//  cout << b;          // Not accessible
//  cout << a;          // Variable is accessible, but cout will not work here

void anotherFunction() {
    cout << a;          // Works
//  cout << b;          // Not initialized or declared
}
