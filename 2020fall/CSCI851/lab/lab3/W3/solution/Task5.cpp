#include <iostream>
using namespace std;

int main(int argc, char* argv[]) {
    int sum = 0;
    cout << "argc = " << argc << endl;

    // argv[0] is the name of the executable. The other indexes contain values supplied by the user.

    if (argc > 1) {
        for (unsigned int i = 1; i < argc; ++i) {
            cout << "arg " << i << " " << argv[i] << endl;
            sum += atoi(argv[i]); // convert char* to integer
        }
    }

    cout << "Total = " << sum << endl;

    return 0;
}
