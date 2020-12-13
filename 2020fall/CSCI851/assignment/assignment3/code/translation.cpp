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
    for(int x=0;x<data.length();x++)
    {
        if((data[x] != '.') && (data[x]!='-' )&& (data[x]!= '\n') /*&& (data[x]!= '\t')*/)
            return 0;
    }
    return 1;
}
/*
std::string Latin::translation_to_Morse()

*/
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
    if((data == ' ')|| (data == '\n'))
        return 1;
    else if (data >= 'a' && data <= 'z' )
        return 1;
    else
        return 0;
}

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
    for(int x=0;x< sizeof(data);x++)
    {
        if(data[x] != '0' && data[x]!='1' && data[x]!= '\n')
            return 0;
    }
    return 1;
}
ostream& operator<<(ostream&out, const Morse & morse)
{
    out << morse.symbol;
    return out;
}
ostream& operator<<(ostream&out, const Braille & braille)
{
    out << braille.symbol;
    return out;
}
ostream& operator<<(ostream&out, const Latin & latin)
{
    out << latin.symbol;
    return out;
}
