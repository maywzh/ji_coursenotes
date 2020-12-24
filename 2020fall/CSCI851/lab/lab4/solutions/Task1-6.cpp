#include <iostream>
using namespace std;

int main() {
    {
        int n[10] = {3, 5, 7, 10, 3, 5, 4, 4, 9, 3};

        for (auto &element : n) {
            cout << (element * element) << endl;
        }
    }

    {
        // The "range for loop" used above will not work for dynamic memory. An normal for loop is required instead.
        int *n = new int[10] {3, 5, 7, 10, 3, 5, 4, 4, 9, 3};

        for (int i = 0; i < 10; ++i) {
            cout << (n[i] * n[i]) << endl;
        }

        delete n;
    }

    return 0;
}
