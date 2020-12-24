#include<iostream>
#include<string>
using namespace std;

union Test
{
      int i;
      float f;
};

int main()
{

    Test mine;
    cout << &(mine.i) << "\t\t" << &(mine.f) << endl;
    cout << mine.i << "\t\t" << mine.f << endl;

    mine.i=5;
    cout << mine.i << "\t\t" << mine.f << endl;

    mine.f=6;
    cout << mine.i << "\t\t" << mine.f << endl;

	return 0;
}
