CC= clang++
CCFLAGS= -std=c++2a
OBJECTS= main.o translation.o Morse.o Braille.o Latin.o Container.o
TARGET= TS


$(TARGET):	$(OBJECTS)
		$(CC) $(CCFLAGS) -o $(TARGET) $(OBJECTS)

main.o:		main.cpp translation.h
		$(CC) $(CCFLAGS) -c main.cpp

translation.o:	translation.cpp translation.h
		$(CC) $(CCFLAGS) -c translation.cpp

Morse.o:  Morse.cpp translation.h
		$(CC) $(CCFLAGS) -c Morse.cpp

Braille.o:  Braille.cpp translation.h
		$(CC) $(CCFLAGS) -c Braille.cpp

Latin.o:  Latin.cpp translation.h
		$(CC) $(CCFLAGS) -c Latin.cpp

Container.o: Container.cpp translation.h
		$(CC) $(CCFLAGS) -c Container.cpp

clean:
		rm $(OBJECTS)
		rm $(TARGET)
