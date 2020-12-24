#include <iostream>
using namespace std;

int main() {
    // 1
    {
        cout << "Hello" << endl;
    }

    // 2
    {
        int value = 5;
        // cout >> value >> endl;
        cout << value << endl;
    }

    // 3
    {
        int value;
        cout << "Enter an integer : ";
        // cin << value;
        cin >> value;
    }

    // 4
    {
        int value = 2;
        cout << value << 2 << endl; // 22
        cout << (value << 2) << endl; // 8 (bitwise shift left)
        // cout << value >> 2 >> endl;
        cout << value << 2 << endl;
        // cout << (value >> 2) >> endl;
        cout << (value >> 2) << endl; // 0 (bitwise shift right)
    }

    return 0;
}
