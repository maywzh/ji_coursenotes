#include <iostream>
using namespace std;

class Transportation {
    public:
        Transportation() { cout << "Constructor called: Transportation()" << endl; }
};

// Inheritance
class SeaTransport : public Transportation {
    public:
        SeaTransport() { cout << "Constructor called: SeaTransport()" << endl; }
};

class LandTransport : public Transportation {
    public:
        LandTransport() { cout << "Constructor called: LandTransport()" << endl; }
};

class AirTransport : public Transportation {
    public:
        AirTransport() { cout << "Constructor called: AirTransport()" << endl; }
};

// Multiple layers of inheritance
class Car : public LandTransport {
    public:
        Car() { cout << "Constructor called: Car()" << endl; }
};

class Canoe : public SeaTransport {
    public:
        Canoe() { cout << "Constructor called: Canoe()" << endl; }
};

// Multiple inheritance
class HoverCraft : public SeaTransport, public LandTransport {
    public:
        HoverCraft() { cout << "Constructor called: HoverCraft()" << endl; }
};

int main() {
    cout << "\nInheritance: Creating a SeaTransport object..." << endl;
    SeaTransport s;
    cout << "\nMultiple layers of inheritance: Creating a Car object..." << endl;
    Car c;
    cout << "\nMultiple inheritance: Creating a HoverCraft object..." << endl;
    HoverCraft h;
    return 0;
}
