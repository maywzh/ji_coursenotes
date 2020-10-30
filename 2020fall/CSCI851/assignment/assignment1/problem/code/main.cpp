/*
 * @Author: maywzh
 * @Date: 2020-10-30 15:13:24
 * @FilePath: /ji_coursenotes/2020fall/CSCI851/assignment/assignment1/code/main.cpp
 */
#include <iostream>
#include "vet.h"

int main(int argc, char* argv[]) {

    readfile(argv[2], readAnimal);
    readfile(argv[3], readVeterinarian);
    readfile(argv[4], readProblems);
    readfile(argv[5], readTreatments);
    cout << "====Animal====" << endl;
    printAnimal();
    cout << "\n====Veterinarians====" << endl;
    printVeterinarian();
    cout << "\n====Problems====" << endl;
    printProblems();
    cout << "\n====Treatments====" << endl;
    printTreatments();

    return 0;
}