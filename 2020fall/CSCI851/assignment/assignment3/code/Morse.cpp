/*
 * @Author       : maywzh
 * @Date         : 2020-12-13 19:38:11
 * @LastEditTime : 2020-12-13 20:28:59
 * @LastEditors  : maywzh
 * @Description  : 
 * @FilePath     : /ji_coursenotes/2020fall/CSCI851/assignment/assignment3/code/Morse.cpp
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
using namespace std;

void Morse::setSymbol(string data)
{
    symbol = data;
}

string Morse::getSymbol()
{
    return symbol;
}
bool Morse::checkSymbol(string data)
{
    for (int x = 0; x < data.length(); x++)
    {
        if ((data[x] != '.') && (data[x] != '-') && (data[x] != '\n'))
        {
            return 0;
        }
    }
    return 1;
}

char Morse::translation_to_Latin()
{
    for (std::map<char, std::string>::iterator iter = morseRule.begin(); iter != morseRule.end(); iter++)
    {
        if (symbol == iter->second)
        {
            if (iter->first == '_')
                return ' ';
            else
                return iter->first;
        }
    }

    return '0';
}

ostream &operator<<(ostream &out, const Morse &morse)
{
    out << morse.symbol;
    return out;
}