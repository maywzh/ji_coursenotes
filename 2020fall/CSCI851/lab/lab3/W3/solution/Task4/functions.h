#ifndef FUNCTIONS_H
#define FUNCTIONS_H

#include <string>
using namespace std;

void getWoodCode(char &woodCode);
void getNumChairs(int &numChairs);
void getSurfaceArea(double &surfaceArea);
void getCushionColour(string &cushionColour);
void getPrice(double &price, double area, int chairs, char woodCode);
void printDetails(char woodCode, double side, int chairs, string colour);
void printPrice(double price);

#endif // FUNCTIONS_H
