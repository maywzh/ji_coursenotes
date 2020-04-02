//+build ignore
package main

import (
	"crypto/aes"
	"crypto/cipher"
	"crypto/rand"
	"crypto/sha256"
	"encoding/binary"
	"errors"
	"fmt"
	"io"
	"log"
	"net"
	"os"
	"strconv"

	"golang.org/x/crypto/chacha20poly1305"
	"golang.org/x/crypto/pbkdf2"
)

const (
	maxLength = 8192
	// NegotiationMessage
	versionLoc  = 0
	nmethodsLoc = 1
	// Request
	cmdLoc      = 1
	rsvLoc      = 2
	atypeLoc    = 3
	typeConnect = 1
	typeIPv4    = uint8(1)
	typeDomain  = uint8(3)
	typeIPv6    = uint8(4)
	lenIPv4     = 4
	lenIPv6     = 16
	lenDmBase   = 3 + 1 + 1 + 2
)

type (

	// NegotiationMessage version numberofMethods methods
	NegotiationRequest struct {
		Ver      uint8
		Nmethods uint8
		Methods  []uint8
	}

	// NegotiationResponse version methods
	NegotiationResponse struct {
		Ver    uint8
		Method uint8
	}

	// Request
	Request struct {
		Ver     uint8
		Cmd     uint8
		Rsv     uint8
		Atyp    uint8
		dstPort uint16
		address string
	}
)

// Proxy 代理模式直接代理
type Proxy struct {
	proxyType  string
	k          []byte
	trueClient *net.TCPConn
}

func (c *Proxy) Write(bytes []byte) (count int, err error) {

	if c.proxyType == "1" {
		ciphertext, nonce := AesGcmEncrypt(c.k, bytes)

		cbuf := make([]byte, 0)
		cbuf = append(cbuf, 'V')
		size := make([]byte, 2)
		binary.BigEndian.PutUint16(size, uint16(len(nonce)+len(ciphertext)))
		cbuf = append(cbuf, size...)
		cbuf = append(cbuf, nonce...)
		cbuf = append(cbuf, ciphertext...)

		count, err = c.trueClient.Write(cbuf)
		if err != nil {
			return
		}
		return

	} else if c.proxyType == "2" {
		ciphertext, nonce := chacha20poly1305Encrypt(c.k, bytes)

		cbuf := make([]byte, 0)
		cbuf = append(cbuf, 'V')
		size := make([]byte, 2)
		binary.BigEndian.PutUint16(size, uint16(len(nonce)+len(ciphertext)))
		cbuf = append(cbuf, size...)
		// body
		cbuf = append(cbuf, nonce...)
		cbuf = append(cbuf, ciphertext...)

		count, err = c.trueClient.Write(cbuf)
		if err != nil {
			return
		}
		return
	} else {
		cbuf := make([]byte, 0)
		cbuf = append(cbuf, 'V')
		size := make([]byte, 2)
		binary.BigEndian.PutUint16(size, uint16(len(bytes)))
		cbuf = append(cbuf, size...)
		// body
		cbuf = append(cbuf, bytes...)

		count, err = c.trueClient.Write(cbuf)
		if err != nil {
			return
		}
		return
	}
}

func (c *Proxy) Read(bytes []byte) (int, error) {
	if c.proxyType == "1" {

		buf := make([]byte, 3)
		_, err := io.ReadFull(c.trueClient, buf)
		if err != nil && err == io.EOF {
			return 0, err
		}
		if buf[0] != 'V' {
			return 0, errors.New("unpack protocol wrong start")
		}
		length := binary.BigEndian.Uint16(buf[1:3])
		bodyBuf := make([]byte, length)
		_, err = io.ReadFull(c.trueClient, bodyBuf)
		if err != nil && err == io.EOF {
			return 0, err
		}
		eBytes, err := AesGcmDecrypt(c.k, bodyBuf[12:], bodyBuf[:12])
		count := len(eBytes)
		if err != nil {
			return count, err
		}
		copy(bytes, eBytes)

		return count, err

	} else if c.proxyType == "2" {
		buf := make([]byte, 3)
		_, err := io.ReadFull(c.trueClient, buf)
		if err != nil && err == io.EOF {
			return 0, err
		}
		if buf[0] != 'V' {
			return 0, errors.New("unpack protocol wrong start")
		}
		length := binary.BigEndian.Uint16(buf[1:3])
		bodyBuf := make([]byte, length)
		_, err = io.ReadFull(c.trueClient, bodyBuf)
		if err != nil && err == io.EOF {
			return 0, err
		}
		eBytes, err := chacha20poly1305Decrypt(c.k, bodyBuf[12:], bodyBuf[:12])
		count := len(eBytes)
		if err != nil {
			return count, err
		}
		copy(bytes, eBytes)

		return count, err
	} else {
		buf := make([]byte, 3)
		_, err := io.ReadFull(c.trueClient, buf)
		if err != nil && err == io.EOF {
			return 0, err
		}
		if buf[0] != 'V' {
			return 0, errors.New("unpack protocol wrong start")
		}
		length := binary.BigEndian.Uint16(buf[1:3])
		bodyBuf := make([]byte, length)
		_, err = io.ReadFull(c.trueClient, bodyBuf)
		if err != nil && err == io.EOF {
			return 0, err
		}
		count := len(bodyBuf)
		copy(bytes, bodyBuf)
		return count, err
	}

}

