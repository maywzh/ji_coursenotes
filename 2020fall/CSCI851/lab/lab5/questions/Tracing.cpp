#include <iostream>
#include <exception>
using namespace std;
 
struct X { };
struct Y { };
struct A { };
 
// pfv type is pointer to function returning void
typedef void (*pfv)();
 
void my_terminate() {
  cout << "Call" << endl;
  abort();
}
 
void my_unexpected() {
  cout << "Call" << endl;
  throw;
}
 
void f() throw(X,Y, bad_exception) {
  throw A();
}
 
void g() throw(X,Y) {
  throw A();
}
 
int main()
{
  pfv old_term = set_terminate(my_terminate);
  pfv old_unex = set_unexpected(my_unexpected);
  try {
    cout << "In try block" << endl;
    f();
  }
  catch(X) {
    cout << "Caught" << endl;
  }
  catch(Y) {
    cout << "Caught" << endl;
  }
  catch (bad_exception& e1) {
    cout << "Caught" << endl;
  }
  catch (...) {
    cout << "Caught" << endl;
  }

try {
    cout << "In try block" << endl;
    g();
  }
  catch(X) {
    cout << "Caught" << endl;
  }
  catch(Y) {
    cout << "Caught" << endl;
  }
  catch (bad_exception& e2) {
    cout << "Caught" << endl;
  }
  catch (...) {
    cout << "Caught" << endl;
  }
}
