#include <iostream>
using namespace std;

int main() {
    // (a) Qualifier: const.
    const int value = 128;
    // value = 256;
    // Answer: assignment of read-only variable

    // (b) References:
    // int &reference;
    // Answer: declared as reference but not initialized

    // (c) Array declaration, this differs between CC and g++.
    int post = 4;
    int postCode[post];
    // Answer: post should be const

    // (d) Void pointer one: How do you point the void pointer somewhere?
    void *vptr;
    // Answer:
    int foo = 5;
    vptr = &foo; // & gets the memory address, which we can assign to the pointer
    cout << vptr << endl;

    // (e) Void pointer two: How do you output the content the void pointer points to?
    int i = 2;
    int *p = &i;
    void *vp = p;
    // Answer:
    // A void pointer is used to hold the address of any type, but without the type being known.
    // If we are to access the content of the memory a void pointer address, we need to type cast it first: (int*)
    // Then it needs to be dereferenced: *()
    cout << *((int*)vp) << endl;

    return 0;
}
