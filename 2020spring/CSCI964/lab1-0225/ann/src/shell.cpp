/*
6/26/2016
Programmer: Urs Evora
*/

#include "shell.h"
#include "utils.h"		// toLower
#include "ANN.h"
#include "Instance.h"
#include <vector>
#include <string>
#include <iostream>
#include <fstream>
#include <algorithm>


// Function pointers
int (*COMMAND_FUNCS_ARRAY[])(const std::vector<Arg>&, ShellMem&, std::ostream& ) = {
	&annCmd,
	&setCmd,
	&helpCmd,
	&saveCmd
};

int parseArgs( const std::string& str,  std::vector<Arg>& args ){
	char space = ' ';
	char quote = '"';
	char dash = '-';
	char equals = '=';
	char arrow = '>';
	std::size_t bPos = 0;
	std::size_t fPos = 0;
	while( fPos < str.length() ){
		Arg temp;
		if( str[fPos] == quote ){
			bPos = fPos;
			// Find end of string argument
			++fPos;
			//std::cerr << "HERE";
			while( fPos < str.length() && str[fPos] != quote ){ ++fPos; }
			if( fPos >= str.length() ){ 
				std::cout << "Missing double quote." << std::endl;
				return -1;
			}
			else{
				temp.type = VAL;
				temp.value = str.substr( bPos + 1, (fPos-bPos) - 1 );
				args.push_back(temp);
				// seek next word
				++fPos;
				while( fPos + 1 < str.length() && str[fPos] == space ){ bPos = ++fPos; }
			}
		}
		else if( str[fPos] == space && bPos != fPos){
			std::string subStr = str.substr( bPos, fPos-bPos );
			// Command argument
			if( bPos == 0 ){
				temp.type = CMD;
				temp.value = subStr;
				args.push_back(temp);
			}
			// Flag argument
			else if( subStr[0] == dash ){
				temp.type = FLAG;
				temp.value = subStr;
				args.push_back(temp);
			}
			// Descriptor argument
			else if( subStr[subStr.length() - 1] == equals ){
				temp.type = DSC;
				temp.value = subStr;
				args.push_back(temp);
			}
			// Redirection argument
			else if( subStr[0] == arrow ){
				temp.type = REDIR;
				temp.value = subStr;
				args.push_back(temp);
			}
			else{
				temp.type = VAL;
				temp.value = subStr;
				args.push_back(temp);
			}
			bPos = fPos + 1;
		}
		//std::cerr << (int)str[fPos] << std::endl;
		//std::cerr << fPos << std::endl;
		++fPos;
	}
	// Probably make this a function...
	if( fPos == str.length() && bPos != fPos){
			Arg temp;
			std::string subStr = str.substr( bPos, fPos-bPos );
			// Command argument
			if( bPos == 0 ){
				temp.type = CMD;
				temp.value = subStr;
				args.push_back(temp);
			}
			// Flag argument
			else if( subStr[0] == dash ){
				temp.type = FLAG;
				temp.value = subStr;
				args.push_back(temp);
			}
			// Descriptor argument
			else if( subStr[subStr.length() - 1] == equals ){
				temp.type = DSC;
				temp.value = subStr;
				args.push_back(temp);
			}
			else{
				temp.type = VAL;
				temp.value = subStr;
				args.push_back(temp);
			}
	}
	return 1;
}


int executeCmd( const std::vector<Arg>& args, ShellMem& memory ){
	if( args.size() <= 0 ){
	 	std::cout << "No arguments provided." << std::endl;
	 	return -1; 
	}
	if( args[0].type != CMD ){
		std::cout << "No command found." << std::endl;
		return -1;
	}
	// Check if all commands have function pointers
	if( (sizeof(COMMAND_FUNCS_ARRAY)/sizeof(COMMAND_FUNCS_ARRAY[0]) )!= COMMANDS.size() ){
		std::cout << "Not all commands initalized." << std::endl;
		return -1;
	}
	// Check for output redirection
	std::ostream os(nullptr);
	os.rdbuf(std::cout.rdbuf());
	for( size_t i = 0; i < args.size(); ++i){
		if( args[i].type == REDIR ){
			if( args.size() > i + 1 ){
				if( args[i+1].type == VAL ){
					std::ofstream of;
					of.open(args[4].value);
					if( of.is_open() ){ 
						os.rdbuf(of.rdbuf()); 
						break;
					}
					else{ return -1; }
				}
				else{ return -1; }
			}
			else{ return -1; }
		}
	}
	// Match first argument to available commands
	std::string cmd = toLower(args[0].value);
	for( size_t i = 0; i < COMMANDS.size(); ++i ){
		if( cmd == COMMANDS[i] ){
			return COMMAND_FUNCS_ARRAY[i](args, memory, os);
		}
	}
	std::cout << "No command: " << args[0].value << " found." << std::endl;
	return -1;
}

