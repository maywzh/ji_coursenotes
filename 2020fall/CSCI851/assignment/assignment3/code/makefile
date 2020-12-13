CC= clang++
CCFLAGS= -std=c++2a
OBJECTS= main.o translation.o 
TARGET= TS


$(TARGET):	$(OBJECTS)
		$(CC) $(CCFLAGS) -o $(TARGET) $(OBJECTS)

main.o:		main.cpp translation.h
		$(CC) $(CCFLAGS) -c main.cpp

translation.o:	translation.cpp translation.h
		$(CC) $(CCFLAGS) -c translation.cpp

clean:
		rm $(OBJECTS)
		rm $(TARGET)
