#include <iostream>
using namespace std;

class Mod11 {
    private:
        int m_Value;
    public:
        Mod11(int n);
        void print() { cout << m_Value << endl; }

        Mod11 operator+(const Mod11& obj); // Addition
        Mod11 operator-(const Mod11& obj); // Subtraction
        Mod11 operator*(const Mod11& obj); // Multiplication
};

Mod11::Mod11(int n) {
    m_Value = n % 11;
}

Mod11 Mod11::operator+(const Mod11& obj) {
    return Mod11(m_Value + obj.m_Value);
}

Mod11 Mod11::operator-(const Mod11& obj) {
    return Mod11(m_Value - obj.m_Value);
}

Mod11 Mod11::operator*(const Mod11& obj) {
    return Mod11(m_Value * obj.m_Value);
}

int main() {
    Mod11 a(19);
    Mod11 b(19);
    Mod11 c(100);
    Mod11 d(56);
    Mod11 e = a + c;
    Mod11 f = a - c;
    Mod11 g = a * c;

    a.print();
    b.print();
    c.print();
    d.print();
    e.print();
    f.print();
    g.print();

    return 0;
}
