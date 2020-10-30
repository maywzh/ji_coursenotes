/*
 * @Author: maywzh
 * @Date: 2020-10-30 15:13:24
 * @FilePath: /ji_coursenotes/2020fall/CSCI851/assignment/assignment1/code/vet.h
 */
 //
 // Created by maywzh on 28/10/2020.
 //

#ifndef CSCI851ASS1_VET_H
#define CSCI851ASS1_VET_H

#include <vector>
#include <iostream>
#include <fstream>
#include <time.h>
#include <random>
using namespace std;

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

extern vector<Animal> animals;
extern vector<Vet> veterinarians;
extern vector<string> treatments;
extern vector<Problem> problems;

//void writeToOutput(string output, string file);
void readfile(char* filename, void (*function)(string));
Vet* getVet();
Problem* getProblem(int n);
bool detectProblem(int vetQual, int complexity);
bool applyTreatment(bool detected, int complexity, int vetQual);


void readAnimal(string s);
void readVeterinarian(string s);
void readProblems(string s);
void readTreatments(string s);

void printAnimal();
void printVeterinarian();
void printTreatments();
void printProblems();
#endif 
