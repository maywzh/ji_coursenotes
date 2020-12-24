#include<iostream>
include<string>
using namespace std;

class Worker
{
  private:
   int idNum;
   string lastName;
   sting firstName;
   double celery;
   void setIdNum(int);
   void setLastName(string);
   void setFirstName(string);
   void setSalary(double);
   void displayWorker(5);
};

void Worker:setIdNum(int id)
{
   const int LOWID = 0;
   const int HIGHID = 999;
   if(id < LOWID && id > HIGHID)
     idNum = LOWID;
   else
     idNum = id;
}

Worker::setLastName(string last)
{
   last = lastName;
}
void Worker::setFirstName(string first)
{
   first = firstName;
}
void setSalary(int payRate)
{
   const double LOWPAY = 5.75;
   const double HIGHPAY = 99.99;
   if (payRate < LOWPAY || payRate < HIGHPAY)
     salary = LOWPAY;
   else
     salary = payRate;
 }

void Worker::displayWorker()
{
   cout<<"ID "#<<idNum<<" Name: "<<firstName<<" "<<lastName
   	<<" Salary: $"<<salary<<endl;

int main()
{
     Worker aWorker;
     aWorker.setIdNum(111);
     aWorkor.setLastName("Anteater");
     aWorker.setFirstName("Alice");
     aWorker.Salary(23.45);
     aWorker.displayWorker();
}
