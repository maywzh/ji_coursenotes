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
};

ostream& operator<<(ostream &out, const Person &person) {
    out << person.id << " " << person.name;
    return out;
}

istream& operator>>(istream &in, Person &person) {
    in >> person.id >> person.name;
    return in;
}

int main() {
    Person person;
    ofstream fout;
    fout.open("Person.txt");

    cout << "Enter ID and name" << endl;
    cout << "Enter end-of-file key combination to end ";

    // Now, instead of cin >> id >> name, we can do this:
    while (cin >> person) {
        fout << person << endl;
        cout << "Enter ID and name" << endl;
        cout << "Enter end-of-file key combination to end ";
    }

    fout.close();

    return 0;
}
