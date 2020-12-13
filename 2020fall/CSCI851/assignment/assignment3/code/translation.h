/*
 * @Author       : maywzh
 * @Date         : 2020-12-13 11:37:51
 * @LastEditTime : 2020-12-13 21:44:36
 * @LastEditors  : maywzh
 * @Description  : 
 * @FilePath     : /ji_coursenotes/2020fall/CSCI851/assignment/assignment3/code/translation.h
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
#include <vector>
#include <string>
#include <map>
#include <fstream>
#include <utility>
#include <cstring>
#include <typeinfo>

#define MORSEFILE "Morse.txt"
#define BRAILLEFILE "Braille.txt"
using namespace std;
extern std::map<char, std::string> morseRule;
extern std::map<char, std::string> brailleRule;

template <typename T>
class Container
{
private:
	std::vector<T> data;
	int datasize;

public:
	Container(std::vector<T> d, int s);
	void ShowData();
	void ShowSize();
	void Save_Trans(std::string file);
	void ShowDistribution();
};

class Morse
{
	friend std::ostream &operator<<(std::ostream &, const Morse &);

public:
	std::string symbol;

public:
	void setSymbol(std::string data);
	std::string getSymbol();
	bool checkSymbol(std::string data);
	char translation_to_Latin();
	//char translation_to_Latin(const std::map<char, std::string> *);
};

class Braille
{
	friend std::ostream &operator<<(std::ostream &, const Braille &);

public:
	std::string symbol;

public:
	void setSymbol(std::string data);
	std::string getSymbol();
	bool checkSymbol(std::string data);
	char translation_to_Latin();
	//char translation_to_Latin(const std::map<char, std::string> *);
};

class Latin
{
	friend std::ostream &operator<<(std::ostream &, const Latin &);

public:
	char symbol;

public:
	void setSymbol(char data);
	bool checkSymbol(char data);
	std::string translation_to_Morse();
	//std::string translation_to_Morse(const std::map<char, std::string> *);
	std::string translation_to_Braille();
	//std::string translation_to_Braille(const std::map<char, std::string> *);
	char getSymbol();
};

template <typename T>
Container<T>::Container(std::vector<T> d, int s)
{
	data.assign(d.begin(), d.end());
	datasize = s;
}

template <typename T>
void Container<T>::ShowData()
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
void Container<T>::ShowSize()
{
	int size = 0;
	for (int x = 0; x < datasize; ++x)
	{
		size = size + data[x].symbol.length();
	}
	std::cout << size << std::endl;
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
void Container<T>::ShowDistribution()
{
	int count[256] = {};
	for (int x = 0; x < datasize; ++x)
	{
		for (int i = 0; i < data[x].size() / sizeof(data[0].symbol); i++)
		{
		}
	}
}
