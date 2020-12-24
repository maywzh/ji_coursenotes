#include <iostream>
#include <string>
using namespace std;

class Cat {
    private:
        string name;
        string breed;
        int age;
        static double fee;

    public:
        Cat(string name, string breed, int age); // Constructor
        ~Cat(); // Destructor
        Cat(const Cat &cat); // Copy constructor
        Cat& operator=(const Cat &cat); // Copy assignment operator
        void print();
        void printMemory();
};

double Cat::fee = 17.55;

// Constructor
Cat::Cat(string name, string breed, int age) : name(name), breed(breed), age(age) {
    cout << "Constructor called." << endl;
}

// Destructor
Cat::~Cat() {
    cout << "Destructor called." << endl;
}

// Copy constructor
Cat::Cat(const Cat &cat) {
    cout << "Copy constructor called." << endl;
    name = cat.name;
    breed = cat.breed;
    age = cat.age;
}

// Copy assignment operator
Cat& Cat::operator=(const Cat &cat) {
    name = cat.name;
    breed = cat.breed;
    age = cat.age;
    return *this;
}

void Cat::print() {
    cout << "Name: " << name << ", Breed: " << breed << ", Age (months): " << age << ", Licence Fee: $" << fee << endl;
}

void Cat::printMemory() {
    cout << "this: " << this << ", name: " << &name << ", breed: " << &breed << ", age: " << &age << ", fee: " << &fee << endl;
}

int main() {
    Cat cat1("Bindy", "Angry", 3);
    cat1.print();

    // Showing memory locations
    cat1.printMemory();

    // Copy constructor
    Cat cat2(cat1);
    cat2.print();

    // Copy assignment operator
    Cat cat3("Foo", "Tiger", 2);
    Cat cat4("Bar", "Lion", 4);
    cat4 = cat3;
    cat3.print();
    cat4.print();

    return 0;
}
