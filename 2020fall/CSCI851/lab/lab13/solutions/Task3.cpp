// Usage: Task3 < Input.txt
#include <iostream>
using namespace std;

void reverseAlphabet(istream& in, ostream& out) {
    char c;
    while (in.get(c)) {
        unsigned int charInt = static_cast<int>(c);
        if (charInt >= 97 && charInt <= 122) {
            c = (char)(charInt * -1 + 219);
        }
        out.put(c);
    }
}

int main() {
    reverseAlphabet(cin, cout);

    return 0;
}
