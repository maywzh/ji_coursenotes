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
	void showData();
	void showSize();
	void Save_Trans(std::string file);
	void showDistribution();
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

	char translation_to_Latin()
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
	char translation_to_Latin()
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
	void setSymbol(char data);
	bool checkSymbol(char data);
	std::string translation_to_Morse()
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
	std::string translation_to_Braille()
	{
		for (std::map<char, std::string>::iterator iter = brailleRule.begin(); iter != brailleRule.end(); iter++)
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
	char getSymbol();
};
