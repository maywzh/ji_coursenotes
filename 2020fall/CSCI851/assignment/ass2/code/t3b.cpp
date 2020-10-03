#include <iostream>
using namespace std;
int main() {
    int N;
    cout << "Please input number:" << endl;
    cin >> N;
    for (int i = 0;i < N;i++) {
        for (int j = 1;j <= 12;j++) {
            cout << j << ' ';
        }
        cout << endl;
    }
    return 0;
}