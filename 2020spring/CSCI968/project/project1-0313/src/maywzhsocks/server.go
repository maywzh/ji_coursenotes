package main

import (
	"flag"
	"log"

	socks5proxy "socks5/socks5proxy"
)

func main() {
	listenAddr := flag.String("s", "127.0.0.1:8489", "Input server listen address:port:")
	passwd := flag.String("p", "123456", "Input server proxy password:")
	encrytype := flag.String("t", "random", "Input encryption type:")
	flag.Parse()
	log.Println("Server launching...")
	socks5proxy.Server(*listenAddr, *encrytype, *passwd)
}
