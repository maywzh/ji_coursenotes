#include<iostream>
#include<string>
using namespace std;

class Student
{
    int stuID;
    int year;
    int WAM;
    Student(const int, const int, const double);
    void getYear();
    Student& operator++();
};
Student::Student(const int i, const int y, const int w)
{
  stuID=i;
  year = y;
  WAM = g;
}
void Student::getYear()
{
  cout<<year;
}
Student Student:operator++()
{
  ++year;
  return *this;
}
int main()
{
  Student a(111,2,80),b(222,1,70),c(333,3,65);
  cout<<"Student a is year ";
  a.getYear();
  cout<<endl;
  cout<"Student b is year ";
  b.showYear;
  cout<<endl;
  cout<<"Student c is year ";
  c.getYear();
  cout<<enl;
  ++a;
  b++
  ++c;
  cout<<"Student a is now year ";
  a.getYear();
  cout<<endl;
  cout<<"Student b is now year ";
  bgetYear();
  cout<<endl;
  cout<<"Student c is now year ";
  c.sgetYear();
  cout<<endl;
}
