#include<iostream>
#include<fstream>
using namespace std;

int main() {
    int studentId;
    string Name;
    double WAM;

    const string note1 = "Enter ID, name, and WAM";
    const string note2 = "Enter end-of-file key combination (Ctrl-d) to end ";

    ofstream fout;
    fout.open("Students.txt", ios::app);

    if (!fout) {
        cout << "File could not be opened" << endl;
        return -1;
    }

    cout << note1 << "\n" << note2;
    while (cin >> studentId >> Name >> WAM) {
        fout << studentId << " " << Name << " " << WAM << endl;
        cout << note1 << "\n" << note2;
    }
    cout << endl;
    fout.close();

    return 0;
}
