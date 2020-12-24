#include <iostream>
#include <thread>
#include <chrono>

using namespace std;

int main()
{

	string alpha="\"This is a wierd\a\a\a\b\b\b\beird message!\"\n\n\a\a\a";

	for ( auto c : alpha )
	{	
		std::this_thread::sleep_for(std::chrono::milliseconds(250));
		cerr << c;
	}

}
