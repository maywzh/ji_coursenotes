#include <iostream>
#include <random> // default_random_engine
using namespace std;

int main(int argc, char* argv[]) {
    if (argc != 4) {
        cerr << "Program requires 3 arguments: n, mean, stdev." << endl;
        return -1;
    }

    const unsigned int n = atoi(argv[1]); // e.g. 1000
    const double mean = atof(argv[2]); // e.g. 5 (the number that should be generated the most)
    const double stdev = atof(argv[3]); // e.g. 1.5 (the dispersion, relative to the mean)

    if (n < 1) {
        cerr << "n must be a positive integer." << endl;
        return -2;
    }

    default_random_engine engine;
    normal_distribution<double> normal(mean, stdev);

    int dist[10] = {};

    int number;
    for (unsigned int i = 0; i < n; ++i) {
        number = lround(normal(engine));
        ++dist[number];
        // cout << number << ' ';
    }

    cout << "\nDistribution:" << endl;

    for (int i = 0; i < 10; ++i) {
        cout << i << " : " << dist[i] << endl;
    }

    return 0;
}
