/*
This program is useless because:
- The function is pure virtual, meaning the class is abstract (cannot be instantiated). It is designed to be inherited...
- But the final keyword prevents the derived class from overriding the function.
- As a result, any derived class becomes another derived class itself because it cannot override any functions.
*/
#include <iostream>
using namespace std;

class X {
    public:
        virtual void x() final = 0;
};
