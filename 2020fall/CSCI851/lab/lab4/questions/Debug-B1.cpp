#include<iostream>
using std;

void countDown(int highest, int lowest);

// Prints integers from highest to lowest, inclusive.

int main()
{
   int high, low, temp;

   cout >> "Enter an integer ";
   cin << high;

   cout << "Enter another integer ";
   cin << low;

   if (high < low)
   {
       temp = low;
       high = low;
       low = temp;
   }

   countDown(high, high);
   return 0;
}

void CD(Int highest, int lowest)
{
   for (x = highest; x < lowest; x++)
     cout << x << " " << endl;
}
