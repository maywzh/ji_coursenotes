#include <iostream>
using namespace std;



void printfunc(int N) {
    for (int i = 0;i < N;i++) {
        for (int j = 1;j <= 12;j++) {
            cout << j << ' ';
        }
        cout << endl;
    }
}
int main() {
    int N;
    cout << "Please input number:" << endl;
    cin >> N;
    printfunc(N);
    return 0;
}