#include <iostream>
#include <ctime>
#include <cassert>
using namespace std;

// -DSIZE=1 should be supplied in the compilation command

#ifndef SIZE
    #define SIZE 1
#endif // SIZE

int main() {
    #ifndef NDEBUG
        cout << "We are in debug mode." << endl;
    #endif

    assert(SIZE >= 1 && SIZE <= 10);

    const unsigned int arraySize = SIZE * SIZE;

    srand(time(0));
    int foo[arraySize] = {};

    for (unsigned int i = 0; i < arraySize; ++i) {
        foo[i] = rand() % 1000 + 1;
    }

    for (unsigned int i = 0; i < arraySize; ++i) {
        cout << foo[i] << ' ';
    }
    cout << endl;

    return 0;
}
