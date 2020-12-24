prog:	main.o fa.o fb.o
	CC -o prog main.o fa.o fb.o

main.o:	main.cpp
	CC -c main.cpp

fa.o:	fa.cpp fa.h
	CC -c fa.cpp

fb.o:	fb.cpp fb.h
	CC -c fb.cpp

clean:	
	rm *.o
