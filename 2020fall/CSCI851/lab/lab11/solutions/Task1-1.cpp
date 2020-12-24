/*
Functions should be set to virtual in the base class so that the derived class can properly override that function.
If a derived class overrides a function from the base class, it should indicate as such using the "override" keyword.
If a class is not abstract (see below), virtual functions need to be defined, not just declared, or the program will not compile.

Abstract classes:
If a function is set to = 0, it means that the function is pure virtual.
A pure virtual function will prevent that class from being instantiated.
If you try to instantiate a class that contains a pure virtual function, it will not compile.
*/
#include <iostream>
using namespace std;

class B {
    public:
        virtual void X() = 0;
};

class D : B {
    public:
        virtual void X() {cout << "D object" << endl;}
};

int main() {
    // If you try to instantiate a class that contains a pure virtual function, it will not compile.
    // B objB;

    D objD;
}
