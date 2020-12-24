#include <iostream>
using namespace std;

class thing {
    public:
        int value1 = 5;
        void display() { cout << value2 << endl; }
    private:
        int value2 = 77;
};

int main() {
    thing A;

    cout << A.value1 << endl;
//    cout << A.value2 << endl;
    cout << *(&A.value1 + 1) << endl; // Get the memory location of value2 and dereference it to get the value. Sneaky.

    A.display();

    cin >> *(&(A.value1) + 1); // Change the value of value2. Sneaky.

    A.display();

    return 0;
}
