#include <iostream>
using namespace std;

int calculate(int N, int i) {
    return N * i;
}

void printing(int N) {
    for (int i = 1;i <= 12;i++) {
        cout << calculate(N, i) << ' ';
    }
}
int main(int argc, char* argv[]) {
    int N;
    cout << "Please input number:" << endl;
    cin >> N;
    printing(N);
    return 0;
}