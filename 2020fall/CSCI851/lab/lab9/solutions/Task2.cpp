/*
A House object contains a pointer to a Pig object.
If the house gets destroyed, so does the pig, via the deconstructor.
Hence, the relationship is of "composition".
*/
#include <iostream>
#include <string>
using namespace std;

class Pig {
    public:
        Pig(string name);
        ~Pig();
        string getName() { return m_Name; }

    protected:
        string m_Name;
};

Pig::Pig(string name) : m_Name(name) {
    cout << "Pig constructed: " << m_Name << endl;
}

Pig::~Pig() {
    cout << "Pig destructed: " << m_Name << endl;
}

class House {
    public:
        House(string material, Pig *pig);
        ~House();
        string getMaterial() { return m_Material; }
        Pig *getPig() { return m_Pig; }

    protected:
        string m_Material;
        Pig *m_Pig;
};

House::House(string material, Pig *pig) : m_Material(material), m_Pig(pig) {
    cout << "House constructed: " << m_Material << ", " << m_Pig->getName() << endl;
}

House::~House() {
    cout << "House destructed: " << m_Material << ", " << m_Pig->getName() << endl;
    delete m_Pig;
}

class Wolf {
    public:
        Wolf(string name);
        ~Wolf();
        string getName() { return m_Name; }
        bool blowHouseDown(House *house);

    protected:
        string m_Name;
};

Wolf::Wolf(string name) : m_Name(name) {
    cout << "Wolf constructed: " << m_Name << endl;
}

Wolf::~Wolf() {
    cout << "Wolf destructed: " << m_Name << endl;
}

bool Wolf::blowHouseDown(House *house) {
    if (house->getMaterial().compare("Brick") == 0) {
        cout << "House made of " << house->getMaterial() << " could not be blown down.\n"
             << house->getPig()->getName() << " survived!" << endl;

        return false;
    }

    cout << "House made of " << house->getMaterial() << " was blown down.\n"
         << house->getPig()->getName() << " was killed!" << endl;

    return true;
}

int main() {
    Pig *firstLittlePig = new Pig("First Little Pig");
    Pig *secondLittlePig = new Pig("Second Little Pig");
    Pig *thirdLittlePig = new Pig("Third Little Pig");

    House *houses[3];
    houses[0] = new House("Straw", firstLittlePig);
    houses[1] = new House("Stick", secondLittlePig);
    houses[2] = new House("Brick", thirdLittlePig);

    Wolf wolf("Big Bad Wolf");

    for (int i = 0; i < 3; ++i) {
        if (wolf.blowHouseDown(houses[i])) {
            delete houses[i];
            houses[i] = NULL;
        };
    }

    cout << "The end.\n\nCleaning up memory..." << endl;
    for (int i = 0; i < 3; ++i) {
        delete houses[i];
    }

    return 0;
}
