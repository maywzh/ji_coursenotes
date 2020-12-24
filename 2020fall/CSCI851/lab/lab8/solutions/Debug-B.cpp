#include <iostream>
#include <fstream>
#include <string>
using namespace std;

class Person {
    friend ostream& operator<<(ostream &out, const Person &person);
    friend istream& operator>>(istream &in, Person &person);

    private:
        int id;
        string name;
    public:
        void display();
};

ostream& operator<<(ostream &out, const Person &person) {
    out << person.id << " " << person.name;
    return out;
}

istream& operator>>(istream &in, Person &person) {
    in >> person.id >> person.name;
    return in;
}

void Person::display() {
    cout << "ID: " << id << ", Name: " << name << endl;
}

int main() {
    int count = 0;
    Person person;
    ifstream fin;
    fin.open("Person.txt");
    cout << "Output from disk:" << endl;

    // Now, instead of fin >> id >> name, we can do this:
    while (fin >> person) {
        ++count;
        cout << "Person #" << count << ": ";
        person.display();
    }

    cout << count << " Persons were read." << endl;
    fin.close();

    return 0;
}
