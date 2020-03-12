package socks5proxy

import (
	"log"
	"net"
	"sync"
)

//TCPClient Containing Addrress and Connection
type TCPClient struct {
	conn   *net.TCPConn
	server *net.TCPAddr
}

func handleProxyRequest(localClient *net.TCPConn, serverAddr *net.TCPAddr, auth socks5Auth, recvHTTPProto string) {
	// 远程连接IO
	dstServer, err := net.DialTCP("tcp", nil, serverAddr)
	if err != nil {
		log.Print("远程服务器地址连接错误!!!")
		log.Print(err)
		return
	}
	defer dstServer.Close()
	defer localClient.Close()
	// Build secure channel with remote
	wg := new(sync.WaitGroup)
	wg.Add(2)
	log.Println(localClient.LocalAddr(), " ===> ", localClient.RemoteAddr())
	// 本地的内容copy到远程端
	go func() {
		defer wg.Done()
		SecureCopy(localClient, dstServer, auth.Encrypt)
	}()

	// 远程得到的内容copy到源地址
	go func() {
		defer wg.Done()
		SecureCopy(dstServer, localClient, auth.Decrypt)
	}()
	wg.Wait()
}

//Client Instance Client
func Client(listenAddrString string, serverAddrString string, encrytype string, passwd string, recvHTTPProto string) {
	//所有客户服务端的流都加密,
	auth, err := CreateAuth(encrytype, passwd)
	if err != nil {
		log.Fatal(err)
	}
	log.Printf("你的密码是: %s ,请保管好你的密码", passwd)

	// proxy地址
	serverAddr, err := net.ResolveTCPAddr("tcp", serverAddrString)
	if err != nil {
		log.Fatal(err)
	}
	log.Printf("连接远程服务器: %s ....", serverAddrString)

	listenAddr, err := net.ResolveTCPAddr("tcp", listenAddrString)
	if err != nil {
		log.Fatal(err)
	}
	log.Printf("监听本地端口: %s ", listenAddrString)

	listener, err := net.ListenTCP("tcp", listenAddr)
	if err != nil {
		log.Fatal(err)
	}

	for {
		localClient, err := listener.AcceptTCP()
		if err != nil {
			log.Fatal(err)
		}
		go handleProxyRequest(localClient, serverAddr, auth, recvHTTPProto)
	}
}
