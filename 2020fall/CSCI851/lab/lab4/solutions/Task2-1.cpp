#include <iostream>
#include <fstream>
#include <string>
using namespace std;

int main() {
    ifstream fin;
    fin.open("words");

    if (!fin) {
        cerr << "Could not open file." << endl;
        return -1;
    }

    string line;
    unsigned int counter = 0;

    while (getline(fin, line)) {
        ++counter;
        cout << counter << ": " << line << endl;
    }

    fin.close();
    return 0;
}
