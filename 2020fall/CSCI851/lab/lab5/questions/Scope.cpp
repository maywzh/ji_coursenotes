#include<iostream>
using namespace std;

int a = 1;        // 

int main()
{
    int b = 2;    // 
    cout << b;    // 
    cout << a;    // 
    {             //
      cout << c;  //
      int c = 3;  //
      cout << c;  //
      cout << b;  // 
      cout << a;  // 
    }             // 
    cout << b;    // 
    cout << c;    //
    cout << a;    //
}                 //
cout << b;        // 
cout << a;        //

void anotherFunction()
{
     cout << a;   //
     cout << b;   //
}
