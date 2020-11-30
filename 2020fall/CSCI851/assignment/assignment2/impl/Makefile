CC=clang++
HEADER=Main.h
EVENT=Event.cpp
MEMBER=Member.cpp
PARTY=Party.cpp
ELECTORATE=Elect.cpp
STANCE=Stance.cpp
MAIN=Main.cpp

Main: Main.o Member.o Party.o Elect.o Stance.o Event.o
	$(CC) Main.o Member.o Party.o Elect.o Stance.o Event.o -o APE

Main.o: $(MAIN) $(HEADER)
	$(CC) -c $(MAIN)

Member.o: $(MEMBER) $(HEADER)
	$(CC) -c $(MEMBER)

Party.o: $(PARTY) $(HEADER)
	$(CC) -c $(PARTY)

Elect.o: $(ELECTORATE) $(HEADER)
	$(CC) -c $(ELECTORATE)

Stance.o: $(STANCE) $(HEADER)
	$(CC) -c $(STANCE)

Event.o: $(EVENT) $(HEADER)
	$(CC) -c $(EVENT)

clean:
	rm *.o
