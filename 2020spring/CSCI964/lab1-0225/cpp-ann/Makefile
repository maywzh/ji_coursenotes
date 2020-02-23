CXX = g++
CXXFLAGS = -std=c++14 -Wall -MMD -Werror=vla 
OBJECTS = main.o neuralnet.o matrix.o
DEPENDS = ${OBJECTS:.o=.d}

EXEC = ann
${EXEC} : ${OBJECTS} 
	${CXX} ${CXXFLAGS} ${OBJECTS} -o ${EXEC} 
-include ${DEPENDS} 