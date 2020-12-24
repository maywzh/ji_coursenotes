#include <iostream>
#include <vector>
using namespace std;

int main() {
    size_t size;

    cout << "Enter the size of the container: ";
    cin >> size;

    vector<int> foo(size);

    for (unsigned int i = 0; i < size; ++i) {
        foo[i] = i;
    }

    cout << "My vector contains:" << endl;

    for (auto it = foo.begin(); it != foo.end(); ++it) {
        cout << *it << endl;
    }

    return 0;
}
