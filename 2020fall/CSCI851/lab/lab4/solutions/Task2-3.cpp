#include <iostream>
#include <fstream>
using namespace std;

int main() {
    ofstream fout;
    fout.open("output.txt");
    if (!fout) {
        cerr << "Could not open file." << endl;
        return -1;
    }

    fout << "test";
    fout.close();

    ifstream fin;
    fin.open("output.txt", ios::binary);
    if (!fin) {
        cerr << "Could not open file." << endl;
        return -1;
    }

    char data;
    while (fin >> data) {
        cout << data;
    }
    cout << endl;

    fin.close();
    return 0;
}
