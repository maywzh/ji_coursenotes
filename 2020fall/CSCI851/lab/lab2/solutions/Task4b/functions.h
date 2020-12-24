#ifndef FUNCTIONS_H
#define FUNCTIONS_H

#include <string>
using namespace std;

char getWoodCode();
int getNumChairs();
double getSurfaceArea();
string getCushionColour();
double getPrice(double area, int chairs, char woodCode);
void printDetails(char woodCode, double side, int chairs, string colour);
void printPrice(double price);

#endif // FUNCTIONS_H
