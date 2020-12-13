/*
 * @Author       : maywzh
 * @Date         : 2020-12-13 19:39:13
 * @LastEditTime : 2020-12-13 21:43:42
 * @LastEditors  : maywzh
 * @Description  : 
 * @FilePath     : /ji_coursenotes/2020fall/CSCI851/assignment/assignment3/code/main.cpp
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

vector<Latin> Read_Latin(string inputfile)
{
    cout << "Read Latin from " << inputfile << endl;
    ifstream infile;
    infile.open(inputfile);

    vector<Latin> inputdata;
    Latin mdata;
    char value;

    while (!infile.eof())
    {
        infile >> noskipws >> value;
        if (value != '\n')
        {
            if (mdata.checkSymbol(value))
            {
                mdata.setSymbol(value);
                inputdata.push_back(mdata);
            }
            else
            {
                cout << value << endl;
                cout << "Read a error symbol from " << inputfile << endl
                     << endl;
                exit(0);
            }
        }
    }

    return inputdata;
}

vector<Morse> Read_from_Morse(string inputfile)
{
    cout << "Read Morse from " << inputfile << endl;
    ifstream infile;
    infile.open(inputfile);

    vector<Morse> inputdata;
    Morse mdata;
    char value;
    string morse;
    int pos = 0;

    while (!infile.eof())
    {
        infile >> noskipws >> value;
        if ((value == ' ') || (value == '\n'))
        {
            if (mdata.checkSymbol(morse))
            {
                mdata.setSymbol(morse);
                inputdata.push_back(mdata);
                morse.clear();
            }
            else
            {
                cout << morse << endl;
                cout << "Read a error symbol from " << inputfile << endl
                     << endl;
                exit(0);
            }
        }
        else
        {
            morse = morse + value;
        }
    }
    inputdata.pop_back();
    return inputdata;
}

vector<Braille> Read_from_Braille(string inputfile)
{
    cout << "Read Braille from " << inputfile << endl;
    ifstream infile;
    infile.open(inputfile);

    vector<Braille> inputdata;
    Braille mdata;
    char value;
    string braille;
    int bpos = 0;

    while (!infile.eof())
    {
        infile >> noskipws >> value;
        if (bpos == 6)
        {
            if (mdata.checkSymbol(braille))
            {
                mdata.setSymbol(braille);
                inputdata.push_back(mdata);
                braille.clear();
                bpos = 1;
                braille = braille + value;
            }
            else
            {
                cout << braille << endl;
                cout << "Read a error symbol from " << inputfile << endl
                     << endl;
                exit(0);
            }
        }
        else
        {
            braille = braille + value;
            bpos++;
        }
    }
    return inputdata;
}

void translation(string from, string to, string inputfile, string outputfile)
{
    ifstream infile;
    infile.open(inputfile);
    int size = 0;

    if (from == "M")
    {
        vector<Morse> inputdata = Read_from_Morse(inputfile);

        Container<Morse> con_morse(inputdata, inputdata.size()); //read in.txt
        con_morse.ShowData();
        cout << "The size of Morse is ";
        con_morse.ShowSize();
        cout << endl
             << endl;

        char res;
        Latin dd;
        vector<Latin> latindata;
        for (int x = 0; x < inputdata.size(); x++)
        {
            res = inputdata[x].translation_to_Latin();
            //if (res == '0') {
            //    cout << "Can not find a matching Latin ..." << endl << endl;
            //    exit(0);
            //}
            dd.setSymbol(res);
            latindata.push_back(dd);
        }
        cout << "Translating success!" << endl
             << endl;
        if (to == "L")
        {
            Container<Latin> con_latin(latindata, latindata.size());
            con_latin.ShowData();
            cout << "The length of Latin is " << latindata.size() << endl;
            con_latin.Save_Trans(outputfile);
        }

        if (to == "B")
        {
            string res;
            Braille dd;
            vector<Braille> transdata;
            std::cout << "Translating to Braille... " << std::endl;
            for (int x = 0; x < latindata.size(); x++)
            {
                res = latindata[x].translation_to_Braille();
                if (res == "null")
                {
                    cout << "Can not find a matching Latin ..." << endl
                         << endl;
                    exit(0);
                }
                dd.setSymbol(res);
                transdata.push_back(dd);
            }

            Container<Braille> con_braille(transdata, transdata.size());
            con_braille.ShowData();
            cout << "The length of Braille is ";
            con_braille.ShowSize();
            con_braille.Save_Trans(outputfile);
        }
    }
    else if (from == "B")
    {
        vector<Braille> inputdata = Read_from_Braille(inputfile);

        Container<Braille> con_braille(inputdata, inputdata.size()); //read in.txt
        con_braille.ShowData();
        cout << "The size of braille is " << inputdata.size() << endl
             << endl
             << endl;

        std::cout << "Translating to Latin... " << std::endl;
        char res;
        Latin dd;
        vector<Latin> latindata;
        for (int x = 0; x < inputdata.size(); x++)
        {
            res = inputdata[x].translation_to_Latin();
            if (res == '0')
            {
                cout << "Can not find a matching Latin ..." << endl
                     << endl;
                exit(0);
            }
            dd.setSymbol(res);
            latindata.push_back(dd);
        }
        cout << "Translating success!" << endl
             << endl;

        if (to == "L")
        {
            Container<Latin> con_latin(latindata, latindata.size());
            con_latin.ShowData();
            cout << "The length of Latin is " << latindata.size() << endl;
            con_latin.Save_Trans(outputfile);
        }

        if (to == "M")
        {
            std::cout << "Translating to Morse... " << std::endl;
            string res;
            Morse dd;
            vector<Morse> transdata;

            for (int x = 0; x < latindata.size(); x++)
            {
                std::cout << x << std::endl;
                res = latindata[x].translation_to_Morse();
                if (res == "null")
                {
                    cout << "Can not find a matching Latin ..." << endl
                         << endl;
                    exit(0);
                }
                dd.setSymbol(res);
                transdata.push_back(dd);
            }

            Container<Morse> con_morse(transdata, transdata.size());
            con_morse.ShowData();
            cout << "The length of Morse is ";
            con_morse.ShowSize();
            con_morse.Save_Trans(outputfile);
        }
    }
    else
    {
        vector<Latin> inputdata = Read_Latin(inputfile);

        Container<Latin> con_latin(inputdata, inputdata.size()); //read in.txt
        con_latin.ShowData();
        cout << "The size of Latin is " << inputdata.size() << endl
             << endl
             << endl;

        if (to == "M")
        {
            std::cout << "Translating to Morse... " << std::endl;
            string res;
            Morse dd;
            vector<Morse> transdata;
            for (int x = 0; x < inputdata.size(); x++)
            {
                res = inputdata[x].translation_to_Morse();
                if (res == "null")
                {
                    cout << "Can not find a matching Latin ..." << endl
                         << endl;
                    exit(0);
                }
                dd.setSymbol(res);
                transdata.push_back(dd);
            }

            Container<Morse> con_morse(transdata, transdata.size());
            con_morse.ShowData();
            cout << "The length of Morse is ";
            con_morse.ShowSize();
            con_morse.Save_Trans(outputfile);
        }
        else //B
        {
            string res;
            Braille dd;
            vector<Braille> transdata;
            std::cout << "Translating to Braille... " << std::endl;
            for (int x = 0; x < inputdata.size(); x++)
            {
                res = inputdata[x].translation_to_Braille();
                if (res == "null")
                {
                    cout << "Can not find a matching Latin ..." << endl
                         << endl;
                    exit(0);
                }
                dd.setSymbol(res);
                transdata.push_back(dd);
            }

            Container<Braille> con_braille(transdata, transdata.size());
            con_braille.ShowData();
            cout << "The length of Braille is ";
            con_braille.ShowSize();
            con_braille.Save_Trans(outputfile);
        }
    }
}

std::map<char, std::string> load_rule(string filename)
{
    ifstream morsef;
    morsef.open(filename);
    string lineStr;
    char key;
    string value;
    int pos = 0;
    std::map<char, std::string> rule;

    getline(morsef, lineStr);
    while (!morsef.eof())
    {
        key = lineStr[0];
        pos = lineStr.find(" ");
        value = lineStr.substr(pos + 1, lineStr.length() - 1);

        getline(morsef, lineStr);

        rule.insert(std::make_pair(key, value));
        value.clear();
    }
    std::cout << "Load " << rule.size() << " rules" << std::endl;
    // for (std::map<char, std::string>::iterator iter = rule.begin(); iter != rule.end(); iter++)
    // {
    //     if (iter != rule.end())
    //     {
    //         std::cout << iter->first << " : " << iter->second << std::endl;
    //     }
    // }
    return rule;
}

int main(int argc, char *argv[])
{
    if (argc != 5)
    {
        cout << "Incorrect input format aa!" << endl;
        return 0;
    }

    if (argv[1] == argv[2])
    {
        cout << "Nothing to translate !" << endl;
        return 0;
    }

    if ((std::string)argv[1] != "M" && (std::string)argv[1] != "B" && (std::string)argv[1] != "L")
    {
        cout << "Incorrect input format !" << endl;
        return 0;
    }

    if ((std::string)argv[2] != "M" && (std::string)argv[2] != "B" && (std::string)argv[2] != "L")
    {
        cout << "Incorrect input format !" << endl;
        return 0;
    }

    //init rule
    cout << endl
         << endl;
    if ((std::string)argv[1] == "M" || (std::string)argv[2] == "M")
    {
        cout << "Loading Morse rule ..." << endl;
        morseRule = load_rule(MORSEFILE);
    }
    if ((std::string)argv[1] == "B" || (std::string)argv[2] == "B")
    {
        cout << "Loading Braille rule ..." << endl
             << endl
             << endl;
        brailleRule = load_rule(BRAILLEFILE);
    }

    translation(argv[1], argv[2], argv[3], argv[4]);

    return 0;
}
