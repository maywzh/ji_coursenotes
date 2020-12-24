#include <iostream>
#include <string>
#include <vector>
using namespace std;

class Date {
    private:
        string date;
    public:
        Date(string date);
        string getDate() { return date; }
};

Date::Date(string date) : date(date) {
}

class Student {
    private:
        string name;

        // Association.
        // Student "has a" birthday (Date object).
        Date birthday;
    public:
        Student(string name, Date birthday);
        void print();
};

Student::Student(string name, Date birthday) : name(name), birthday(birthday) {
}

void Student::print() {
    cout << "Name: " << name << ", Birthday: " << birthday.getDate() << endl;
}

class Subject {
    private:
        // Association.
        // Subject "has a" start date and an end date (Date objects).
        Date startdate;
        Date enddate;

        // Aggregation.
        // Subject contains one or more Student objects.
        // A Student object can still exist independently.
        vector<Student> students;
    public:
        Subject(Date startdate, Date enddate);
        void addStudent(Student student);
        void print();
};

Subject::Subject(Date startdate, Date enddate) : startdate(startdate), enddate(enddate) {
}

void Subject::addStudent(Student student) {
    students.push_back(student);
}

void Subject::print() {
    cout << "Subject start date: " << startdate.getDate() << ", Subject end date: " << enddate.getDate() << "\n"
         << "Students:\n" << endl;

    for (auto &student : students) {
        student.print();
    }
}

int main() {
    Subject subject(Date("01-03-2019"), Date("30-06-2019"));
    Student student1("John Miller", Date("22-04-1990"));
    Student student2("Emma Stone", Date("22-04-1990"));
    subject.addStudent(student1);
    subject.addStudent(student2);
    subject.print();

    return 0;
}
