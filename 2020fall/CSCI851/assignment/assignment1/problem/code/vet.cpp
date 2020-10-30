#include "vet.h"

static uniform_int_distribution<unsigned> uniform(0, 100);
static default_random_engine randEng;

//分隔符
const string DELIMITER = ":";

// 读取的数据
vector<Animal> animals;
vector<Vet> veterinarians;
vector<string> treatments;
vector<Problem> problems;


/**
 * @description:
 * @param {*}
 * @return {*}
 */
bool treatAnimal(int id) {
    Vet* vet = getVet();
    Problem* problem = getProblem(animals.at(id).Problem);
    bool detected = detectProblem(vet->quality, problem->determinationComplexity);

    if (!detected) {
        static uniform_int_distribution<unsigned> retryRange(0, problems.size() - 1);
        if (retryRange(randEng) == 0) {
            //which number is selected doesn't matter, so long has range is correct
            detected = true;
        }
    }

    bool success = applyTreatment(detected, problem->treatementComplexity, vet->quality);
    return success;
}

/** 返回Vector中的一个点
 * @return
 */
Vet* getVet() {
    static uniform_int_distribution<unsigned> vetRange(0, veterinarians.size() - 1);
    return  &(veterinarians.at(vetRange(randEng)));
}

/**
 * @description:
 * @param {*}
 * @return {*}
 */
Problem* getProblem(int n) {
    return &(problems.at(n));
}

/**
 * 复杂度除以4
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
 * % 成功率 = (100 - 治疗复杂度) * (1 + 治疗质量)
 * 在错误诊疗的情况
 * 成功率除以4
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

/**
 * @description: 读取文件
 * @param {*}
 * @return {*}
 */
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

// 读取动物文件
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

    animals.push_back(tempAnimal);
}

/**
 * @brief 读取兽医文件
 *
 */
void readVeterinarian(string s) {
    Vet tempVet;

    string token = s.substr(0, s.find(DELIMITER));
    tempVet.name = token;
    s.erase(0, s.find(DELIMITER) + DELIMITER.length());

    token = s.substr(0, s.size() - 1);
    tempVet.quality = stoi(token);

    veterinarians.push_back(tempVet);
}
/**
 * @brief 读取Treatment
 *
 */
void readTreatments(string s) {
    treatments.push_back(s);
}
/**
 * @description: dsfsfa
 * @param s srcf
 * @return {*}
 */
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

    problems.push_back(tempProblem);
}
//endregion


//region Vector Prints
/**
 * @description:
 * @param {*}
 * @return {*}
 */
void printAnimal() {
    for (unsigned int x = 0; x < animals.size(); x++) {
        cout << animals.at(x).name << " \ttype: " << animals.at(x).type << " \trego: " << animals.at(x).rego
            << " \tProblem: " << animals.at(x).Problem << endl;
    }
}
/**
 * @description:
 * @param {*}
 * @return {*}
 */
void printVeterinarian() {
    for (unsigned int x = 0; x < veterinarians.size(); x++) {
        cout << veterinarians.at(x).name << " \tQual: " << veterinarians.at(x).quality << endl;
    }
}
/**
 * @description:
 * @param {*}
 * @return {*}
 */
void printTreatments() {
    for (unsigned int x = 0; x < treatments.size(); x++) {
        cout << treatments.at(x) << endl;
    }
}
/**
 * @description:
 * @param {*}
 * @return {*}
 */
void printProblems() {
    for (unsigned int x = 0; x < problems.size(); x++) {
        cout << problems.at(x).name << "\tDeter: " << problems.at(x).determinationComplexity << "\tTreatComp: "
            << problems.at(x).treatementComplexity << "\tTreat: " << problems.at(x).treatment << endl;
    }
}
//endregion
