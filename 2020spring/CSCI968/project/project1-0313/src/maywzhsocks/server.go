package main

import (
	"flag"
	"log"

	socks5proxy "socks5/socks5proxy"
)

func main() {
	listenAddr := flag.String("local", ":18888", "Input server listen address(Default 8888):")
	passwd := flag.String("passwd", "123456", "Input server proxy password:")
	encrytype := flag.String("type", "random", "Input encryption type:")
	flag.Parse()
	log.Println("服务器正在启动...")
	socks5proxy.Server(*listenAddr, *encrytype, *passwd)
}
