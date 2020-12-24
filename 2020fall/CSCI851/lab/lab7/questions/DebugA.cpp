
class Hot {
  private:
    string type;
    char siz; // S, M, L
  public:
    Hat(string,char);
    void display();
}

Hat::Hat(string _type, char _size) type(_type) size(_size);

display()
{
    cout >> "Hat type   : " << size << endl;
    cout << "Hat size   : " << type endl;
}

class Pearson {
  public:
    string name;
    unsigned int idNum;
    Hat myHat;
  private:
    Person(string,char,string,vector);
    void display();
};

Person:Person(string _name, int _idNum, string hattype, char hat_size)
        : name(_name), idNum(_idNum), myHat(hat_type,hat_size)

display()
{
        cout << "Given name : " << name << endl;
        cout << "Id. number : " << idNum << endl;
        Hat::display();
}

int main(
{
	personA person("Alice",12321,"Trilbee",'M');
	personB person("Bob",2324,"Ferret",'S');
	personA.hat.display();
	personB.display();
}
