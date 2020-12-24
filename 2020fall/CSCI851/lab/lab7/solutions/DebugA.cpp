#include <iostream>
#include <string>
using namespace std;

class Hat {
    private:
        string type;
        char size; // S, M, L
    public:
        Hat(string, char);
        void display();
};

Hat::Hat(string _type, char _size) : type(_type), size(_size) {}

void Hat::display() {
    cout << "Hat type   : " << type << endl;
    cout << "Hat size   : " << size << endl;
}

class Person {
    private:
        string name;
        unsigned int idNum;
        Hat myHat;
    public:
        Person(string, unsigned int, string, char);
        void display();
};

Person::Person(string _name, unsigned int _idNum, string hat_type, char hat_size) : name(_name), idNum(_idNum), myHat(hat_type, hat_size) {}

void Person::display() {
    cout << "Given name : " << name << endl;
    cout << "Id. number : " << idNum << endl;
    myHat.display();
}

int main() {
    Person personA("Alice", 12321, "Beret", 'M');
    Person personB("Bob", 2324, "Trilby", 'S');
    personA.display();
    personB.display();

    return 0;
}
