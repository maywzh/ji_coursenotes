/*
This file demonstrates a complex association of a contract between a person and a company.
See 2019-Autumn-CSCI251-S4c.pdf
*/
#include <iostream>
#include <string>
using namespace std;

class Person;
class Contract;

class Company {
    private:
        string m_Name;
        string m_Address;
        Contract *m_Contract; // pointer to Contract object
    public:
        Company(string name = "") : m_Name(name), m_Contract(NULL) {}

        void setContract(Contract *contract) { m_Contract = contract;}

        string getName()        const { return m_Name; }
        Contract *getContract() const { return m_Contract; }
};

class Person {
    private:
        string m_Name;
        Contract *m_Contract; // pointer to Contract object
    public:
        Person(string name = "") : m_Name(name), m_Contract(NULL) {}

        void setContract(Contract *contract) { m_Contract = contract;}

        string getName()        const { return m_Name;}
        Contract *getContract() const { return m_Contract; }
};

class Contract {
    private:
        Person *m_Person; // pointer to Person object
        Company *m_Company; // pointer to Company object
        int m_Number;
        int m_Duration;
        static float m_Rate;

    public:
        Contract(Person* person, Company* company, int number, int duration) : m_Person(person), m_Company(company), m_Number(number), m_Duration(duration) {
            person->setContract(this); // set a link Person->Contract
            company->setContract(this);   // set a link Company->Contract
        }

        string getPersonName()  const { return(m_Person->getName());}
        string getCompanyName() const { return(m_Company->getName()); }
        float getRate()         const { return(m_Rate); }
        int getDuration()       const { return(m_Duration); }
        int getNumber()         const { return(m_Number); }
};

float Contract::m_Rate = 70.00;

int main() {
    Person *person = new Person("John");
    Company *company1 = new Company("Bell Pty Ltd");
    Contract *contract1 = new Contract(person, company1, 5247, 12);

    cout << person->getName() << " has a contract number " << person->getContract()->getNumber() << " with " << person->getContract()->getCompanyName() << endl;
    cout << "Duration: " << person->getContract()->getDuration() << " months" << endl;
    cout << "Rate: $" << person->getContract()->getRate() << "/hr " << endl;

    // John can only have one "active" contract with a company at a time.
    Company *company2 = new Company("Foo Pty Ltd");
    Contract *contract2 = new Contract(person, company2, 6000, 24);

    // However, multiple companies can have a contract with John.
    cout << contract1->getCompanyName() << ": " << contract1->getPersonName() << endl;
    cout << contract2->getCompanyName() << ": " << contract2->getPersonName() << endl;

    // We can safely delete old contracts.
    delete contract1;

    cout << person->getName() << " has a contract number " << person->getContract()->getNumber() << " with " << person->getContract()->getCompanyName() << endl;
    cout << "Duration: " << person->getContract()->getDuration() << " months" << endl;
    cout << "Rate: $" << person->getContract()->getRate() << "/hr " << endl;

    return 0;
}
