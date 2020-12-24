#include <iostream>
#include <string>
using namespace std;

template<typename T>
class CSL { // CommaSeparatedList
    private:
        T *m_Data;
        int m_Size;
    public:
        CSL(T *data, int size);
        void showList();
};

// Constructor definition (answer to question).
template<typename T>
CSL<T>::CSL(T *data, int size) : m_Data(data), m_Size(size) {
}

template<typename T>
void CSL<T>::showList() {
    cout << "Comma separated list:" << endl;

    for (int x = 0; x < m_Size; ++x) {
        cout << m_Data[x];

        if (x != m_Size - 1) {
            cout << ", ";
        }
    }

    cout << "\n" << endl;
}

class DVD {
        friend ostream& operator<<(ostream &out, const DVD &dvd);

    private:
        string m_Title;
        double m_Price;

    public:
        void setDVD(string title, double price);
};

void DVD::setDVD(string title, double price) {
    this->m_Title = title;
    this->m_Price = price;
}

ostream& operator<<(ostream &out, const DVD &dvd) {
    out << dvd.m_Title << " sells for $" << dvd.m_Price;
    return out;
}

class Customer {
        friend ostream& operator<<(ostream &out, const Customer &customer);

    private:
        string m_Name;
        double m_BalanceDue;

    public:
        void setCustomer(string name, double balanceDue);
};

void Customer::setCustomer(string name, double balanceDue) {
    this->m_Name = name;
    this->m_BalanceDue = balanceDue;
}

ostream& operator<<(ostream &out, const Customer &customer) {
    out << customer.m_Name << " owes $" << customer.m_BalanceDue;
    return out;
}

int main() {
    int intArray[] = {12, 34, 55, 77, 99};
    double doubleArray[] = {11.11, 23.44, 44.55, 123.66};

    DVD dvdArray[2];
    dvdArray[0].setDVD("Bob the Builder", 12.50);
    dvdArray[1].setDVD("Thomas the Tank Engine", 15.00);

    Customer customerArray[6];
    customerArray[0].setCustomer("Alice", 23.55);
    customerArray[1].setCustomer("Bob", 155.77);
    customerArray[2].setCustomer("Carol", 333.88);
    customerArray[3].setCustomer("David", 123.99);
    customerArray[4].setCustomer("Edith", 20.06);
    customerArray[5].setCustomer("Fred", 56999.19);

    CSL<int> integerCSL(intArray, (sizeof(intArray) / sizeof(intArray[0])));
    CSL<double> doubleCSL(doubleArray, (sizeof(doubleArray) / sizeof(doubleArray[0])));
    CSL<DVD> dvdCSL(dvdArray, (sizeof(dvdArray) / sizeof(dvdArray[0])));
    CSL<Customer> customerCSL(customerArray, (sizeof(customerArray) / sizeof(customerArray[0])));

    integerCSL.showList();
    doubleCSL.showList();
    dvdCSL.showList();
    customerCSL.showList();

    return 0;
}
