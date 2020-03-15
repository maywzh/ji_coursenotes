/*
 * @Author: your name
 * @Date: 2020-03-15 03:52:43
 * @LastEditTime: 2020-03-15 03:52:53
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /ji_coursenotes/2020spring/CSCI968/project/project1-0313/src/maywzhsocks/server.go
 */
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
