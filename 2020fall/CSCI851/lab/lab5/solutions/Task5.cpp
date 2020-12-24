#include <iostream>
#include <exception>
using namespace std;

struct X { };
struct Y { };
struct A { };

// pfv type is pointer to function returning void
typedef void (*pfv)();

void my_terminate() {
    cout << "my_terminate called" << endl;              // 6
    abort();
}

void my_unexpected() {
    cout << "my_unexpected called" << endl;             // 2, 5
    throw;
}

void f() throw(X, Y, bad_exception) {
    throw A();
}

void g() throw(X, Y) {
    throw A();
}

int main() {
    pfv old_term = set_terminate(my_terminate);
    pfv old_unex = set_unexpected(my_unexpected);

    try {
        cout << "In try block, calling f()" << endl;    // 1
        f();
    }
    catch(X) {
        cout << "X Caught" << endl;
    }
    catch(Y) {
        cout << "Y Caught" << endl;
    }
    catch (bad_exception& e1) {
        cout << "bad_exception Caught" << endl;         // 3
    }
    catch (...) {
        cout << "... Caught" << endl;
    }

    try {
        cout << "In try block, calling g()" << endl;    // 4
        g();
    }
    catch(X) {
        cout << "X Caught" << endl;
    }
    catch(Y) {
        cout << "Y Caught" << endl;
    }
    catch (bad_exception& e2) {
        cout << "bad_exception Caught" << endl;
    }
    catch (...) {
        cout << "... Caught" << endl;
    }
}
