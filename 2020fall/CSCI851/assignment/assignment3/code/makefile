CC= clang++
CCFLAGS= -std=c++11 -v
OBJECTS= main.o Morse.o Braille.o Latin.o 
TARGET= TS


$(TARGET):	$(OBJECTS)
		$(CC) $(CCFLAGS) -o $(TARGET) $(OBJECTS)

main.o:		main.cpp translation.h
		$(CC) $(CCFLAGS) -c main.cpp

Morse.o:  Morse.cpp translation.h
		$(CC) $(CCFLAGS) -c Morse.cpp

Braille.o:  Braille.cpp translation.h
		$(CC) $(CCFLAGS) -c Braille.cpp

Latin.o:  Latin.cpp translation.h
		$(CC) $(CCFLAGS) -c Latin.cpp

clean:
		rm $(OBJECTS)
		rm $(TARGET)
