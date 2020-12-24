#include <iostream>
#include <string>
using namespace std;

class Student {
    private:
        int m_Id;
        int m_Year;
        int m_WAM;
    public:
        Student(int, int, double);
        int getYear() { return m_Year; }

        // Prefix increment operator.
        Student& operator++();

        // Postfix increment operator.
        // To be consistent with the built-in operators, the postfix operators should
        // return the old (unincremented or undecremented) value. That value is
        // returned as a value, not a reference.
        Student operator++(int);
};

Student::Student(int id, int year, double wam) : m_Id(id), m_Year(year), m_WAM(wam) {
}

Student& Student::operator++() {
    ++m_Year;
    return *this;
}

Student Student::operator++(int) {
    // Postfix should return the value that existed before it was incremented.
    // To do this, a temporary object must be created.
    Student temp(*this);
    ++m_Year;
    return temp;
}

int main() {
    Student a(111, 2, 80), b(222, 1, 70), c(333, 3, 65);
    cout << "Student a is year " << a.getYear() << endl;
    cout << "Student b is year " << b.getYear() << endl;
    cout << "Student c is year " << c.getYear() << endl;

    ++a;
    ++b;
    ++c;

    cout << "Student a is now year " << a.getYear() << endl;
    cout << "Student b is now year " << b.getYear() << endl;
    cout << "Student c is now year " << c.getYear() << endl;

    a++;
    b++;
    c++;

    cout << "Student a is now year " << a.getYear() << endl;
    cout << "Student b is now year " << b.getYear() << endl;
    cout << "Student c is now year " << c.getYear() << endl;
    
    return 0;
}
