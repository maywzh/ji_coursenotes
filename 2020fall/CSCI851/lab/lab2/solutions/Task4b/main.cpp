#include <iostream>
#include <string>
#include <cmath>
#include "functions.h"
using namespace std;

int main() {
    char woodCode = getWoodCode();
    int numChairs = getNumChairs();
    double surfaceArea = getSurfaceArea();
    string cushionColour = getCushionColour();
    printDetails(woodCode, sqrt(surfaceArea), numChairs, cushionColour);
    double price = getPrice(surfaceArea, numChairs, woodCode);
    printPrice(price);

    return 0;
}
