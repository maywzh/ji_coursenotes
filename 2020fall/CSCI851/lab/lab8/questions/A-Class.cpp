#include <iostream>
#include <string>
using namespace std;

class Person;
class Contract;
class Company
{    
  private:
    string name;
    string addresss;
    Contract *contr;
  public:    
    Company(string Name="") : name(Name), contr(NULL) {}  
    string getName() const { return(name); }
    void setContract(Contract *cn) { contr = cn;}
    Contract *getContract() const { return( contr); }
};

class Person
{  
  private:
    string name;
    Contract *contr;
  public:    
    Person(string Name="") : name(Name), contr(NULL) {}
    string getName() const  { return(name);}
    void setContract(Contract *cn) { contr = cn;}
    Contract *getContract() const { return( contr); }
};

class Contract
{    
    Person *pers;
    Company *comp;
    int contNum;
    int duration;
    static float rate;    
  public:       
    Contract( Person* worker, Company* empl, int cN, int dr ) 
    : pers(worker), comp(empl), contNum(cN), duration(dr) 
	 {
	    worker->setContract( this ); // set a link Person->Contract
	    comp->setContract( this );   // set a link Company->Contract
	 }       

    string getPersonName() const { return(pers->getName());}    
    string getCompName() const { return(comp->getName()); }   
    float getRate() const { return(rate); }	
    int getDuration() const { return(duration); }		   
    int getContractNumber() const { return(contNum); }
};
float Contract::rate = 70.00;

int main()
{  
  Person *worker = new Person( "John" );  
  Company *Bell = new Company( "Bell Pty Ltd" );  

  Contract *cont1 = new Contract(worker,Bell,5247,12 );  
   	
  cout <<worker->getName()<<" has a contract number "
  << worker->getContract()->getContractNumber()
  << " with " <<worker->getContract()->getCompName()
  << endl;
  
  cout<<"Duration: " << worker->getContract()->getDuration()
  << " months" << endl;
  cout << "Rate: $" << worker->getContract()->getRate()
  << "/hr " <<endl;

  return 0;
}
