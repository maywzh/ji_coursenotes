#include<iostream>
#include<fstream>
using namespace std;

int main()
{
   int studentId;
   string Name;
   double WAM;  // This is weighted average mark. Integer 0-->100.

   const string note1 = "Enter ID, name, and WAM";
   const string note2 = "Enter end-of-file key combination (Ctrl-d) to end ";

   ofstream outFile;
   outFile.open("Students.txt");

   if (!outFile.good())
      {
         cout << "File could not be opened" << endl;
         return 1;
      }

   cout << note1 << endl << note2;
   while ( cin >> studentId >> Name >> WAM )
   {
      outFile << studentId << " " << Name << " " << WAM << endl;
      cout << note1 << endl << note2;
   }
   cout << endl;
   outFile.close();

   return 0;
}
