// This file demonstrates constructors and destructors

#include <iostream>
#include <string>
using namespace std;

class Car {
    private:
        static int count;
    public:
        Car();
        ~Car();
};

int Car::count = 0;

Car::Car() {
    ++count;
    cout << count << " Car object" << (count != 1 ? "s exist" : " exists") << endl;
}

Car::~Car() {
    --count;
    cout << count << " Car object" << (count != 1 ? "s exist" : " exists") << endl;
}

int main(int argc, char* argv[]) {
    Car *car = new Car[atoi(argv[1])]; // Create an array of cars. The constructor is called for each new car.
    delete [] car; // Delete the array. The destructor is called for each car.
}
