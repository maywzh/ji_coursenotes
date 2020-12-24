#include<iostream>
#include<string>
using namespace std;

class Thing
{
private:
   string name;
   int age;
public:
   Thing(string, int);
   void display();
};

Thing::Thing(string Name, int Age) : name(Name), age(Age){}

void Thing::display()
{
  cout <<"Thing: " << name <<" is " << age << " years old." << endl;
}

int main()
{
     Thing myThing("The big blue dog", 5);
     myThing.display();
}



