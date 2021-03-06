/*
 * @Author       : maywzh
 * @Date         : 2020-12-13 19:38:31
 * @LastEditTime : 2020-12-13 21:37:29
 * @LastEditors  : maywzh
 * @Description  : 
 * @FilePath     : /ji_coursenotes/2020fall/CSCI851/assignment/assignment3/code/Latin.cpp
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

void Latin::setSymbol(char data)
{
    symbol = data;
}

char Latin::getSymbol()
{
    return symbol;
}

bool Latin::checkSymbol(char data)
{
    if ((data == ' ') || (data == '\n'))
        return 1;
    else if (data >= 'a' && data <= 'z')
        return 1;
    else
        return 0;
}

ostream &operator<<(ostream &out, const Latin &latin)
{
    out << latin.symbol;
    return out;
}

std::string Latin::translation_to_Morse()
{
    int mm = 0;
    for (std::map<char, std::string>::iterator iter = morseRule.begin(); iter != morseRule.end(); iter++)
    {
        if (symbol == ' ')
            symbol = '_';
        if (symbol == iter->first)
        {
            return iter->second;
        }
    }
    return "null";
}

std::string Latin::translation_to_Braille()
{
    std::cout << "Finding " << symbol << endl;
    // for (std::map<char, std::string>::iterator iter = brailleRule.begin(); iter != brailleRule.end(); iter++)
    // {
    //     if (iter != brailleRule.end())
    //     {
    //         std::cout << iter->first << " : " << iter->second << std::endl;
    //     }
    // }
    std::map<char, std::string>::iterator iter = brailleRule.find(symbol);
    if (iter != brailleRule.end())
    {
        return iter->second;
    }
    return "null";
}