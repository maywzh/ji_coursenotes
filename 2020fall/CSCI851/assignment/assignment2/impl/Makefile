CC=clang++
HEADER=A2.h
EVENT=Event.cpp
MEMBER=Member.cpp
PARTY=Party.cpp
ELECTORATE=Electorate.cpp
STANCE=Stance.cpp
MAIN=A2.cpp

A2: A2.o Member.o Party.o Electorate.o Stance.o Event.o
	$(CC) A2.o Member.o Party.o Electorate.o Stance.o Event.o -o APE

A2.o: $(MAIN) $(HEADER)
	$(CC) -c $(MAIN)

Member.o: $(MEMBER) $(HEADER)
	$(CC) -c $(MEMBER)

Party.o: $(PARTY) $(HEADER)
	$(CC) -c $(PARTY)

Electorate.o: $(ELECTORATE) $(HEADER)
	$(CC) -c $(ELECTORATE)

Stance.o: $(STANCE) $(HEADER)
	$(CC) -c $(STANCE)

Event.o: $(EVENT) $(HEADER)
	$(CC) -c $(EVENT)

clean:
	rm *.o
