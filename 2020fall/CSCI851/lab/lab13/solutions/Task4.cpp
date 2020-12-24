#include <iostream>
#include <vector>
using namespace std;

int main() {
    vector<string> phrases;

    cout << "Enter a phrase: ";

    string phrase;
    string reversed;

    while (getline(cin, phrase)) {
        if (phrase.compare("exit") == 0) {
            break;
        }

        reversed.clear();
        for (int i = phrase.size() - 1; i >= 0; --i) {
            reversed += phrase[i];
        }

        if (phrase.compare(reversed) == 0) {
            phrases.push_back(phrase);
            cout << "Palindrome!" << endl;
        } else {
            cout << "Not palindrome." << endl;
        }

        cout << "Enter another phrase or type exit: ";
    }

    cout << "\nPalindrome phrases:" << endl;
    for (auto it = phrases.begin(); it != phrases.end(); ++it) {
        cout << *it << endl;
    }

    return 0;
}
