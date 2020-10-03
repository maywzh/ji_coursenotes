#include<iostream>
using namespace std;

enum woodtypes { mahogony, oak, pine, others };

int copyNChairs(istream& in) {
    int n;
    in >> n;
    return n;
}
float copySurfaceArea(istream& in) {
    float f;
    in >> f;
    return f;
}
string copyColor(istream& in) {
    string color;
    in >> color;
    return color;
}
woodtypes copyType(istream& in) {
    char ch;
    in >> ch;
    switch (ch)
    {
    case 'm':
        return mahogony;
        break;
    case 'o':
        return oak;
        break;
    case 'p':
        return pine;
        break;
    default:
        cout << "Invalid Type" << endl;
        return others;
        break;
    }
}

float price(float s, int n, woodtypes typ) {
    int x = 0;
    switch (typ)
    {
    case mahogony:
        x = 200;
        break;
    case oak:
        x = 150;
        break;
    case pine:
        x = 95;
        break;
    default:
        break;
    }
    return x * (s + n / 2);
}
int displayDetails() {

}
int displayPrice(int n) {
    return n;
}

int main() {

}