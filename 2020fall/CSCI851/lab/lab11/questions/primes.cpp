#include <iostream>
using namespace std;

template <int p, int i>
class is_prime {
public:
	enum { prim = ( (p % i) && is_prime<p, i - 1>::prim ) }; 
};

template <int p>
class is_prime<p, 1> {
public:
	enum { prim = 1 };
};

template <int i>
class Prime_print {      // primary template for loop to print prime numbers
public:
	Prime_print<i - 1> a; 
	enum { prim = is_prime<i, i - 1>::prim };
	void f() {
		a.f();
		if (prim)
		{
			cout << "prime number:" << i << std::endl;
		}
	} 
};

template<>
class Prime_print<1> {   // full specialization to end the loop
public:
	enum { prim = 0 };
	void f() {}
};


#ifndef LAST 
#define LAST 25
#endif


int main()
{
   Prime_print<LAST> a; 
   a.f(); 
}
