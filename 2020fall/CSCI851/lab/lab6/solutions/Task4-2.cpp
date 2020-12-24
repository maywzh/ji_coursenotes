#include <iostream>
using namespace std;

class thing {
    public:
        int value1 = 5;
        const int value2 = 77;
};
int main() {
    thing A;

    cout << A.value1 << " " << A.value2 << endl;

    cin >> *(&(A.value1) + 1); // Change the value of value2, a constant. Sneaky.

    cout << A.value2 << endl;

    return 0;
}
