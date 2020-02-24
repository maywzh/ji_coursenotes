DIR=./
 
#在源码所在目录下生成可执行文件main
BIN=$(DIR)/main
 
SHARE=--share
 
#显示所有编译警告，并指示公共头文件(静态库和动态库的头文件)所在目录
CFLAG= -Wall -g
 
CC=g++ -o
 
AR=ar -cr
 
#使用gcc -o 链接命令
CO=$(CC)
 
 
#-------------------------以下为通用不变区域-----------------------
 
#SRC指的是指定目录下的所有.c文件名，OBJ指的是指定目录下的所有.o文件名
SRC=$(wildcard $(DIR)/*.cc)
OBJ=$(patsubst %.cc, %.o, $(SRC))
 
#链接命令
all:$(BIN)
$(BIN):$(OBJ)
	$(CO) $@ $^ $(LFLAG)
 
#编译命令
$(DIR)/%.o:$(DIR)/%.cc
	$(CO) $@ -c $< $(CFLAG)
 
 
#清除无用文件
.PHONY: test clean

test:
	./main

clean:
	rm $(OBJ) $(BIN)
