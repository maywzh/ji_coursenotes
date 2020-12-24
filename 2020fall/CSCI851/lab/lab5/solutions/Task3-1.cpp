#include <iostream>
using namespace std;

// A macro that is only enabled if -DFOO is supplied in the compilation command

#ifdef FOO
    #define BAR cout << __LINE__ << endl
#else
    #define BAR // do nothing
#endif // FOO

int main() {
    cout << "This is a test." << endl;
    BAR;

    return 0;
}
