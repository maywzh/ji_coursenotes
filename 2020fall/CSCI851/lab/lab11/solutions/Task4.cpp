#include <iostream>
using namespace std;

template<typename R, typename S>
class Two {
    private:
        R r;
        S s;
    public:
        Two(R first, S second);
        void print();
        int total();
};

template<typename R, typename S>
Two<R, S>::Two(R first, S second) : r(first), s(second) {
}

template<typename R, typename S>
void Two<R, S>::print() {
    cout << r << "\n"
         << s << endl;
}

template<typename R, typename S>
int Two<R, S>::total() {
    return r + s;
}

class Apple;
class Orange;

// ADT 1
class Apple {
        friend ostream& operator<<(ostream &out, const Apple &apple);
    public:
        Apple(int weight);
        friend int operator+(const Apple &apple, const Orange &orange);
        friend int operator+(const Orange &orange, const Apple &apple);

    private:
        int m_Weight;
};

Apple::Apple(int weight) : m_Weight(weight) {
}

ostream& operator<<(ostream &out, const Apple &apple) {
    out << "Apple weighs " << apple.m_Weight << " grams.";
    return out;
}

// ADT 2
class Orange {
        friend ostream& operator<<(ostream &out, const Orange &orange);
    public:
        Orange(int weight);
        friend int operator+(const Apple &apple, const Orange &orange);
        friend int operator+(const Orange &orange, const Apple &apple);

    private:
        int m_Weight;
};

Orange::Orange(int weight) : m_Weight(weight) {
}

ostream& operator << (ostream &out, const Orange &orange) {
    out << "Orange weighs " << orange.m_Weight << " grams.";
    return out;
}

// ADT 3
struct Foo {
    int bar;
};

// Operator overloading
int operator+(const Apple &apple, const Orange &orange) {
	return apple.m_Weight + orange.m_Weight;
}

int operator+(const Orange &orange, const Apple &apple) {
	return apple.m_Weight + orange.m_Weight;
}

int main() {
    Apple apple(150);
    Orange orange(170);

    Two<Apple, Orange> two1(apple, orange);
    two1.print();
    cout << "Total: " << two1.total() << endl;

    // This can still be instantiated, but it will crash if we try to use two1.print() or two1.total().
    Two<Apple, Foo> two2(apple, Foo());

    return 0;
}
