/*
 * @Author       : maywzh
 * @Date         : 2020-12-25 01:38:44
 * @LastEditTime : 2020-12-25 01:41:10
 * @LastEditors  : maywzh
 * @Description  : 
 * @FilePath     : /ji_coursenotes/2020fall/CSCI851/lab/lab8/solutions/Task2-4.cpp
 * @
 * Copyright (c) 2017 maywzh.
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#include <iostream>
#include <string>
using namespace std;

class Person;
class Contract;

class Company
{
private:
    string m_Name;
    string m_Address;
    Contract *m_Contract; // pointer to Contract object
public:
    Company(string name = "") : m_Name(name), m_Contract(NULL) {}

    void setContract(Contract *contract) { m_Contract = contract; }

    string getName() const { return m_Name; }
    Contract *getContract() const { return m_Contract; }
};

class Person
{
private:
    string m_Name;
    Contract *m_Contract; // pointer to Contract object
public:
    Person(string name = "") : m_Name(name), m_Contract(NULL) {}

    void setContract(Contract *contract) { m_Contract = contract; }

    string getName() const { return m_Name; }
    Contract *getContract() const { return m_Contract; }
};

class Contract
{
private:
    Person *m_Person;   // pointer to Person object
    Company *m_Company; // pointer to Company object
    int m_Number;
    int m_Duration;
    static float m_Rate;

public:
    Contract(Person *person, Company *company, int number, int duration) : m_Person(person), m_Company(company), m_Number(number), m_Duration(duration)
    {
        person->setContract(this);  // set a link Person->Contract
        company->setContract(this); // set a link Company->Contract
    }

    string getPersonName() const { return (m_Person->getName()); }
    string getCompanyName() const { return (m_Company->getName()); }
    float getRate() const { return (m_Rate); }
    int getDuration() const { return (m_Duration); }
    int getNumber() const { return (m_Number); }
};

float Contract::m_Rate = 70.00;

int main()
{
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
