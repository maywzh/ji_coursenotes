/*
 * @Author: your name
 * @Date: 2020-03-15 03:30:14
 * @LastEditTime: 2020-03-15 03:33:08
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /ji_coursenotes/2020spring/CSCI968/project/project1-0313/src/maywzhsocks/client.go
 */
package main

import (
	"flag"
	"log"
	socks5proxy "socks5/socks5proxy"
)

func main() {
	listenAddr := flag.String("c", "127.0.0.1:8488", "Input server listen address:port:")
	serverAddr := flag.String("s", "127.0.0.1:8489", "Input server listen address:port:")
	passwd := flag.String("p", "123456", "Input server proxy password:")
	encrytype := flag.String("t", "random", "Input encryption type:")
	recvHTTPProto := flag.String("r", "http", "use http or sock5 protocol(default http):")
	flag.Parse()
	if *serverAddr == "" {
		log.Fatal("Input correct remote address")
	}
	log.Println("Client launching...")
	socks5proxy.Client(*listenAddr, *serverAddr, *encrytype, *passwd, *recvHTTPProto)
}
