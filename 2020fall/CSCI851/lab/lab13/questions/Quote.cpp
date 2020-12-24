#include<iostream>
using namespace std;

class riddle
{
	static const string key;
};

const string riddle::key{"Perhaps there is a key"};

class mystery
{
	riddle X;

};

class enigma
{
	mystery Y;
};

int main()
{

	enigma quote;

}
