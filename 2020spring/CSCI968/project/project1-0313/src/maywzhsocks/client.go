package main

import (
	"flag"
	"fmt"
	"log"
	"os"
	socks5proxy "socks5/socks5proxy"
)

func main() {
	fmt.Print(os.Args[0])
	listenAddr := flag.String("c", ":8488", "Input server listen address:port:")
	serverAddr := flag.String("s", ":8489", "Input server listen address:port:")
	passwd := flag.String("p", "123456", "Input server proxy password:")
	encrytype := flag.String("t", "random", "Input encryption type:")
	recvHTTPProto := flag.String("r", "http", "use http or sock5 protocol(default http):")
	flag.Parse()
	if *serverAddr == "" {
		log.Fatal("请输入正确的远程地址")
	}
	log.Println("客户端正在启动...")
	log.Println(&recvHTTPProto)
	socks5proxy.Client(*listenAddr, *serverAddr, *encrytype, *passwd, *recvHTTPProto)
}
