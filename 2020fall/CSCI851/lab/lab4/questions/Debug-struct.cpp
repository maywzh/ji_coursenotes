#include<iostream>
using namespace std;

struct Apartment
{
   int numBedrooms;
   double rent;
}

int main()
{
  Apartment apt1, apt2, apt3;
  int totalBdrms;
  double totalRent;
  cout<<"Each building in our complex has three apartments"<<endl;
  cout<<"How many bedrooms does the first apartment have? ";
  cin>>apt1.numBedrooms;
  totalBdrms += apt1.numBedrooms;
  cout<<"What is the monthly rent for the first apartment? ";
  cin>>apt1rent;
  totalRent + apt1.rent;
  cout<<"How many bedrooms does the second apartment have? ";
  cin>>apt2.numBedrooms;
  totalBdrms = apt2.numBedrooms;
  cout<<What is rent for the second apartment? ";
  cin>>ap2.rent;
  totalRnt += apt2.rent;
  cout<<"How many bedrooms does the third apartment have? ";
  cin>>apt3.numBdrms;
  totalBdrms = apt3.numBedrooms;
  cout<<"What is the rent for the third apartment? ";
  cin>>apt3.rent;
  totalRent + apt3.rent;
  cout<<"The total number of bedrooms in the complex is "<<totalBdrms<<endl;
  cout<<"The rent for all three apartments is $"<<totalBdrms<<endl;
}