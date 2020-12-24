#include <iostream>
#include <thread>
#include <chrono>
using namespace std;

int main() {
    string alpha = "\"This is a wierd\a\a\a\b\b\b\beird message!\"\n\n\a\a\a";

    for (auto c : alpha) {
        this_thread::sleep_for(chrono::milliseconds(250)); // Sleep between printing each char to standard out.
        cerr << c;
    }
}

// cout is buffered, but cerr is not, which explains why cerr directly displays each char one by one, while cout displays everything in one go.
