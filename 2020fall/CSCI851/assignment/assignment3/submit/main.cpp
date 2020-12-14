#include "translation.h"

using namespace std;

vector<Latin> Read_from_Latin(string inputfile)
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
			if (mdata.CheckChar(value))
			{
				mdata.SetChar(value);
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
			if (mdata.CheckChar(morse))
			{
				mdata.SetChar(morse);
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
			if (mdata.CheckChar(braille))
			{
				mdata.SetChar(braille);
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
			res = inputdata[x].Trans2Latin();
			//if (res == '0') {
			//    cout << "Can not find a matching Latin ..." << endl << endl;
			//    exit(0);
			//}
			dd.SetChar(res);
			latindata.push_back(dd);
		}
		cout << "Translating success!" << endl
			 << endl;
		if (to == "L")
		{
			Container<Latin> con_latin(latindata, latindata.size());
			con_latin.ShowData();
			cout << "The length of Latin is " << latindata.size() << endl;
			con_latin.SaveTrans(outputfile);
		}

		if (to == "B")
		{
			string res;
			Braille dd;
			vector<Braille> transdata;
			std::cout << "Translating to Braille... " << std::endl;
			for (int x = 0; x < latindata.size(); x++)
			{
				res = latindata[x].Trans2Braille();
				if (res == "null")
				{
					cout << "Can not find a matching Latin ..." << endl
						 << endl;
					exit(0);
				}
				dd.SetChar(res);
				transdata.push_back(dd);
			}

			Container<Braille> con_braille(transdata, transdata.size());
			con_braille.ShowData();
			cout << "The length of Braille is ";
			con_braille.ShowSize();
			con_braille.SaveTrans(outputfile);
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
			res = inputdata[x].Trans2Latin();
			if (res == '0')
			{
				cout << "Can not find a matching Latin ..." << endl
					 << endl;
				exit(0);
			}
			dd.SetChar(res);
			latindata.push_back(dd);
		}
		cout << "Translating success!" << endl
			 << endl;

		if (to == "L")
		{
			Container<Latin> con_latin(latindata, latindata.size());
			con_latin.ShowData();
			cout << "The length of Latin is " << latindata.size() << endl;
			con_latin.SaveTrans(outputfile);
		}

		if (to == "M")
		{
			std::cout << "Translating to Morse... " << std::endl;
			string res;
			Morse dd;
			vector<Morse> transdata;
			for (int x = 0; x < latindata.size(); x++)
			{
				res = latindata[x].Trans2Morse();
				if (res == "null")
				{
					cout << "Can not find a matching Latin ..." << endl
						 << endl;
					exit(0);
				}
				dd.SetChar(res);
				transdata.push_back(dd);
			}

			Container<Morse> con_morse(transdata, transdata.size());
			con_morse.ShowData();
			cout << "The length of Morse is ";
			con_morse.ShowSize();
			con_morse.SaveTrans(outputfile);
		}
	}
	else
	{
		vector<Latin> inputdata = Read_from_Latin(inputfile);

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
				res = inputdata[x].Trans2Morse();
				if (res == "null")
				{
					cout << "Can not find a matching Latin ..." << endl
						 << endl;
					exit(0);
				}
				dd.SetChar(res);
				transdata.push_back(dd);
			}

			Container<Morse> con_morse(transdata, transdata.size());
			con_morse.ShowData();
			cout << "The length of Morse is ";
			con_morse.ShowSize();
			con_morse.SaveTrans(outputfile);
		}
		else //B
		{
			string res;
			Braille dd;
			vector<Braille> transdata;
			std::cout << "Translating to Braille... " << std::endl;
			for (int x = 0; x < inputdata.size(); x++)
			{
				res = inputdata[x].Trans2Braille();
				if (res == "null")
				{
					cout << "Can not find a matching Latin ..." << endl
						 << endl;
					exit(0);
				}
				dd.SetChar(res);
				transdata.push_back(dd);
			}

			Container<Braille> con_braille(transdata, transdata.size());
			con_braille.ShowData();
			cout << "The length of Braille is ";
			con_braille.ShowSize();
			con_braille.SaveTrans(outputfile);
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
