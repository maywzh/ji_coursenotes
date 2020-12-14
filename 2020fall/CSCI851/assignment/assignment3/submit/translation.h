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

static std::map<char, std::string> morseRule;
static std::map<char, std::string> brailleRule;

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
	void SaveTrans(std::string file);
	void ShowDistribution();
};

template <typename T>
Container<T>::Container(std::vector<T> d, int s)
{
	data.assign(d.begin(), d.end());
	datasize = s;
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
void Container<T>::SaveTrans(std::string file)
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
void Container<T>::ShowSize()
{
	int size = 0;
	for (int x = 0; x < datasize; ++x)
	{
		size = size + data[x].symbol.length();
	}
	std::cout << size << std::endl;
}

class Morse
{
	friend std::ostream &operator<<(std::ostream &, const Morse &);

public:
	std::string symbol;

public:
	void SetChar(std::string data);
	std::string GetChar();
	bool CheckChar(std::string data);

	char Trans2Latin()
	{
		std::cout << "Finding " << symbol << endl;
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
};

class Braille
{
	friend std::ostream &operator<<(std::ostream &, const Braille &);

public:
	std::string symbol;

public:
	void SetChar(std::string data);
	std::string GetChar();
	bool CheckChar(std::string data);
	char Trans2Latin()
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
};

class Latin
{
	friend std::ostream &operator<<(std::ostream &, const Latin &);

public:
	char symbol;

public:
	void SetChar(char data);
	bool CheckChar(char data);
	std::string Trans2Morse()
	{
		if (symbol == ' ')
			symbol = '_';
		if (morseRule.count(symbol))
		{
			return morseRule[symbol];
		}
		return "null";
	}
	std::string Trans2Braille()
	{
		if (symbol == ' ')
			symbol = '_';
		if (brailleRule.count(symbol))
		{
			return brailleRule[symbol];
		}
		return "null";
	}
	char GetChar();
};
