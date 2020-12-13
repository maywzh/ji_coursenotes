/*
 * @Author       : maywzh
 * @Date         : 2020-12-13 19:47:46
 * @LastEditTime : 2020-12-13 20:01:11
 * @LastEditors  : maywzh
 * @Description  : 
 * @FilePath     : /ji_coursenotes/2020fall/CSCI851/assignment/assignment3/code/Container.cpp
 * @
 * Copyright (c) 2017 maywzh.
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#include "translation.h"
//using namespace std;

template <typename T>
Container<T>::Container(std::vector<T> d, int s)
{
    data.assign(d.begin(), d.end());
    datasize = s;
}

template <typename T>
void Container<T>::showDistribution()
{
    int count[256] = {};
    for (int x = 0; x < datasize; ++x)
    {
        for (int i = 0; i < data[x].size() / sizeof(data[0].symbol); i++)
        {
        }
    }
}

template <typename T>
void Container<T>::showData()
{
    std::cout << "show the container :" << std::endl;
    for (int x = 0; x < datasize; ++x)
    {
        //std::cout<<data[x].symbol;
        std::cout << data[x];
    }
    std::cout << std::endl
              << std::endl;
}

template <typename T>
void Container<T>::Save_Trans(std::string file)
{
    std::cout << "write to " << file << std::endl;
    std::ofstream outdata;
    outdata.open(file);

    for (int x = 0; x < datasize; ++x)
    {
        //outdata <<data[x].symbol;
        outdata << data[x];
    }
    outdata << std::endl;
}

template <typename T>
void Container<T>::showSize()
{
    int size = 0;
    for (int x = 0; x < datasize; ++x)
    {
        size = size + data[x].symbol.length();
    }
    std::cout << size << std::endl;
}
