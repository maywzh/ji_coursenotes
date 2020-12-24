#include <iostream>
#include <string>
#include <vector>
#include <deque>
#include <list>
#include <chrono>
using namespace std;

class Thing {
    private:
        string m_Name;
        int m_Age;
    public:
        Thing(string name, int age);
        void display() const;
};

Thing::Thing(string name, int age) : m_Name(name), m_Age(age) {
}

void Thing::display() const {
    cout << "Thing: " << m_Name << " is " << m_Age << " years old." << endl;
}

int main(int argc, char* argv[]) {
    unsigned int number = atoi(argv[1]);
    Thing myThing("The big blue dog", 5);

    {
        // VECTOR PUSH FRONT

        vector<Thing> thingVector1;
        auto start = chrono::system_clock::now();

        for (unsigned int i = 0; i < number; i++) {
            thingVector1.insert(thingVector1.begin(), myThing);
        }

        auto end = chrono::system_clock::now();
        chrono::duration<double> elapsed_seconds = end - start;
        cout << "Vector 'push_front': " << elapsed_seconds.count() << "s" << endl;

//        for (auto it = thingVector1.begin(); it != thingVector1.end(); ++it) {
//            it->display();
//        }
    }

    {
        // VECTOR PUSH BACK

        vector<Thing> thingVector2;
        auto start = chrono::system_clock::now();

        for (unsigned int i = 0; i < number; i++) {
            thingVector2.push_back(myThing);
        }

        auto end = chrono::system_clock::now();
        chrono::duration<double> elapsed_seconds = end - start;
        cout << "Vector 'push_back': " << elapsed_seconds.count() << "s" << endl;
    }

    {
        // DEQUE PUSH FRONT

        deque<Thing> thingDeque1;
        auto start = chrono::system_clock::now();

        for (unsigned int i = 0; i < number; i++) {
            thingDeque1.push_front(myThing);
        }

        auto end = chrono::system_clock::now();
        chrono::duration<double> elapsed_seconds = end - start;
        cout << "Deque 'push_front': " << elapsed_seconds.count() << "s" << endl;

//        for (auto it = thingDeque1.begin(); it != thingDeque1.end(); ++it) {
//            it->display();
//        }
    }

    {
        // DEQUE PUSH BACK

        deque<Thing> thingDeque2;
        auto start = chrono::system_clock::now();

        for (unsigned int i = 0; i < number; i++) {
            thingDeque2.push_back(myThing);
        }

        auto end = chrono::system_clock::now();
        chrono::duration<double> elapsed_seconds = end - start;
        cout << "Deque 'push_back': " << elapsed_seconds.count() << "s" << endl;
    }

    {
        // LIST PUSH FRONT

        list<Thing> thingList1;
        auto start = chrono::system_clock::now();

        for (unsigned int i = 0; i < number; i++) {
            thingList1.push_front(myThing);
        }

        auto end = chrono::system_clock::now();
        chrono::duration<double> elapsed_seconds = end - start;
        cout << "List 'push_front': " << elapsed_seconds.count() << "s" << endl;

//        for (auto it = thingList1.begin(); it != thingList1.end(); ++it) {
//            it->display();
//        }
    }

    {
        // LIST PUSH BACK

        list<Thing> thingList2;
        auto start = chrono::system_clock::now();

        for (unsigned int i = 0; i < number; i++) {
            thingList2.push_back(myThing);
        }

        auto end = chrono::system_clock::now();
        chrono::duration<double> elapsed_seconds = end - start;
        cout << "List 'push_back': " << elapsed_seconds.count() << "s" << endl;
    }
}

/*

$ ./Thing 1000
Vector 'push_front': 0.083965s
Vector 'push_back': 0.000652s
Deque 'push_front': 0.00028s
Deque 'push_back': 0.000265s
List 'push_front': 0.000746s
List 'push_back': 0.000686s

$ ./Thing 10000
Vector 'push_front': 8.23066s
Vector 'push_back': 0.00874s
Deque 'push_front': 0.002627s
Deque 'push_back': 0.002598s
List 'push_front': 0.007275s
List 'push_back': 0.006857s

The alternative method of push_front for vector is very slow.
Below, I am excluding push_front for Vector because it is too slow.

$ ./Thing 100000
Vector 'push_back': 0.073903s
Deque 'push_front': 0.026372s
Deque 'push_back': 0.02625s
List 'push_front': 0.07547s
List 'push_back': 0.071043s

$ ./Thing 1000000
Vector 'push_back': 0.793002s
Deque 'push_front': 0.275374s
Deque 'push_back': 0.268761s
List 'push_front': 0.801907s
List 'push_back': 0.761289s

$ ./Thing 10000000
Vector 'push_back': 9.27385s
Deque 'push_front': 2.79061s
Deque 'push_back': 2.80497s
List 'push_front': 7.94634s
List 'push_back': 7.64661s

Deque appears to be the fastest, followed by List. Vector is the slowest.

*/
