CC= clang++
CCFLAGS= -std=c++2a
OBJECTS= main.o trans.o 
TARGET= TS


$(TARGET):	$(OBJECTS)
		$(CC) $(CCFLAGS) -o $(TARGET) $(OBJECTS)

main.o:		main.cpp translation.h
		$(CC) $(CCFLAGS) -c main.cpp

trans.o:	trans.cpp translation.h
		$(CC) $(CCFLAGS) -c trans.cpp

clean:
		rm $(OBJECTS)
		rm $(TARGET)
