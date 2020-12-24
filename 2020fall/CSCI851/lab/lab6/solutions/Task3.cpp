#include <iostream>
#include <string>
using namespace std;

class Basic {
    public:
        Basic(string name);
        void print();
    private:
        string name;
};

Basic::Basic(string name) : name(name) {
    cout << "Constructing" << endl;
}

void Basic::print() {
    cout << name << endl;
}

int main() {
    Basic b("Ben");
    b.print();

    return 0;
}
