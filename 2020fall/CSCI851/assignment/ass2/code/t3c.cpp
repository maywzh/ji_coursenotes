#include <iostream>
using namespace std;
void printfunc(int N) {
    for (int i = 1;i <= 12;i++) {
        cout << N * i << ' ';
    }
}
int main() {
    int N;
    cout << "Please input number:" << endl;
    cin >> N;
    printfunc(N);
    return 0;
}