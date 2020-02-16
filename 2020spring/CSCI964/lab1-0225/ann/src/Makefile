# This is a comment. All will run by default when make is called in the 
# directory

CC=g++

CFLAGS= -std=c++14 -c

SOURCES= main.o ANN.o Neuron.o Instance.o utils.o preprocessor.o


all: support ann 

test: testAnn

support: Instance.o utils.o preprocessor.o

# Compile with tester main file
testAnn: tester.o shell.o ANN.o Neuron.o Instance.o utils.o preprocessor.o
	$(CC) tester.o shell.o ANN.o Neuron.o Instance.o utils.o preprocessor.o -o testAnn

ann: main.o ANN.o Neuron.o
	$(CC) $(SOURCES) -o ann
	
	#g++ Neuron.o -o neuron

main.o: main.cpp
	$(CC) $(CFLAGS) main.cpp

tester.o: tester.cpp
	$(CC) $(CFLAGS) tester.cpp
	
shell.o: shell.cpp
	$(CC) $(CFLAGS) shell.cpp
	
ANN.o: ANN.cpp
	$(CC) $(CFLAGS) ANN.cpp
	
Neuron.o: Neuron.cpp
	$(CC) $(CFLAGS) Neuron.cpp
	
Instance.o: Instance.cpp
	$(CC) $(CFLAGS) Instance.cpp
	
utils.o: utils.cpp
	$(CC) $(CFLAGS) utils.cpp

preprocessor.o: preprocessor.cpp
	$(CC) $(CFLAGS) preprocessor.cpp
	
clean:
					rm -rf *o ann
					rm -rf *o testAnn

