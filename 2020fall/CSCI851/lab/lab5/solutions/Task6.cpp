#include "One.h"
#include "Two.h"
#include <iostream>
using namespace std;

// Discontiguous means the namespace can be defined over multiple files

int main() {
    foo::apple();
    foo::orange();
}
