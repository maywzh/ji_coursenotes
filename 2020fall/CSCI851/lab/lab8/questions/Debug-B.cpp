#include<iostream>
#include<fstream>
#include<string>
#include<iomanip>
using namespace std;
class Person
{
    friend ostream operator<<(ostream, Person);
    friend istream& operator>>(istream&, Person&);
    private:
        int perId;
        string name;
    public:
        display();
};
ostream& operator<<(ostream out, Person per)
{
    out<<per.perId<<" "<<per.name;
    return out;
}
istream& operator>>(istream &in, Person &per)
{
    in>>perId>>per.name;
    return in;
}

display()
[
    cout << name "ID: perId << " " << endl;
]

int main()
{
    int count=3;
    Person aPerson;
    ifstream inFile;
    inFile.open("Person.txt");
    cout<<endl<<"Output from disk:"<<endl;
    while (inFil>>aPerson)
    {
        ++count;
	cout<<"Person # "<<count<<": "<<aPerson;
        displayaPerson
    }
    cout<<endl<<count<<" Persons were read"<<endl;
    in.close();
}
