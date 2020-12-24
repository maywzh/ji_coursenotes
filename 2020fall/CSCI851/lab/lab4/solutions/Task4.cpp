#include <iostream>
#include <string>
using namespace std;

struct Dog {
    string name;
    string breed;
    int age;
    const double fee = 17.55;

    void setData(string _name, string _breed, int _age);
    void print();
};

void Dog::setData(string _name, string _breed, int _age) {
    name = _name;
    breed = _breed;
    age = _age;
}

void Dog::print() {
    cout << "Name: " << name << ", Breed: " << breed << ", Age (months): " << age << ", Licence Fee: $" << fee << endl;
}

int main() {
    Dog dog1;
    dog1.setData("Buddy", "Kelpie", 11);
    dog1.print();

    return 0;
}
