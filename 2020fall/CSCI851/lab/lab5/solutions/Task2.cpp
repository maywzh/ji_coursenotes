#include <iostream>
#include <string>
using namespace std;

// The members of a union all share the same memory.
// So assigning values to members i or f would write to the same memory location.
// If the members are of different types, it will simply cast whatever is at the memory location to that type.
union Test {
    float i;
    float f;
};

int main() {

    Test mine;
    cout << &(mine.i) << "\t\t" << &(mine.f) << endl;
    cout << mine.i << "\t\t" << mine.f << endl;

    mine.i = 10;
    cout << mine.i << "\t\t" << mine.f << endl;

    mine.f = 20;
    cout << mine.i << "\t\t" << mine.f << endl;

    return 0;
}
