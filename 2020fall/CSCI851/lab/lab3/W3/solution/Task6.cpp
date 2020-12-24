#include <iostream>
#include <string>
using namespace std;

bool isVowel(char c);

int main() {
    string text;
    cout << "Enter a string followed by a full stop: ";
    getline(cin, text, '.');

    // use auto instead of char to automatically handle the type
    for (auto c : text) {
        cout << (isVowel(c) ? '*' : c);
    }

    cout << endl;
    return 0;
}

bool isVowel(char c) {
    return (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u');
}
