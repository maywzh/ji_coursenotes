#include "t4b.h"

int InputNChairs(std::istream& in) {
    int n;
    in >> n;
    return n;
}
float InputSurfaceArea(std::istream& in) {
    float f;
    in >> f;
    return f;
}
std::string InputColor(std::istream& in) {
    std::string color;
    in >> color;
    return color;
}
char InputWoodType(std::istream& in) {
    char ch;
    in >> ch;
    switch (ch)
    {
    case 'm':case 'o':case 'p':
        return ch;
        break;
    default:
        std::cout << "Invalid Type" << std::endl;
        return '-';
        break;
    }
}
std::string OutputWoodType(char wt) {
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
void displayDetails(int n, float f, std::string color, char wt) {
    std::cout << "Number of Chairs: " << n << std::endl;
    std::cout << "Surface area of the table: " << f << std::endl;
    std::cout << "Colour of the cushions: " << color << std::endl;
    std::cout << "Type of wood: " << OutputWoodType(wt) << std::endl;
}

void displayPrice(int n, float f, char wt) {
    std::cout << "Total Price: " << price(n, f, wt);
}