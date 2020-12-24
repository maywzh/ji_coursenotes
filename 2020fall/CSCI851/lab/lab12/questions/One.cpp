#include<iostream>
#include<list>
#include<functional>
using namespace std;

bool compint(const int &a, const int &b){
  return a-3 > b+3;}

int main()
{
  list<int> mylist;

  mylist.push_back(3);
  mylist.push_back(13);
  mylist.push_back(23);
  mylist.push_back(15);
  mylist.push_back(9);
  mylist.push_back(13);
  mylist.push_back(12);
  mylist.push_back(33);

  mylist.sort(compint);

  list<int>::iterator p=mylist.begin();

  while (p!=mylist.end())
    {
      cout << *p << endl; p++;
    }
}
