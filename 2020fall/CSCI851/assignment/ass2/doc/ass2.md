## Lab 2
### Part One
```cpp
#include <iostream>
using namespace std;
int main() {
    string name;
    cout << "Please input your name:" << endl;
    cin >> name;
    cout << "Hello " << name << "!" << endl;
    return 0;
}
```
![](1-1.png)
![](1-2.png)
```cpp
#include <iostream>
using namespace std;
int main() {
    float name;
    cout << "Please input your name:" << endl;
    cin >> name;
    cout << "Hello " << name << "!" << endl;
    return 0;
}
```
![](1-3.png)

### Part Two
```cpp
int main(){
    cout << "Hello" << endl;
}
```
![](2-1.png)
```cpp
#include <iostream>
using namespace std;
int main(){
    int value = 5;
    cout >> value  >> endl;
}
```
![](2-2.png)
```cpp
#include <iostream>
using namespace std;
int main() {
    int value;
    cout << "Enter an integer : ";
    cin << value;
}
```
![](2-3.png)
```cpp
#include<iostream>
using namespace std;
int main() {
    int value = 2;
    cout << value << 2 << endl;
    cout << (value << 2) << endl;
    cout << value >> 2 >> endl;
    cout << (value >> 2) >> endl;
}
```
![](2-4-1.png)
```>>``` is binary expression can not be in ostream.
![](2-4-2.png)
```endl```should be ostream rather than istream.


### Part Three
```cpp
//t3a.cpp
#include <iostream>
using namespace std;
int main() {
    string number;
    cout << "Please input number:" << endl;
    cin >> number;
    for (int i = 0;i < 10;i++) {
        cout << number << endl;
    }
    return 0;
}
```
![](3-1.png)
```cpp
#include <iostream>
using namespace std;
int main() {
    int N;
    cout << "Please input number:" << endl;
    cin >> N;
    for (int i = 0;i < N;i++) {
        for (int j = 1;j <= 12;j++) {
            cout << j << ' ';
        }
        cout << endl;
    }
    return 0;
}
```
![](3-2.png)

```cpp
#include <iostream>
using namespace std;
void printfunc(int N) {
    for (int i = 0;i < N;i++) {
        for (int j = 1;j <= 12;j++) {
            cout << j << ' ';
        }
        cout << endl;
    }
}
int main() {
    int N;
    cout << "Please input number:" << endl;
    cin >> N;
    printfunc(N);
    return 0;
}
```
![](3-3.png)