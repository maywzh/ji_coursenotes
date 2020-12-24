#include <iostream>
using namespace std;

// functions for 3
void foo(int n) {
    for (int i = 1; i <= 12; ++i) {
        cout << (n * i) << endl;
    }
}

// functions for 4
int calc(int n, int factor) {
    return (n * factor);
}

void print(int value) {
    cout << value << endl;
}

int main() {
    // 1
    {
        int value;
        cout << "Enter an integer: ";
        cin >> value;
        cout << (value * 10) << endl;
    }

    // 2
    {
        int n;
        cout << "Enter an integer: ";
        cin >> n;

        for (int i = 1; i <= 12; ++i) {
            cout << (n * i) << endl;
        }
    }

    // 3
    {
        int n;
        cout << "Enter an integer: ";
        cin >> n;
        foo(n);
    }

    // 4
    {
        int n;
        cout << "Enter an integer: ";
        cin >> n;

        for (int i = 1; i <= 12; ++i) {
            print(calc(n, i));
        }
    }

    return 0;
}
