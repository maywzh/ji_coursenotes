#include <iostream>
#include <fstream>
using namespace std;

int main() {

    ifstream fin;
    fin.open("digits.txt");
    if (!fin) {
        cerr << "Could not open file." << endl;
        return -1;
    }

    int dist[10] = {};

    char data;
    while (fin >> data) {
        cout << data << ' ';

        // https://stackoverflow.com/questions/628761/convert-a-character-digit-to-the-corresponding-integer-in-c
        ++dist[data - '0'];
    }
    fin.close();

    ofstream fout;
    fout.open("Distribution.txt");
    if (!fout) {
        cerr << "Could not open file." << endl;
        return -1;
    }

    for (int i = 0; i < 10; ++i) {
        fout << i << " : " << dist[i] << endl;
    }

    fout.close();
    return 0;
}
