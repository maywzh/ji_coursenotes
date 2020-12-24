#include <iostream>
#include <string>
using namespace std;

template <typename T>
void display(T t, char c, int n) {
    for (int i = 0; i < n; i++) {
        cout << c;
    }
    cout << " " << t << " ";
    for (int i = 0; i < n; i++) {
        cout << c;
    }
    cout << endl;
}

// Abstract data type (ADT)
class Foo {
        friend ostream& operator<<(ostream &out, const Foo &foo);
    public:
        Foo(string bar);
    private:
        string m_Bar;
};

Foo::Foo(string bar) : m_Bar(bar) {
}

ostream& operator<<(ostream &out, const Foo &foo) {
    out << foo.m_Bar;
    return out;
}

int main() {
    display('x', 'y', 4);
    display(47, '*', 3);
    display(39.25, '0', 3);
    display("Bob", 'a', 4);
    display(Foo("This is an object."), '_', 4);

    return 0;
}
