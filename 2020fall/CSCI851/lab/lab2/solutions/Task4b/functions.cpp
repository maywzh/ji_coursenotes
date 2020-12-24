#include "functions.h"

#include <iostream>
#include <string>
using namespace std;

// A function which accepts from standard in the number of chairs to go with the table.
int getNumChairs() {
    int numChairs;
    cout << "Enter the number of chairs for the table: ";
    cin >> numChairs;
    return numChairs;
}

// A function which accepts from standard in the surface area (in m2) of the table.
double getSurfaceArea() {
    double surfaceArea;
    cout << "Enter the surface area of the table: ";
    cin >> surfaceArea;
    return surfaceArea;
}

// A function which accepts from standard in any colour for the cushions on the chair seats. Any input should be accepted as a colour and recorded. Use a string.
string getCushionColour() {
    string cushionColour;
    cout << "Enter the colour of the cushions: ";
    cin >> cushionColour;
    return cushionColour;
}

// A function which accepts from standard in the type of wood used to build the table and chairs; m for mahogany, o for oak or p for pine.
char getWoodCode() {
    char woodCode;
    cout << "Enter the type of wood -" << endl;
    cout << "m for mahogany, o for oak, or p for pine: ";
    cin >> woodCode;

    switch(woodCode) {
    case 'm':
    case 'o':
    case 'p':
        return woodCode;
    default:
        return getWoodCode();
    }
}

//  A function that takes the number of chairs, the surface area of the table and the type of wood and calculates the price.
double getPrice(double area, int chairs, char woodCode) {
    double woodPrice;

    switch(woodCode) {
    case 'm':
        woodPrice = 200;
        break;
    case 'o':
        woodPrice = 150;
        break;
    default:
        // p
        woodPrice = 95;
    }

    return woodPrice * (area + 0.5 * chairs);
}

// A function to display the details of the purchase, including the dimensions of the table.
void printDetails(char woodCode, double side, int chairs, string colour) {
    string woodName;

    switch(woodCode) {
    case 'm':
        woodName = "mahogany";
        break;
    case 'o':
        woodName = "oak";
        break;
    default:
        // p
        woodName = "pine";
    }

    cout << "You have chosen a " << woodName << " table with:" << endl;
    cout << "dimensions " << side << " by " << side << " and " << chairs << " chairs with " << colour << " cushions!" << endl;
}

// A function to display the price of the purchase.
void printPrice(double price) {
    cout << "Price is $" << price << endl;
}
