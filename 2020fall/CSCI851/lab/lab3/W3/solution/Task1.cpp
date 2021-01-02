/*
 * @Author       : maywzh
 * @Date         : 2020-12-25 01:28:46
 * @LastEditTime : 2020-12-25 14:26:05
 * @LastEditors  : maywzh
 * @Description  : Lab3 Task1
 * @FilePath     : /ji_coursenotes/2020fall/CSCI851/lab/lab3/W3/solution/Task1.cpp
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
    // (a) Qualifier: const.
    const int value = 128;
    // value = 256;
    // Answer: assignment of read-only variable

    // (b) References:
    // int &reference;
    // Answer: declaration of reference variable 'reference' requires an initializer

    // (c) Array declaration, this differs between CC and g++.
    int post = 4;
    int postCode[post];
    // Answer: post should be const

    // (d) Void pointer one: How do you point the void pointer somewhere?
    void *vptr;
    // Answer:
    //int foo = 5;
    //vptr = &foo; // & gets the memory address, which we can assign to the pointer
    cout << vptr << endl;

    // (e) Void pointer two: How do you output the content the void pointer points to?
    int i = 2;
    int *p = &i;
    void *vp = p;
    cout << vp << endl;
    // Answer:
    // A void pointer is used to hold the address of any type, but without the type being known.
    // If we are to access the content of the memory a void pointer address, we need to type cast it first: (int*)
    // Then it needs to be dereferenced: *()
    cout << *((int *)vp) << endl;

    return 0;
}
