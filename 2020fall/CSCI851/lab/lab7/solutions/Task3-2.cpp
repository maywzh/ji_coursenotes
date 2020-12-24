#include <iostream>
#include <exception>
using namespace std;

class Test {
    public:
        char* buffer;
        Test() {
            cout << "Constructor called." << endl;
            buffer = new char[1024];
            throw "e";
        }

        ~Test() {
            cout << "Destructor called." << endl;
            delete[] buffer;
        }
};

int main() {
    Test* ptr;
    try {
        ptr = new Test();
    }
    catch(...) {
        cout << "Exception caught." << endl;
    }
    delete ptr;

    return 0;
}
