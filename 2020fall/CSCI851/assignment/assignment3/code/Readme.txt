To compile and execute the program successfully

You should put translation.h translation.cpp, main.cpp and makefile in the same folder.

Definitely, Braille.txt, Morse.txt, and so on should be included in the same folder.
 
Then enter the next two instructions :

$ make
$ ./TS M L M1.txt out.txt


After entering make, the makefile will be excecuted and all .cpp files compiled successfully.
Then target file TS emerged.

Then $ ./TS M L M1.txt out.txt, you can see one of a example from Morse to Latin.

PS: the second line's framwork is $./TS From To In.txt Out.txt 
From can be M, B. And To can be L.