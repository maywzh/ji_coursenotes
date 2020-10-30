#include <iostream>
#include "vetFunctions.h"

int main(int argc, char* argv[]) {

    read(argv[2], readAnimal);
    read(argv[3], readVet);
    read(argv[4], readProblems);
    read(argv[5], readTreatments);
    cout << "Animal" << endl;
    printAnimal();
    cout << "\nVets" << endl;
    printVet();
    cout << "\nProblems" << endl;
    printProblems();
    cout << "\nTreatments" << endl;
    printTreatments();

    return 0;
}