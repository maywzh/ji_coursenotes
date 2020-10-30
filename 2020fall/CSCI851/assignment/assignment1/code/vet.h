//
// Created by Anthony on 28/03/2019.
//

#ifndef CSCI251ASSIGN1_VETFUNCTIONS_H
#define CSCI251ASSIGN1_VETFUNCTIONS_H

#include <vector>
#include <iostream>
#include <fstream>
#include <time.h>
#include <random>
using namespace std;



//region Data Structures


struct Animal {
    string name;
    string type;
    string rego;
    int Problem;
};
struct Vet {
    string name;
    int quality;
};
struct Problem {
    string name;
    int determinationComplexity;
    int treatementComplexity;
    int treatment;
};

extern vector<Animal> animalList;
extern vector<Vet> vetList;
extern vector<string> treatmentList;
extern vector<Problem> problemList;
//endregion

void writeToOutput(string output, string file);
void readfile(char* filename, void (*function)(string));
Vet* getVet();
Problem* getProblem(int n);
bool detectProblem(int vetQual, int complexity);
bool applyTreatment(bool detected, int complexity, int vetQual);

//region Read Structs

void readAnimal(string s);
void readVet(string s);
void readProblems(string s);
void readTreatments(string s);
//endregion

void printAnimal();
void printVet();
void printTreatments();
void printProblems();
#endif //CSCI251ASSIGN1_VETFUNCTIONS_H
