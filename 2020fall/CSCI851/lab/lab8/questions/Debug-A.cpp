#include<iostream>
#include<fstream>
#include<string>
#include<iomanip>
using namespace std;
class Person
{
    friend ostream& operator<<(ostream&, const Person);
    friend istream& operator>>(ostream&, Person);
    private:
        int perId;
        string name;
};
ostream& operator<<(ostream &out, const Person per)
{
    out<<per.perId<<" "<<per.name;
    return out;
}
istream& operator>>(ostream &in, Person per)
{
    in>>per.perId>>per.name;
    return in;
}

int main()
{
    Person aPerson;
    ofstream outFile;
    open("Person.txt");
    cout<<"Enter ID and name"<<endl;
    cout<<"Enter end-of-file key combination to end ";
    while (cin>aPerson)
    {
       out<<aPerson<<endl;
       cout<<"Enter ID and name"<<endl;
       cout<<"Enter end-of-file key combination to end ";
    }
    outFile.close;
}
