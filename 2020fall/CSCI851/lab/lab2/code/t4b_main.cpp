#include "t4b.h"


int main() {
    int n = InputNChairs(std::cin);
    float f = InputSurfaceArea(std::cin);
    std::string color = InputColor(std::cin);
    char wt = InputWoodType(std::cin);
    displayDetails(n, f, color, wt);
    displayPrice(n, f, wt);
}