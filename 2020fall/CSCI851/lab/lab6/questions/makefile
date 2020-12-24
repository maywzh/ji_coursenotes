prog:	main.o f1.o f2.o
        CC -o prog main.o f1.o f2.o

main.o:	main.cpp f1.h f2.h
	CC -c main.cpp

f1.o:	f1.cpp f1.h
        CC -c f1.cpp

f2.o:	f2.cpp f2.h
	CC -c f2.cpp

clean:	
	rm *.o

