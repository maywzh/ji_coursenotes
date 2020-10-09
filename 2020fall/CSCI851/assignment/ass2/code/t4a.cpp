#include<iostream>
using namespace std;

int InputNChairs(istream& in) {
    int n;
    in >> n;
    return n;
}
float InputSurfaceArea(istream& in) {
    float f;
    in >> f;
    return f;
}
string InputColor(istream& in) {
    string color;
    in >> color;
    return color;
}
char InputWoodType(istream& in) {
    char ch;
    in >> ch;
    switch (ch)
    {
    case 'm':case 'o':case 'p':
        return ch;
        break;
    default:
        cout << "Invalid Type" << endl;
        return '-';
        break;
    }
}
string OutputWoodType(char wt) {
    switch (wt)
    {
    case 'm':
        return "mahogony";
        break;
    case 'o':
        return "oak";
        break;
    case 'p':
        return "pine";
        break;
    default:
        return "others";
        break;
    }
}

float price(int n, float s, char wt) {
    int x = 0;

    switch (wt)
    {
    case 'm':
        x = 200;
        break;
    case 'o':
        x = 150;
        break;
    case 'p':
        x = 95;
        break;
    default:
        break;
    }
    return x * (s + n / 2);
}
void displayDetails(int n, float f, string color, char wt) {
    cout << "Number of Chairs: " << n << endl;
    cout << "Surface area of the table: " << f << endl;
    cout << "Colour of the cushions: " << color << endl;
    cout << "Type of wood: " << OutputWoodType(wt) << endl;
}

void displayPrice(int n, float f, char wt) {
    cout << "Total Price: " << price(n, f, wt);
}

int main() {
    int n = InputNChairs(cin);
    float f = InputSurfaceArea(cin);
    string color = InputColor(cin);
    char wt = InputWoodType(cin);
    displayDetails(n, f, color, wt);
    displayPrice(n, f, wt);
}