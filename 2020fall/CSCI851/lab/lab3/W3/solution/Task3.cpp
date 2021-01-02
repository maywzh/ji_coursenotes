/*
 * @Author       : maywzh
 * @Date         : 2020-12-25 01:28:46
 * @LastEditTime : 2020-12-25 14:52:42
 * @LastEditors  : maywzh
 * @Description  : 
 * @FilePath     : /ji_coursenotes/2020fall/CSCI851/lab/lab3/W3/solution/Task3.cpp
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
    // Using subscripting, i.e. array: [ ]

    // 1.
    int nums[3];

    std::cout << "Enter three integer: ";
    for (int i = 0; i < 3; i++)
    {
        std::cin >> nums[i];
    }

    for (unsigned int i = 0; i < 3; ++i)
    {
        std::cout << "nums[" << i << "] = " << nums[i] << std::endl;
    }

    // Using pointers

    int input;
    std::cout << "Enter three integer: ";
    for (unsigned int i = 0; i < 3; ++i)
    {
        std::cin >> input;
        *(nums + i) = input; // same as nums[i]
    }

    for (unsigned int i = 0; i < 3; ++i)
    {
        std::cout << "*(nums + " << i << ") = " << *(nums + i) << std::endl;
    }

    std::cout << "An array name is just a pointer to the first element in the array." << std::endl;
    std::cout << "Memory address of array, i.e. nums: " << nums << std::endl;
    std::cout << "Memory address of first element in array, i.e. &nums[0]: " << &nums[0] << std::endl;
    std::cout << "Dereference the pointer to access first element, i.e. *nums: " << *nums << std::endl;
    std::cout << "Dereference the pointer + 1 to access second element, i.e. *(nums + 1): " << *(nums + 1) << std::endl;
    return 0;
}
