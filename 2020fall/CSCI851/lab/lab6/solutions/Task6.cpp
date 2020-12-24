#include <iostream>
#include <string>
using namespace std;

class Staff {
    private:
        int id;
        string firstName;
        string lastName;
        double salary;
        char grade;
        int salesMade = 0;
        double bonus = 0;
        static double bonusRate[3][3];

    public:
        Staff(int id, string firstName, string lastName, double salary, char grade);
        void setSalesMade(int number) { salesMade = number; }
        static void displayBonusTable();
        void computeBonus();
        void display();
};

double Staff::bonusRate[3][3] = {
    {0.03, 0.02, 0.005},  // 0-20
    {0.05, 0.035, 0.015}, // 21-50
    {0.075, 0.055, 0.04}  // 51+
};

void Staff::displayBonusTable() {
    string labels[3] = {"0 - 20", "21 - 50", "51+"};
    cout << "-------------------------------------------" << endl;
    cout << "Sales\tGrade A\tGrade B\tGrade C" << endl;

    for (int row = 0; row < 3; ++row) {
        cout << labels[row] << "\t";
        for (int col = 0; col < 3; ++col) {
            cout << bonusRate[row][col] << "\t";
        }
        cout << endl;
    }

    cout << "-------------------------------------------" << endl;
}

void Staff::computeBonus() {
    int row;
    if (salesMade <= 20) {
        row = 0;
    }
    else
        if (salesMade <= 50) {
            row = 1;
        }
        else {
            row = 2;
        }

    switch (grade) {
    case 'A':
        this->bonus = (salary * salesMade * bonusRate[row][0]);
        return;
    case 'B':
        this->bonus = (salary * salesMade * bonusRate[row][1]);
        return;
    case 'C':
        this->bonus = (salary * salesMade * bonusRate[row][2]);
        return;
    default:
        return;
    }
}

Staff::Staff(int id, string firstName, string lastName, double salary, char grade) : id(id), firstName(firstName), lastName(lastName), salary(salary), grade(grade) {}

void Staff::display() {
    cout << "Name: " << firstName << " " << lastName << "\n"
         << "Grade: " << grade << "\n"
         << "Staff ID:" << id << "\n"
         << "Salary: $" << salary << "\n"
         << "Sales made: " << salesMade << "\n"
         << "Bonus: $" << bonus << endl;
}

int main() {
    Staff::displayBonusTable();
    Staff staff1(1, "James", "Miller", 10000, 'A');
    staff1.setSalesMade(21);
    staff1.computeBonus();
    staff1.display();

    return 0;
}
