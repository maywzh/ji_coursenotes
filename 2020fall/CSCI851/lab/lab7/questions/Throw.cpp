#include <iostream>
#include <exception>
using namespace std;

class Test
{
public:
	char* buffer;
	Test(){buffer = new char[1024];throw "e";}
	~Test(){delete[] buffer;}
};

int main()
{
	Test* ptr = new Test();
	delete ptr;
	return 0;
}
