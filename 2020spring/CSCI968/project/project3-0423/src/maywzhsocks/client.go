package main

import (
	"crypto/aes"
	"crypto/cipher"
	"crypto/rand"
	"encoding/binary"
	"errors"
	"flag"
	"fmt"
	"io"
	"log"
	"net"
	""
	"golang.org/x/crypto/chacha20poly1305"
)

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
func AesGcmDecrypt(key, ciphertext, nonce []byte) (plaintextBytes []byte) {
	block, err := aes.NewCipher(key)
	if err != nil {
		panic(err.Error())
	}

	aesgcm, err := cipher.NewGCM(block)
	if err != nil {
		panic(err.Error())
	}
	plaintextBytes, err = aesgcm.Open(nil, nonce, ciphertext, nil)
	if err != nil {
		panic(err.Error())
	}

	// plaintext = string(plaintextBytes)
	// fmt.Printf("%s\n", plaintext)

	return
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
func chacha20poly1305Decrypt(key, ciphertext, nonce []byte) []byte {

	cipher, err := chacha20poly1305.New(key)
	if err != nil {
		panic(err.Error())
	}

	plaintextBytes, err := cipher.Open(nil, nonce, ciphertext, nil)
	if err != nil {
		panic(err.Error())
	}
	return plaintextBytes
}

func aesGcmEncryptNetCopy(input, output *net.TCPConn, k []byte) (err error) {
	buf := make([]byte, 8192)
	for {
		count, err := input.Read(buf)
		// fmt.Println("写", buf[:count])
		// nonce 12 加密
		ciphertext, nonce := AesGcmEncrypt(k, buf[:count])

		cbuf := make([]byte, 0)
		cbuf = append(cbuf, 'V')
		size := make([]byte, 2)
		binary.BigEndian.PutUint16(size, uint16(len(nonce)+len(ciphertext)))
		cbuf = append(cbuf, size...)
		cbuf = append(cbuf, nonce...)
		cbuf = append(cbuf, ciphertext...)

		if err != nil {
			if err == io.EOF && count > 0 {
				output.Write(cbuf)
			}
			break
		}
		if count > 0 {
			output.Write(cbuf)
		}
	}
	return
}

func aesGcmDecryptNetCopy(input, output *net.TCPConn, k []byte) (err error) {

	for {
		buf := make([]byte, 3)
		_, err := io.ReadFull(input, buf)
		if err != nil && err == io.EOF {
			return err
		}
		if buf[0] != 'V' {
			return errors.New("unpack protocol wrong start")
		}
		length := binary.BigEndian.Uint16(buf[1:3])
		bodyBuf := make([]byte, length)
		_, err = io.ReadFull(input, bodyBuf)
		if err != nil && err == io.EOF {
			return err
		}

		pbuf := AesGcmDecrypt(k, bodyBuf[12:], bodyBuf[:12])
		count := len(pbuf)

		if err != nil {
			if err == io.EOF && count > 0 {
				output.Write(pbuf)
			}
			break
		}
		if count > 0 {
			output.Write(pbuf)
		}
	}
	return
}

func chacha20poly1305EncryptNetCopy(input, output *net.TCPConn, k []byte) (err error) {
	buf := make([]byte, 8192)
	for {
		count, err := input.Read(buf)
		ciphertext, nonce := chacha20poly1305Encrypt(k, buf[:count])

		cbuf := make([]byte, 0)
		cbuf = append(cbuf, 'V')
		size := make([]byte, 2)
		binary.BigEndian.PutUint16(size, uint16(len(nonce)+len(ciphertext)))
		cbuf = append(cbuf, size...)
		cbuf = append(cbuf, nonce...)
		cbuf = append(cbuf, ciphertext...)

		if err != nil {
			if err == io.EOF && count > 0 {
				output.Write(cbuf)
			}
			break
		}
		if count > 0 {
			output.Write(cbuf)
		}
	}
	return
}

func chacha20poly1305DecryptNetCopy(input, output *net.TCPConn, k []byte) (err error) {
	for {
		buf := make([]byte, 3)
		_, err := io.ReadFull(input, buf)
		if err != nil && err == io.EOF {
			return err
		}
		if buf[0] != 'V' {
			return errors.New("unpack protocol wrong start")
		}
		length := binary.BigEndian.Uint16(buf[1:3])
		bodyBuf := make([]byte, length)
		_, err = io.ReadFull(input, bodyBuf)
		if err != nil && err == io.EOF {
			return err
		}

		pbuf := chacha20poly1305Decrypt(k, bodyBuf[12:], bodyBuf[:12])
		count := len(pbuf)

		if err != nil {
			if err == io.EOF && count > 0 {
				output.Write(pbuf)
			}
			break
		}
		if count > 0 {
			output.Write(pbuf)
		}
	}
	return
}

func encryptNetCopy(input, output *net.TCPConn) (err error) {
	buf := make([]byte, 8192)
	for {

		count, err := input.Read(buf)

		cbuf := make([]byte, 0)
		cbuf = append(cbuf, 'V')
		size := make([]byte, 2)
		binary.BigEndian.PutUint16(size, uint16(len(buf[:count])))
		cbuf = append(cbuf, size...)
		cbuf = append(cbuf, buf[:count]...)

		if err != nil {
			if err == io.EOF && count > 0 {
				output.Write(cbuf)
			}
			break
		}
		if count > 0 {
			output.Write(cbuf)
		}
	}
	return
}

func decryptNetCopy(input, output *net.TCPConn) (err error) {
	for {
		buf := make([]byte, 3)
		_, err := io.ReadFull(input, buf)
		if err != nil && err == io.EOF {
			return err
		}
		if buf[0] != 'V' {
			return errors.New("unpack protocol wrong start")
		}
		length := binary.BigEndian.Uint16(buf[1:3])
		bodyBuf := make([]byte, length)
		_, err = io.ReadFull(input, bodyBuf)
		count := len(bodyBuf)
		if err != nil && err == io.EOF {
			return err
		}
		if err != nil {
			if err == io.EOF && count > 0 {
				output.Write(bodyBuf)
			}
			break
		}
		if count > 0 {
			output.Write(bodyBuf)
		}
	}
	return
}
func handleLocalClientRequest(localClient *net.TCPConn, serverAddr, encryptType string, k []byte) {
	serverAddress, err := net.ResolveTCPAddr("tcp", serverAddr)
	if err != nil {
		log.Fatal(err)
	}
	ssServer, err := net.DialTCP("tcp", nil, serverAddress)
	if err != nil {
		log.Fatal(err)
	}
	if encryptType == "1" {

		go aesGcmEncryptNetCopy(localClient, ssServer, k)
		aesGcmDecryptNetCopy(ssServer, localClient, k)
	} else if encryptType == "2" {
		go chacha20poly1305EncryptNetCopy(localClient, ssServer, k)
		chacha20poly1305DecryptNetCopy(ssServer, localClient, k)
	} else {
		go encryptNetCopy(localClient, ssServer)
		decryptNetCopy(ssServer, localClient)
	}

	defer ssServer.Close()
	defer localClient.Close()

}
func main() {
	var listenAddr, serverAddr, password, encryptType string
	flag.StringVar(&listenAddr, "c", "127.0.0.1:8488", "Input listen address(127.0.0.1:8488):")
	flag.StringVar(&serverAddr, "s", "127.0.0.1:8489", "Input server address(127.0.0.1:8489):")

	fmt.Println("Please enter password which has 8 characters:")

	fmt.Scanln(&password)

	fmt.Println("aes-gcm press 1; chacha20poly1305 press 2; direct :other number")

	fmt.Scanln(&encryptType)

	fmt.Println(password, "        ", encryptType)

	//k := pbkdf2.Key([]byte(password), []byte("salt"), 1, 32, sha256.New)
	fmt.Println(k)

	listenAddress, err := net.ResolveTCPAddr("tcp", listenAddr)
	if err != nil {
		log.Fatal(err)
	}

	listener, err := net.ListenTCP("tcp", listenAddress)
	if err != nil {
		log.Fatal(err)
	}

	for {
		localClient, err := listener.AcceptTCP()
		fmt.Println("comming client:", localClient.RemoteAddr())
		if err != nil {
			log.Fatal(err)
		}
		go handleLocalClientRequest(localClient, serverAddr, encryptType, k)
	}

}
