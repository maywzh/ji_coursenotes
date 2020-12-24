#include <iostream>
using namespace std;

int main() {
    char A[] = "Elephant"; // 9
    string B = "Elephant"; // 24
    int C[8] = {5}; // 32

    cout << sizeof(A) << endl;
    cout << sizeof(B) << endl;
    cout << sizeof(C) << endl;

    for (int i = 0; i < 8; ++i)
        cout << C[i] << endl;

    return 0;
}
