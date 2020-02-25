


all: main.cpp NN.h NN.cpp train.h train.cpp dataset.h dataset.cpp layer.h layer.cpp
	g++ -I/u/courbarm/Eigen/ -O3 -fopenmp -std=c++0x -o out $^

clean:
	rm -rf *.gch *.o out
