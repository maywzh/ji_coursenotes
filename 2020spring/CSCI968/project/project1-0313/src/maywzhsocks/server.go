package main

import (
	"flag"
	"log"

	socks5proxy "socks5/socks5proxy"
)

func main() {
	listenAddr := flag.String("s", ":8488", "Input server listen port(Default 8888):")
	passwd := flag.String("p", "123456", "Input server proxy password:")
	encrytype := flag.String("t", "random", "Input encryption type:")
	flag.Parse()
	log.Println("服务器正在启动...")
	socks5proxy.Server(*listenAddr, *encrytype, *passwd)
}
