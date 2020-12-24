#include <iostream>
#include <string>
using namespace std;

class Worker {
    private:
        int idNum;
        string lastName;
        string firstName;
        double salary;
    public:
        void setIdNum(int);
        void setLastName(string);
        void setFirstName(string);
        void setSalary(double);
        void displayWorker();
};

void Worker::setIdNum(int id) {
    const int LOWID = 0;
    const int HIGHID = 999;

    if (id < LOWID && id > HIGHID) {
        idNum = LOWID;
    }
    else    {
        idNum = id;
    }
}

void Worker::setLastName(string last) {
    lastName = last;
}

void Worker::setFirstName(string first) {
    firstName = first;
}

void Worker::setSalary(double payRate) {
    salary = payRate;
}

void Worker::displayWorker() {
    cout
            << "ID #: " << idNum << "\n"
            << "Name: " << firstName << " " << lastName << "\n"
            << "Salary: $" << salary << endl;
}

int main() {
    Worker aWorker;
    aWorker.setIdNum(111);
    aWorker.setLastName("Anteater");
    aWorker.setFirstName("Alice");
    aWorker.setSalary(23.45);
    aWorker.displayWorker();
}
