#include <iostream>
#include <string>
#include <cmath>
#include "functions.h"
using namespace std;

int main() {
    char woodCode;
    int numChairs;
    double surfaceArea, price;
    string cushionColour;

    getWoodCode(woodCode);
    getNumChairs(numChairs);
    getSurfaceArea(surfaceArea);
    getCushionColour(cushionColour);
    printDetails(woodCode, sqrt(surfaceArea), numChairs, cushionColour);
    getPrice(price, surfaceArea, numChairs, woodCode);
    printPrice(price);

    return 0;
}
