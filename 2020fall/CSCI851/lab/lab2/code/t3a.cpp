#include <iostream>
using namespace std;
int main() {
    string number;
    cout << "Please input number:" << endl;
    cin >> number;
    for (int i = 0;i < 10;i++) {
        cout << number << endl;
    }
    return 0;
}