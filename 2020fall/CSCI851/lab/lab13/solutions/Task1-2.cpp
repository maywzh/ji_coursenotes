#include <iostream>
using namespace std;

// A
enum Rainbow {
    VIOLET = 1,
    INDIGO,
    BLUE,
    GREEN,
    YELLOW,
    ORANGE,
    RED
};

int rainbowPosition(Rainbow colour) {
    return colour;
}

// B
enum Setting {
    COLS = 10,
    ROWS = 5
};

int main() {
    cout << "The position of the colour green in the rainbow is " << rainbowPosition(GREEN) << ".\n" << endl;

    // Demonstrating how enum can be used as an alternative to independent global variables.
    for (unsigned int row = 0; row < Setting::ROWS; ++row) {
        for (unsigned int col = 0; col < Setting::COLS; ++col) {
            cout << '*';
        }
        cout << endl;
    }

    return 0;
}