func netCopyToProxy(input *Proxy, output *net.TCPConn) (err error) {
	buf := make([]byte, 8192)
	for {
		count, err := input.Read(buf)
		if err != nil {
			if err == io.EOF && count > 0 {
				output.Write(buf[:count])
			}
			break
		}
		if count > 0 {
			output.Write(buf[:count])
		}
	}
	return
}
func netCopyFromProxy(input *net.TCPConn, output *Proxy) (err error) {
	buf := make([]byte, 8192)
	for {
		count, err := input.Read(buf)
		if err != nil {
			if err == io.EOF && count > 0 {
				output.Write(buf[:count])
			}
			break
		}
		if count > 0 {
			output.Write(buf[:count])
		}
	}
	return
}
func send(ssServer *Proxy, bytes []byte) (err error) {
	_, err = ssServer.Write(bytes)
	if err != nil {
		return
	}
	return
}
func decodeNegotiationRequest(client *Proxy) (message *NegotiationRequest, err error) {
	buf := make([]byte, maxLength)

	_, err = client.Read(buf)
	if err != nil {
		// log.Println("[decodeNegotiationRequest eeeee err]", err)
		err = errors.New("Client Read err")
		return
	}

	message = new(NegotiationRequest)
	version := uint8(buf[versionLoc])
	if version != 5 {
		err = errors.New("NOT a Socks5 message")
		return
	}
	nMethods := uint8(buf[nmethodsLoc])
	if nMethods == 0 {
		err = errors.New("Have 0 methods")
		return
	}

	message.Ver = version
	message.Nmethods = nMethods
	for i := uint8(2); i < (2 + message.Nmethods); i++ {
		message.Methods = append(message.Methods, uint8(buf[i]))
	}
	return

}

func sendNegotiationResponse(client *Proxy, message *NegotiationResponse) (err error) {
	buf := make([]byte, 0)
	buf = append(buf, byte(message.Ver))
	buf = append(buf, byte(message.Method))
	err = send(client, buf)
	if err != nil {
		return
	}
	return
}

func decodeRequest(client *Proxy) (message *Request, err error) {
	buf := make([]byte, maxLength)
	_, err = client.Read(buf)

	if err != nil {
		return
	}

	message = new(Request)
	version := uint8(buf[versionLoc])
	if version != 5 {
		err = errors.New("NOT a socks5 request")
		return
	}
	message.Ver = version
	command := uint8(buf[cmdLoc])
	if command != typeConnect {
		err = errors.New("only CONNECT be able to accept")
		return
	}
	message.Cmd = command
	rsa := uint8(buf[rsvLoc])
	atyp := uint8(buf[atypeLoc])
	message.Rsv = rsa
	message.Atyp = atyp
	var addrEnd int
	if atyp == typeIPv4 {
		ipStart := atypeLoc + 1
		addrEnd = ipStart + lenIPv4
		message.address = net.IP(buf[ipStart:addrEnd]).String()
	} else if atyp == typeIPv6 {
		ipStart := atypeLoc + 1
		addrEnd = ipStart + lenIPv6
		message.address = net.IP(buf[ipStart:addrEnd]).String()
	} else if atyp == typeDomain {
		addLengthLoc := atypeLoc + 1
		domainLength := int(buf[addLengthLoc])
		domainStart := addLengthLoc + 1
		addrEnd = int(addLengthLoc) + domainLength + 1
		message.address = string(buf[domainStart:addrEnd])
	} else {
		err = fmt.Errorf("address type is Unknown: %d", atyp)
		return
	}
	message.dstPort = binary.BigEndian.Uint16(buf[addrEnd : addrEnd+2])
	return
}

func sendResponse(client *Proxy) (err error) {
	err = send(client, []byte{0x05, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x80, 0x88})
	if err != nil {
		return
	}
	return
}

// AesGcmEncrypt takes an encryption key and a plaintext string and encrypts it with AES256 in GCM mode, which provides authenticated encryption. Returns the ciphertext and the used nonce.
func AesGcmEncrypt(key []byte, plaintext []byte) (ciphertext, nonce []byte) {
	// plaintextBytes := []byte(plaintext)

	block, err := aes.NewCipher(key)
	if err != nil {
		panic(err.Error())
	}

	// Never use more than 2^32 random nonces with a given key because of the risk of a repeat.
	nonce = make([]byte, 12)
	if _, err := io.ReadFull(rand.Reader, nonce); err != nil {
		panic(err.Error())
	}

	aesgcm, err := cipher.NewGCM(block)
	if err != nil {
		panic(err.Error())
	}

	ciphertext = aesgcm.Seal(nil, nonce, plaintext, nil)
	// fmt.Printf("Ciphertext: %x\n", ciphertext)
	// fmt.Printf("Nonce: %x\n", nonce)

	return
}

