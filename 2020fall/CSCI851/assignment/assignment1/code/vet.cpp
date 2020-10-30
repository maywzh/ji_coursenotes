//
// Created by Anthony on 28/03/2019.
//
#include "vet.h"

static uniform_int_distribution<unsigned> uniform(0, 100);
static default_random_engine randEng;

const string DELIMITER = ":";
vector<Animal> animalList;
vector<Vet> vetList;
vector<string> treatmentList;
vector<Problem> problemList;


void writefile() {
    ofstream myfile{ "example.txt" };
    if (myfile.is_open()) {
        cout << "writing" << endl;
        myfile << "This is a line.\n";
        myfile << "This is another line.\n";
        myfile.close();
    }
    else {
        cout << "Unable to open file";
    }

    cout << "successful write" << endl;

}


void readfile(char* filename, void (*functocall)(string)) {
    //    cout<<filename<<endl;
    ifstream in;
    string line;

    in.open(filename);
    if (in.bad()) {
        clog << "read BAD" << endl;
    }
    else if (in.good()) {

    }
    else if (in.fail()) {
        cerr << "read Fail" << endl;
    }
    else if (in.eof()) {
        clog << "read EOF" << endl;
    }
    getline(in, line);
    //    in >> line;
    do {
        (*functocall)(line);
        getline(in, line);
    } while (!in.eof());
}



string attendAnimal(int id) {
    Vet* vet = getVet();
    Problem* problem = getProblem(animalList.at(id).Problem);
    bool detected = detectProblem(vet->quality, problem->determinationComplexity);

    if (!detected) {
        static uniform_int_distribution<unsigned> retryRange(0, problemList.size() - 1);
        if (retryRange(randEng) == 0) {
            //which number is selected doesn't matter, so long has range is correct
            detected = true;
        }
    }

    bool success = applyTreatment(detected, problem->treatementComplexity, vet->quality);
}

/** returning a pointer to object in vector to save on memory
 * @return
 */
Vet* getVet() {
    static uniform_int_distribution<unsigned> vetRange(0, vetList.size() - 1);
    return  &(vetList.at(vetRange(randEng)));
}

Problem* getProblem(int n) {
    return &(problemList.at(n));
}

/**
 * divide complexity by 4
 * minus vet Quality by new complexity;
 * get random num between 0-100
 * problem is detected if random is between 0 - vet quality
 * vet quality cannot be < 1
 * @param vetQual
 * @param complexity
 * @return bool
 */
bool detectProblem(int vetQual, int complexity) {
    complexity = complexity / 4;
    vetQual -= complexity;
    if (uniform(randEng) <= vetQual) {
        cout << "problem detected" << endl;
        return true;
    }
    else {
        return false;
    }
}
/**
 * % chance of success = (100 - treatment complexity) * (1 + vet quality)
 * incase of incorrect diagnosis
 * divide chance of success by 4
 * @param detected
 * @param complexity
 * @return bool
 */
bool applyTreatment(bool detected, int complexity, int vetQual) {
    double success = ((100 - complexity) * (1 + (vetQual / 100.00))) / 100.00;
    if (!detected) {
        success = success * 0.25;
    }
    if (uniform(randEng) <= success) {
        cout << "Treatment applied correctly" << endl;
        return true;
    }
    else {
        return false;
    }
}


void writeToOutput(string output, string file) {

}


void readAnimal(string s) {
    Animal tempAnimal;

    string token = s.substr(0, s.find(DELIMITER));
    tempAnimal.name = token;
    s.erase(0, s.find(DELIMITER) + DELIMITER.length());

    token = s.substr(0, s.find(DELIMITER));
    tempAnimal.type = token;
    s.erase(0, s.find(DELIMITER) + DELIMITER.length());


    token = s.substr(0, s.find(DELIMITER));
    tempAnimal.rego = token;
    s.erase(0, s.find(DELIMITER) + DELIMITER.length());

    token = s.substr(0, s.size() - 1);
    tempAnimal.Problem = stoi(token);

    animalList.push_back(tempAnimal);
}


void readVet(string s) {
    Vet tempVet;

    string token = s.substr(0, s.find(DELIMITER));
    tempVet.name = token;
    s.erase(0, s.find(DELIMITER) + DELIMITER.length());

    token = s.substr(0, s.size() - 1);
    tempVet.quality = stoi(token);

    vetList.push_back(tempVet);
}

void readTreatments(string s) {
    treatmentList.push_back(s);
}

void readProblems(string s) {
    Problem tempProblem;
    string token = s.substr(0, s.find(DELIMITER));
    tempProblem.name = token;
    s.erase(0, s.find(DELIMITER) + DELIMITER.length());

    token = s.substr(0, s.find(DELIMITER));
    tempProblem.determinationComplexity = stoi(token);
    s.erase(0, s.find(DELIMITER) + DELIMITER.length());

    token = s.substr(0, s.find(DELIMITER));
    tempProblem.treatementComplexity = stoi(token);
    s.erase(0, s.find(DELIMITER) + DELIMITER.length());

    token = s.substr(0, s.size() - 1);
    tempProblem.treatment = stoi(token);

    problemList.push_back(tempProblem);
}
//endregion


//region Vector Prints

void printAnimal() {
    for (unsigned int x = 0; x < animalList.size(); x++) {
        cout << animalList.at(x).name << " type: " << animalList.at(x).type << " rego: " << animalList.at(x).rego
            << " Problem: " << animalList.at(x).Problem << endl;
    }
}

void printVet() {
    for (unsigned int x = 0; x < vetList.size(); x++) {
        cout << vetList.at(x).name << " Qual: " << vetList.at(x).quality << endl;
    }
}

void printTreatments() {
    for (unsigned int x = 0; x < treatmentList.size(); x++) {
        cout << treatmentList.at(x) << endl;
    }
}

void printProblems() {
    for (unsigned int x = 0; x < problemList.size(); x++) {
        cout << problemList.at(x).name << " Deter: " << problemList.at(x).determinationComplexity << " TreatComp: "
            << problemList.at(x).treatementComplexity << " Treat: " << problemList.at(x).treatment << endl;
    }
}
//endregion
