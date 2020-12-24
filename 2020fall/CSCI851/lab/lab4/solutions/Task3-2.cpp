#include <iostream>
#include <ctime>
using namespace std;

int main(int argc, char* argv[]) {
    if (argc != 2) {
        cerr << "Invalid argument count." << endl;
        return -1;
    }

    const unsigned int n = atoi(argv[1]);

    if (n < 1) {
        cerr << "n must be a positive integer." << endl;
        return -2;
    }

    srand(time(0));
    int dist[10] = {};

    int number;
    for (unsigned int i = 0; i < n; ++i) {
        number = (rand() % 10);
        ++dist[number];
        // cout << number << ' ';
    }

    cout << "\nDistribution:" << endl;

    for (int i = 0; i < 10; ++i) {
        cout << i << " : " << dist[i] << endl;
    }

    return 0;
}
