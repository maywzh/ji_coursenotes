#include <iostream>
using namespace std;

void countDown(int highest, int lowest);

// Prints integers from highest to lowest, inclusive.

int main() {
    int high, low, temp;

    cout << "Enter an integer (high) ";
    cin >> high;

    cout << "Enter another integer (low) ";
    cin >> low;

    if (high < low) {
        temp = low;
        high = low;
        low = temp;
    }

    countDown(high, low);
    return 0;
}

void countDown(int highest, int lowest) {
    for (int x = highest; x >= lowest; --x) {
        cout << x << " " << endl;
    }
}
