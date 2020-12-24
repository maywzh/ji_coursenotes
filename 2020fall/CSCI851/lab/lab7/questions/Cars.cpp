#include<iostream>
#include<string>
using namespace std;

class Car
{
	private:
		static int count;
	public:
		Car();
		~Car();
};

int Car::count = 0;
Car::Car()
{
	++count;
	cout<<count<<" Car object";
	if(count != 1)
		cout<<"s exist";
	else
		cout<<" exists";
	cout<<endl;
}

Car::~Car()
{
	--count;
	cout<<count<<" Car object";
	if(count != 1)
		cout<<"s exist";
	else
	    cout<<" exists";
	cout<<endl;
}

int main(int argc, char* argv[])
{
	Car *car = new Car[atoi(argv[1])];
	delete [] car;
}
