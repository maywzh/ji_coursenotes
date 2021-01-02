/*
 * @Author       : maywzh
 * @Date         : 2020-12-25 01:39:16
 * @LastEditTime : 2020-12-26 13:16:24
 * @LastEditors  : maywzh
 * @Description  : 
 * @FilePath     : /ji_coursenotes/2020fall/CSCI851/lab/lab2/solutions/Task2.cpp
 * @
 * Copyright (c) 2017 maywzh.
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
#include <iostream>
using namespace std;

int main()
{
    // 1
    {
        cout << "Hello" << endl;
    }

    // 2
    {
        int value = 5;
        // cout >> value >> endl;
        cout << value << endl;
    }

    // 3
    {
        int value;
        cout << "Enter an integer : ";
        // cin << value;
        cin >> value;
        // When the >> function of cin is called, the program waits for the user to press the key until the user presses the Enter key, then the line of data, including the newline character, is put into the buffer and forms the input stream from which the extractor >> can extract the data.

        // When you have entered more than 2 characters on the keyboard, the other characters will also be kept in the buffer and wait for cin>> to read later in the program. If there is cin>>c or something like that later in the program, the program will not appear on the console waiting for user input, but will directly read the remaining data in the buffer until the characters in the buffer are read, and then wait for the user to press a key.
    }

    // 4
    {
        int value = 2;
        cout << value << 2 << endl;   // 22
        cout << (value << 2) << endl; // 8 (bitwise shift left)
        // cout << value >> 2 >> endl;   // invalid operands to binary expression
        cout << value << 2 << endl;
        // cout << (value >> 2) >> endl; // invalid operands to binary expression
        cout << (value >> 2) << endl; // 0 (bitwise shift right)
    }

    return 0;
}
