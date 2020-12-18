#include <iostream>
using namespace std;

int main(int argc, char* argv[])
{
        srand(time(0));

        int limit = atoi(argv[1]);
        cout << limit << endl;
        int counter[10]={0};
        
        
        for ( int i=0; i < limit; i++ )
                counter[rand()%10]++;
                
        for ( int i=0; i < 10; i++ )
                cout << i << " : " << counter[i] << endl;
                
        return 0;
}