int annCmd( const std::vector<Arg>& args, ShellMem& memory, std::ostream& os){
	if( args.size() < 2 || args[1].type != FLAG ){
		std::cout << "No flag provided." << std::endl;
		return -1;
	}
	if( args[1].value == "-a" ){ annActivate( args, memory, os ); }
	else if( args[1].value == "-c"){ annCreate( args, memory.anns ); }
	else if( args[1].value == "-t"){ annTrain( args, memory ); }
	else if( args[1].value == "-d"){ annDisplay( args, memory.anns ); }
	else if( args[1].value == "-rm"){ annRemove( args, memory.anns ); }
	return 1;
}

// ANN helper functions
int annActivate( const std::vector<Arg>& args, ShellMem& memory, std::ostream& os ){
	if( args.size() > 2 ) {
		if( args[2].type != VAL ){
			std::cout << "No Ann name provided." << std::endl;
			return -1;
		}
		std::vector<ANN>::iterator annItr = std::find( memory.anns.begin(), memory.anns.end(), args[2].value);
		if( annItr == memory.anns.end() ){ 
			std::cout << "No Ann with name " << args[2].value << " found." << std::endl;
			return -1;
		}
		ANN ann = *annItr;
		// Check for output redirection
		std::vector<double> result;
		if( args.size() > 3 ){
			// Check if file name is provided.
			if( args[3].type == VAL ){
				std::vector<InstanceSet>::iterator setItr = std::find( memory.sets.begin(), memory.sets.end(), args[3].value );
				if( setItr == memory.sets.end() ){
					std::cout << "No set with name " << args[3].value << "found." << std::endl;
					return -1;
				}
				InstanceSet set = *setItr;
				// Check if instance set matches ann
				if( !ann.checkInstance( set.instances[0] )){
					std::cout << "Provided set: " << args[3].value << " does not fit ann: " << 
					args[2].value << std::endl;
					return -1;
				}
				for( Instance& i : set.instances ){
					ann.activate( i, result );				// Might want to split this up to allow 
					printResult( result, i, os );			// for activation while printing results
				}
				return 1;	
			}
		}
		// Manual input
		else{
			std::vector<double> data;
			std::string input;
			for( size_t i = 0; i < ann.getNumOut(); ++i ){
				while( data.size() == i ){
					std::cout << "Please enter data input " << i << ":";
					std::cin >> input;
					try{
						data.push_back(std::stod(input));
					}
					catch( const std::invalid_argument& ia ){
						std::cout << "Argument: " << ia.what() << " is not valid. Please enter a valid argument." << std::endl;
					}
				}
			}
			ann.activate( data, result );
			//printResult( result, ann, os );
			return 1;
		}
	}
	else{
		std::cout << "Incorrect number of argments." << std::endl;
		return -1;
	}
}

int annCreate( const std::vector<Arg>& args, std::vector<ANN>& anns ){
	if( args.size() == 5 ){
		if( args[2].type == VAL && args[3].type == VAL  && args[4].type == VAL){
			// Check if unique name
			std::vector<ANN>::iterator itr = std::find( anns.begin(), anns.end(), args[2].value );
			if( itr != anns.end() ){
				std::cout << "An ANN with name: " << args[2].value << " already exists." << std::endl;
				return -1;
			}
			// Check for valid array
			std::vector<int> layers;
			if( !strToIntVec(args[3].value, layers) ){
				std::cout << "Array invalid." << std::endl;
				return -1;
			}
			// Check if valid learning rate
			double learningRate;
			if( !valDoubleStr( args[4].value, 0, args[4].value.size() ) ){
				std::cout << "Learning rate: " << args[4].value << " is not a double." << std::endl;
				return -1;
			}
			learningRate = std::stod(args[4].value );
			anns.push_back( ANN(layers[0], layers, learningRate, args[2].value) );
			return 1;
		}
		else{
			std::cout << "Incorrect argument types." << std::endl;
			return -1;
		}
	}
	else{
		std::cout << "Incorrect number of arguments." << std::endl; 
		return -1;
	}
}
int annTrain( const std::vector<Arg>& args, ShellMem& memory ){}
int annDisplay( const std::vector<Arg>& args, std::vector<ANN>& anns ){}
int annRemove( const std::vector<Arg>& args, std::vector<ANN>& anns ){}

int setCmd( const std::vector<Arg>& args, ShellMem& memory, std::ostream& os ){}

int helpCmd( const std::vector<Arg>& args, ShellMem& memory, std::ostream& os ){}

int saveCmd( const std::vector<Arg>& args, ShellMem& memory, std::ostream& os ){}



