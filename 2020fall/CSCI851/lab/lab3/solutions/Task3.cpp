#include <iostream>
using namespace std;

int main() {
    // Using subscripting, i.e. array: [ ]

    int foo[3];

    for (unsigned int i = 0; i < 3; ++i) {
        cout << "Enter an integer: ";
        cin >> foo[i];
    }

    for (unsigned int i = 0; i < 3; ++i) {
        cout << foo[i] << endl;
    }

    // Using pointers

    int input;
    for (unsigned int i = 0; i < 3; ++i) {
        cout << "Enter an integer: ";
        cin >> input;
        *(foo + i) = input; // same as foo[i]
    }

    for (unsigned int i = 0; i < 3; ++i) {
        cout << *(foo + i) << endl;
    }

    cout << "An array name is just a pointer to the first element in the array." << endl;
    cout << "Memory address of array, i.e. foo: " << foo << endl;
    cout << "Memory address of first element in array, i.e. &foo[0]: " << &foo[0] << endl;
    cout << "Dereference the pointer to access first element, i.e. *foo: " << *foo << endl;
    cout << "Dereference the pointer + 1 to access second element, i.e. *(foo + 1): " << *(foo + 1) << endl;

    return 0;
}
