#include<iostream>
#include<fstream>
#include<vector>
using namespace std;

int main()
{
   int studentId;
   string name;
   double WAM;  // This is weighted average mark. Integer 0-->100.
   int counter = 0;
 
   vector<int> studentIDs;
   vector<string> Names;
   vector<double> WAMs;

   const string note1 = "Enter ID, name, and WAM";
   const string note2 = "Enter end-of-file key combination (Ctrl-d) to end ";

   cout << note1 << endl << note2;
   while ( cin >> studentId >> name >> WAM )
   {
      studentIDs.push_back(studentId);
      Names.push_back(name);
      WAMs.push_back(WAM);
      cout << note1 << endl << note2;
      counter++;
   }
   cout << endl;

   for ( int i=0; i< counter; i++)
   {
	cout << "Student : " << i+1       << " : " << endl;
        cout << "ID: "   << studentIDs[i] << " : ";
        cout << "Name: " << Names[i]      << " : ";
        cout << "WAM:  " << WAMs[i]       << " : " << endl << endl;
   }

   return 0;
}
