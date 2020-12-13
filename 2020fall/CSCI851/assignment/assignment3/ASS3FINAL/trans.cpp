/*
 * @Author       : maywzh
 * @Date         : 2020-12-13 21:49:24
 * @LastEditTime : 2020-12-13 21:56:37
 * @LastEditors  : maywzh
 * @Description  : 
 * @FilePath     : /ji_coursenotes/2020fall/CSCI851/assignment/assignment3/ASS3FINAL/translation.cpp
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

void Morse::SetChar(string data)
{
    symbol = data;
}

string Morse::GetChar()
{
    return symbol;
}
bool Morse::CheckChar(string data)
{
    for (int x = 0; x < data.length(); x++)
    {
        if ((data[x] != '.') && (data[x] != '-') && (data[x] != '\n') /*&& (data[x]!= '\t')*/)
            return 0;
    }
    return 1;
}
/*
std::string Latin::Trans2Morse()

*/
void Latin::SetChar(char data)
{
    symbol = data;
}

char Latin::GetChar()
{
    return symbol;
}

bool Latin::CheckChar(char data)
{
    if ((data == ' ') || (data == '\n'))
        return 1;
    else if (data >= 'a' && data <= 'z')
        return 1;
    else
        return 0;
}

void Braille::SetChar(string data)
{
    symbol = data;
}

string Braille::GetChar()
{
    return symbol;
}
bool Braille::CheckChar(string data)
{
    for (int x = 0; x < sizeof(data); x++)
    {
        if (data[x] != '0' && data[x] != '1' && data[x] != '\n')
            return 0;
    }
    return 1;
}
ostream &operator<<(ostream &out, const Morse &morse)
{
    out << morse.symbol;
    return out;
}
ostream &operator<<(ostream &out, const Braille &braille)
{
    out << braille.symbol;
    return out;
}
ostream &operator<<(ostream &out, const Latin &latin)
{
    out << latin.symbol;
    return out;
}
