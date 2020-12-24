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
        Cat(string name, string breed, int age);
        void print();
};

double Cat::fee = 17.55;

Cat::Cat(string name, string breed, int age) : name(name), breed(breed), age(age) {}

void Cat::print() {
    cout << "Name: " << name << ", Breed: " << breed << ", Age (months): " << age << ", Licence Fee: $" << fee << endl;
}

int main() {
    Cat cat1("Bindy", "Angry", 3);
    cat1.print();

    return 0;
}
