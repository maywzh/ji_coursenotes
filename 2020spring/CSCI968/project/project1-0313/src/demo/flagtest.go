package main

import (
	"flag"
	"fmt"
)

var b = flag.Bool("b", false, "bool类型参数")
var s = flag.String("s", "", "string类型参数")

func main() {
	flag.Parse()
	fmt.Println("-b:", *b)
	fmt.Println("-s:", *s)
	fmt.Println("其他参数：", flag.Args())
}
