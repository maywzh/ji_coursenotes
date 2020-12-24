#include <iostream>
#include <string>
using namespace std;

template <typename T>
T funcExp(T list[], int size) {
    int j;
    T x = list[0];
    T y = list[size - 1];

    cout << "T x = list[0]: " << list[0] << endl;
    cout << "T y = list[size - 1]: " << list[size - 1] << endl;
    cout << "(size - 1) / 2: " << ((size - 1) / 2) << "\n" << endl;

    for (j = 1; j < (size - 1) / 2; j++) {
        cout << "  Iteration (j): " << j << endl;
        cout << "  list[j]: " << list[j] << endl;
        cout << "  x: " << x << endl;
        cout << "  x < list[j]: " << (x < list[j]) << endl;

        if (x < list[j]) {
            x = list[j];
            cout << "    x: " << x << endl;
        }

        cout << "  y: " << y << endl;
        cout << "  list[size - 1 - j]: " << list[size - 1 - j] << endl;
        cout << "  y > list[size - 1 - j]: " << (y > list[size - 1 - j]) << endl;

        if (y > list[size - 1 - j]) {
            y = list[size - 1 - j];
            cout << "    y: " << y << endl;
        }

        cout << endl;
    }

    cout << "x: " << x << endl;
    cout << "y: " << y << endl;
    cout << "(x + y): " << (x + y) << "\n"
         << "---------- END ----------\n" << endl;

    return (x + y);
}

int main() {
    int list[8] = {1, 2, 9, 3, 5, 8, 13, 10};
    string strlist[] = {"one", "fish", "two", "fish", "red", "fish", "blue", "fish"};
    // cout << funcExp(list, 8) << " :: " << funcExp(strlist, 8) << endl;

    funcExp(list, 8); // 17
    funcExp(strlist, 8); // twoblue

    return 0;
}

/*

T x = list[0]: 1
T y = list[size - 1]: 10
(size - 1) / 2: 3

  Iteration (j): 1
  list[j]: 2
  x: 1
  x < list[j]: 1
    x: 2
  y: 10
  list[size - 1 - j]: 13
  y > list[size - 1 - j]: 0

  Iteration (j): 2
  list[j]: 9
  x: 2
  x < list[j]: 1
    x: 9
  y: 10
  list[size - 1 - j]: 8
  y > list[size - 1 - j]: 1
    y: 8

x: 9
y: 8
(x + y): 17
---------- END ----------

T x = list[0]: one
T y = list[size - 1]: fish
(size - 1) / 2: 3

  Iteration (j): 1
  list[j]: fish
  x: one
  x < list[j]: 0
  y: fish
  list[size - 1 - j]: blue
  y > list[size - 1 - j]: 1
    y: blue

  Iteration (j): 2
  list[j]: two
  x: one
  x < list[j]: 1
    x: two
  y: blue
  list[size - 1 - j]: fish
  y > list[size - 1 - j]: 0

x: two
y: blue
(x + y): twoblue
---------- END ----------

*/
