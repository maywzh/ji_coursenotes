// CC Task3-1.cpp libmash.a -o Mash
#include "mash.h"
#include <iostream>
using namespace std;

int main(int argc, char* argv[]) {
    for (int i = 0; i < argc; ++i) {
        cout << "Applying mash to " << argv[i] << ": " << mash(argv[i]) << endl;
    }

    return 0;
}

/*

$ ./Mash a b c 1 2 3
Applying mash to ./Mash: 6e
Applying mash to a: e8
Applying mash to b: 00
Applying mash to c: 72
Applying mash to 1: b3
Applying mash to 2: 52
Applying mash to 3: 62

*/
