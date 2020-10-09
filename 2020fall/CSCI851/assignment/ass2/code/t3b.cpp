#include <iostream>
using namespace std;
int main() {
    int N;
    cout << "Please input number:" << endl;
    cin >> N;
    for (int i = 1;i <= 12;i++) {
        cout << N * i << ' ';
    }
    return 0;
}