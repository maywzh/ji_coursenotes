/*
6/24/2016
Programmer: Urs Evora
Shell program header file. This handles user input and is the main
interface. User entered input first enters the parseArgs function. 
A vector of arguments is then passed to the executeCmd function, which
then calls the appropriate command function. To add a command, simiply 
create the command function, add the command string and function pointer
to COMMANDS and COMMAND_FUNCS respectively.
Also modify the help function.
*/

#ifndef SHELL_H
#define SHELL_H

#include <vector>
#include <string>
#include "ANN.h"
#include "Instance.h"



// Types of arguments
enum A_TYPE { CMD, FLAG, DSC, VAL, REDIR };

struct Arg{
	A_TYPE type;
	std::string value;
};

struct ShellMem{
	std::vector<ANN> anns;
	std::vector<InstanceSet> sets;
};




// Takes a string (user input) and parses it into a vector of arguments.
// Returns -1 if the input cannot be parsed correctly.
int parseArgs( const std::string& str,  std::vector<Arg>& args );


// Takes a vector of arguments and attempts to execute the command.
// If no valid command found, returns -1.
int executeCmd( const std::vector<Arg>& args );

/* The ANN command allows for the creation and modification of anns. 
FLAGS:
-a [name=] [filename=]*, Activates on a ann with provided name. If no file is provided
to read from, the user will be prompted to manually enter values. 
-c [name=] [layers=] [learningRate=], Creates a new ann with provided name and with the network structure
defined by the provided array. 
-t [name=] [set=] [itr=] [acc=], Trains a named ann on a test set. Name is 
the name of the ann. Set is the name of the training set. Itr is the max number
iterations. acc is the desired accuracy. 
-d [name=], Displays all information available about ann.
-rm [name=], Deletes the given ann.
If arguments are not formatted correctly, returns -1.
*/
int annCmd( const std::vector<Arg>& args , ShellMem& memory, std::ostream& os);

// ANN helper functions
int annActivate( const std::vector<Arg>& args, ShellMem& memory, std::ostream& os );
int annCreate( const std::vector<Arg>& args, std::vector<ANN>& anns );
int annTrain( const std::vector<Arg>& args, ShellMem& memory );
int annDisplay( const std::vector<Arg>& args, std::vector<ANN>& anns );
int annRemove( const std::vector<Arg>& args, std::vector<ANN>& anns );


/* The set command allows for the creation and deletion of training, testing,
and general sets.
FLAGS:
-c [name=] [filename=],  Reads a training set from a file. Name is optional 
and will default to the filename (minus extension) if not provided. 
-rm [name=], Deletes given set from memory.
If arguments are not formatted correctly, returns -1.
*/
int setCmd( const std::vector<Arg>& args , ShellMem& memory, std::ostream& os);

/* The help command prints descriptive information on shell commands.
If just 'help' is entered a list of all commands will be printed. Otherwise,
the second argument should be a command which is to be described.
*/

int helpCmd( const std::vector<Arg>& args, ShellMem& memory, std::ostream& os );

/* The save command allows for ANNs and results to be saved to a JSON file.
FLAGS:
-a [filename=], Saves all anns to the same file named.
[name=] [filename=], Saves a specific ann to specified file.
*/

int saveCmd( const std::vector<Arg>& args, ShellMem& memory, std::ostream& os );

// Commands

const std::vector<std::string> COMMANDS = {
	"ann",
	"set",
	"help",
	"save"
};

//int (*COMMAND_FUNCS_ARRAY[])(const std::vector<Arg>&, ShellMem&, std::ostream& );



#endif