// AesGcmDecrypt takes an decryption key, a ciphertext and the corresponding nonce and decrypts it with AES256 in GCM mode. Returns the plaintext string.
func AesGcmDecrypt(key, ciphertext, nonce []byte) ([]byte, error) {
	block, err := aes.NewCipher(key)
	if err != nil {
		return nil, err

	}

	aesgcm, err := cipher.NewGCM(block)
	if err != nil {
		return nil, err
	}

	plaintextBytes, err := aesgcm.Open(nil, nonce, ciphertext, nil)
	if err != nil {
		return nil, err
	}

	// plaintext = string(plaintextBytes)
	// fmt.Printf("%s\n", plaintext)

	return plaintextBytes, nil
}

// AesGcmEncrypt takes an encryption key and a plaintext string and encrypts it with AES256 in GCM mode, which provides authenticated encryption. Returns the ciphertext and the used nonce.
func chacha20poly1305Encrypt(key []byte, plaintext []byte) (ciphertext, nonce []byte) {

	// Never use more than 2^32 random nonces with a given key because of the risk of a repeat.
	nonce = make([]byte, 12)
	if _, err := io.ReadFull(rand.Reader, nonce); err != nil {
		panic(err.Error())
	}

	cipher, err := chacha20poly1305.New(key)
	if err != nil {
		panic(err.Error())
	}

	ciphertext = cipher.Seal(nil, nonce, plaintext, nil)
	return
}

// AesGcmDecrypt takes an decryption key, a ciphertext and the corresponding nonce and decrypts it with AES256 in GCM mode. Returns the plaintext string.
func chacha20poly1305Decrypt(key, ciphertext, nonce []byte) ([]byte, error) {

	cipher, err := chacha20poly1305.New(key)
	if err != nil {
		return nil, err
	}

	plaintextBytes, err := cipher.Open(nil, nonce, ciphertext, nil)
	if err != nil {
		return nil, err
	}
	return plaintextBytes, nil
}

func callTarget(client *Proxy, request *Request) {
	serverAddr := request.address + ":" + strconv.Itoa(int(request.dstPort))
	serverAddress, err := net.ResolveTCPAddr("tcp", serverAddr)
	if err != nil {
		log.Println("[ResolveTCPAddr err]", err)
		return
	}
	targetServer, err := net.DialTCP("tcp", nil, serverAddress)
	if err != nil {
		log.Println("[DialTCP err]", err)
		return
	}

	log.Println("send to", request.address, ":", request.dstPort)

	go netCopyToProxy(client, targetServer)
	go netCopyFromProxy(targetServer, client)

}

func handlClientRequest(trueClient *net.TCPConn, encryptType string, k []byte) {

	var client *Proxy
	p := Proxy{encryptType, k, trueClient}
	client = &p
	message, err := decodeNegotiationRequest(client)
	if err != nil {
		log.Println("[decodeNegotiationRequest err]", err)
		return
	}

	NegotiationResponse := new(NegotiationResponse)
	NegotiationResponse.Ver = message.Ver
	NegotiationResponse.Method = 0
	err = sendNegotiationResponse(client, NegotiationResponse)
	if err != nil {
		log.Println("[sendNegotiationResponse err]", err)
		return
	}

	request, err := decodeRequest(client)

	if err != nil {
		log.Println("[decodeRequest err]", err)
		return
	}

	err = sendResponse(client)
	if err != nil {
		log.Println("[sendResponse err]", err)
		return
	}

	if request.Atyp == typeDomain {
		addr, err := net.ResolveIPAddr("ip", request.address)
		if err != nil {
			err = errors.New("NOT a socks5 request")
			return
		}
		request.address = addr.String()
		callTarget(client, request)
	} else if request.Atyp == typeIPv6 || request.Atyp == typeIPv4 {
		callTarget(client, request)
	} else {
		log.Println("callTarget error, unknow type")
	}

}

func main() {
	var password, encryptType string
	if len(os.Args) < 2 {
		log.Println("you should iput port number like that xx.go :xxx")
		return
	}

	listenAddr := "127.0.0.1" + os.Args[1]

	fmt.Println(listenAddr)

	fmt.Println("Please enter password which has 8 characters:")

	fmt.Scanln(&password)

	fmt.Println("aes-gcm press 1; chacha20poly1305 press 2; direct :other number")

	fmt.Scanln(&encryptType)

	fmt.Println(password, "        ", encryptType)
	k := pbkdf2.Key([]byte(password), []byte("salt"), 1, 32, sha256.New)
	fmt.Println(k)

	listenAddress, err := net.ResolveTCPAddr("tcp", listenAddr)
	if err != nil {
		log.Println("ResolveTCPAddr Error]", err)
		return
	}

	listener, err := net.ListenTCP("tcp", listenAddress)
	if err != nil {
		log.Println("ListenTCP Error]", err)
		return
	}

	for {
		client, err := listener.AcceptTCP()

		if err != nil {
			log.Println("AcceptTCP Error]", err)
			return
		}
		go handlClientRequest(client, encryptType, k)
	}
}
