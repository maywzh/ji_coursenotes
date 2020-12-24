#include <iostream>
using namespace std;

int main(int argc, char* argv[])
{
        srand(time(0));

        for ( int i=0; i < 10; i++ )
                cout << rand() << endl;

        return 0;
}
