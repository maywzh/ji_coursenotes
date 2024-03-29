/*
 * @Author       : maywzh
 * @Date         : 2020-12-13 19:38:20
 * @LastEditTime : 2020-12-13 20:27:46
 * @LastEditors  : maywzh
 * @Description  : 
 * @FilePath     : /ji_coursenotes/2020fall/CSCI851/assignment/assignment3/code/Braille.cpp
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
void Braille::setSymbol(string data)
{
    symbol = data;
}

string Braille::getSymbol()
{
    return symbol;
}
bool Braille::checkSymbol(string data)
{
    for (int x = 0; x < sizeof(data); x++)
    {
        if (data[x] != '0' && data[x] != '1' && data[x] != '\n')
            return 0;
    }
    return 1;
}

char Braille::translation_to_Latin()
{
    for (std::map<char, std::string>::iterator iter = brailleRule.begin(); iter != brailleRule.end(); iter++)
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

ostream &operator<<(ostream &out, const Braille &braille)
{
    out << braille.symbol;
    return out;
}