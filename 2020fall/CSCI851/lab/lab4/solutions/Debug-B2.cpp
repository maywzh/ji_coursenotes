#include <iostream>
using namespace std;

void CD(int h, int l);

// Prints integers from highest to lowest, inclusive.

int main() {
    int h, l, t;
    
    cout << "Enter an integer ";
    cin >> h;
    
    cout << "Enter another integer ";
    cin >> l;

    if (h < l) {
        t = l;
        h = l;
        l = t;
    }

    CD(h, l);
    return 0;
}

void CD(int h, int l) {
    for (int x = h; x >= l; --x) {
        cout << x << " " << endl;
    }
}
