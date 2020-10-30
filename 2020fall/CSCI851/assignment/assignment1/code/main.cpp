#include <iostream>
#include "vet.h"

int main(int argc, char* argv[]) {

    readfile(argv[2], readAnimal);
    readfile(argv[3], readVet);
    readfile(argv[4], readProblems);
    readfile(argv[5], readTreatments);
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