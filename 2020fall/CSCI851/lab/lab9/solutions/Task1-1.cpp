#include <iostream>
using namespace std;

class A {
    public:
        A() { cout << "A()" << endl; }
        ~A() { cout << "~A()" << endl; }
};

class B : public A {
    public:
        B() { cout << "B()" << endl; }
        B(int x) { cout << "B(int x)" << endl; }
        ~B() { cout << "~B()" << endl; }
};

class C : public B {
    public:
        C() { cout << "C()" << endl; }
        C(int x): B(x) { cout << "C(int x)" << endl; }
        ~C() { cout << "~C()" << endl; }
};

int main() {
    {
        A a; // A()
        B b; // A(), B()
    } // ~B(), ~A(), ~A()

    B b(5); // A(), B(int x)

    C c; // A(), B(), C()
    {
        C c(0); // A(), B(int x), C(int x)
    } // ~C(), ~B(), ~A()
} // ~C(), ~B(), ~A(), ~B(), ~A()
