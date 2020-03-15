package main

import (
	"fmt"
)

func f1() (result int) {
	defer func() {
		result++
	}()
	return 0
}
func f2() (r int) {
	t := 5
	defer func() {
		t = t + 5
	}()
	return t
}
func f3() (r int) {
	defer func(r int) {
		r = r + 5
	}(r)
	return 1
}
func main() {
	fmt.Println(f1())
	fmt.Println(f2())
	fmt.Println(f3())
}

//函数返回的过程是这样的：先给返回值赋值，然后调用defer表达式，最后才是返回到调用函数中
//返回值 = xxx => 调用defer函数 => 空的return
