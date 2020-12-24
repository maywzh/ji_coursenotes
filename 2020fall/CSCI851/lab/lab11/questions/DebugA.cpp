#include<iostream>
using namespace std;

template<typename T>
class CSL       // CommaSeparatedList
{
private:
  T *data;
  int size;
public:
  CSL(T *d, int s);
  void showList();
};

template<typename T>
void CSL<T>::showList()
{
  cout<<"Comma separated list:"<<endl;
  for(int x = 0; x < size; ++x)
    {
      cout<<data[x];
      if(x != size - 1)
	cout<<", ";
    }
  cout<<endl<<endl;
}

class DVD
{
  friend ostream& operator<<(ostream&, const DVD &);
private:
  string title;
  double price;
public:
  void setDVD(string, double);
};

void DVD::setDVD(string DVDTitle, double pr)
{
  title = DVDTitle;
  price = pr;
}

ostream& operator<<(ostream& out, const DVD &aDVD)
{
  out << aDVD.title << " sells for $ " << aDVD.price;
  return out;
}

class Customer
{
  friend ostream& operator<<(ostream&, const Customer &);
private:
  string name;
  double balDue;
public:
  void setCustomer(string, double);
};

void Customer::setCustomer(string CustomerName, double pr)
{
  name = CustomerName;
  balDue = pr;
}

ostream& operator<<(ostream& out, const Customer &aCustomer)
{
  out << aCustomer.name << " owes $" << aCustomer.balDue;
  return out;
}

int main()
{
  int CSL_Size;
  int someInts[] = {12,34,55, 77, 99};
  double someDoubles[] = {11.11, 23.44, 44.55, 123.66};

  DVD someDVDs[2];
  someDVDs[0].setDVD("Bob the Builder", 12.50);
  someDVDs[1].setDVD("Thomas the Tank Engine", 15.00);

  Customer someCustomers[6];
  someCustomers[0].setCustomer("Alice", 23.55);
  someCustomers[1].setCustomer("Bob", 155.77);
  someCustomers[2].setCustomer("Carol",333.88);
  someCustomers[3].setCustomer("David",123.99);
  someCustomers[4].setCustomer("Edith",20.06);
  someCustomers[5].setCustomer("Fred",56999.19);

  CSL_Size = sizeof(someInts)/sizeof(someInts[0]);
  CSL<int> CSL_Integers(someInts,CSL_Size);

  CSL_Size = sizeof(someDoubles)/sizeof(someDoubles[0]);
  CSL<double> CSL_Doubles(someDoubles,CSL_Size);

  CSL_Size = sizeof(someDVDs)/sizeof(someDVDs[0]);
  CSL<DVD> CSL_DVDs(someDVDs,CSL_Size);

  CSL_Size = sizeof(someCustomers)/sizeof(someCustomers[0]);
  CSL<Customer> CSL_Customers(someCustomers,CSL_Size);

  CSL_Integers.showList();
  CSL_Doubles.showList();
  CSL_DVDs.showList();
  CSL_Customers.showList();
}
