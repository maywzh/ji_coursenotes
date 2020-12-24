#include<iostream>
using namespace std;
class DriverUsingInts
{
     private:
          int idNum;
          int isMale;
          int isOver25;
          int hasPreviousTickets;
          int tookDriversEd;
          int residesUrbanArea;
          int ownsMultipleVehicles;
          int drivesOver10KmsToWork;
};

class DriverUsingBools
{
     private:
	int idNum;
	bool isMale;
        bool isOver25;
        bool hasPreviousTickets;
        bool tookDriversEd;
        bool residesUrbanArea;
        bool ownsMultipleVehicles;
        bool drivesOver10KmsToWork;
};

class DriverUsingBits
{
     private:
         int idNum;
         unsigned isMale:1;
         unsigned isOver25:1;
         unsigned hasPreviousTickets:1;
         unsigned tookDriversEd:1;
         unsigned residesUrbanArea:1;
         unsigned ownsMultipleVehicles:1;
         unsigned drivesOver10KmsToWork:1;
};

int main()
{

     cout << "Size of an int on this system is " <<
        sizeof(int) <<endl;
     cout << "Size of a bool on this system is " <<
	sizeof(bool) << endl;
     cout << "Size of DriverUsingInts is " <<
        sizeof(DriverUsingInts) << endl;
     cout << "Size of DriverUsingBools is " <<
	sizeof(DriverUsingBools) << endl;
     cout <<"Size of DriverUsingBits is "<<
        sizeof(DriverUsingBits) << endl;
     return 0;
}
