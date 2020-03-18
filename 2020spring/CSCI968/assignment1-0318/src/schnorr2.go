package main

import (
	"crypto/elliptic"
	"crypto/rand"
	"crypto/sha256"
	"fmt"
	"io"
	"math/big"
)

type PublicKey struct {
	elliptic.Curve
	X, Y *big.Int
}

type PrivateKey struct {
	PublicKey
	D *big.Int
}

var one = new(big.Int).SetInt64(1)

func randFieldElement(c elliptic.Curve, rand io.Reader) (k *big.Int, err error) {
	params := c.Params()
	b := make([]byte, params.BitSize/8+8)
	_, err = io.ReadFull(rand, b)
	if err != nil {
		return
	}

	k = new(big.Int).SetBytes(b)
	n := new(big.Int).Sub(params.N, one)
	k.Mod(k, n)
	k.Add(k, one)
	return
}

func GenerateKey(c elliptic.Curve, rand io.Reader) (*PrivateKey, error) {
	k, err := randFieldElement(c, rand)
	if err != nil {
		return nil, err
	}
	priv := new(PrivateKey)
	priv.PublicKey.Curve = c
	priv.D = k
	priv.PublicKey.X, priv.PublicKey.Y = c.ScalarBaseMult(k.Bytes())
	return priv, nil
}

func hashIt(x, y *big.Int, message string) *big.Int {
	tempHash := sha256.Sum256([]byte(message))
	hash := tempHash[:]
	tempInput := make([]byte, len(hash))
	tempInput = append(tempInput, hash...)
	tempInput = append(tempInput, x.Bytes()...)
	tempInput = append(tempInput, y.Bytes()...)
	temp := sha256.Sum256(tempInput)
	cTemp := temp[:]
	return new(big.Int).SetBytes(cTemp)
}

func Sign(rand io.Reader, priv *PrivateKey, message string) (msg string, x, y, a *big.Int, err error) {

	var k *big.Int

	for {

		k, err = randFieldElement(priv.PublicKey.Curve, rand)
		if err == nil {
			break
		}
	}

	x, y = priv.Curve.ScalarBaseMult(k.Bytes())
	cV := hashIt(x, y, message)
	temp := new(big.Int).Mul(priv.D, cV)
	a = new(big.Int).Add(k, temp)
	msg = message
	return
}

func Verify(pub *PublicKey, message string, x, y, a *big.Int) bool {

	cV := hashIt(x, y, message)
	x1, y1 := pub.Curve.ScalarMult(pub.X, pub.Y, cV.Bytes())
	x, y = pub.Curve.Add(x1, y1, x, y)
	x2, y2 := pub.Curve.ScalarBaseMult(a.Bytes())
	return (x.Cmp(x2) == 0 && y.Cmp(y2) == 0)
}

func Sign_opt(rand io.Reader, priv *PrivateKey, message string) (msg string, cv, a *big.Int, err error) {

	var k *big.Int
	for {

		k, err = randFieldElement(priv.PublicKey.Curve, rand)
		if err == nil {
			break
		}
	}

	x, y := priv.Curve.ScalarBaseMult(k.Bytes())
	cv = hashIt(x, y, message)
	temp := new(big.Int).Mul(priv.D, cv)
	a = new(big.Int).Add(k, temp)
	msg = message
	return
}

func Verify_opt(pub *PublicKey, message string, cV, a *big.Int) bool {
	x, y := pub.Curve.ScalarBaseMult(a.Bytes())
	x1, y1 := pub.Curve.ScalarMult(pub.X, pub.Y, cV.Bytes())
	negY1 := new(big.Int).Neg(y1)
	x2, y2 := pub.Curve.Add(x, y, x1, negY1)
	x3, y3 := pub.Curve.Add(x2, y2, x1, y1)
	return (x3.Cmp(x) == 0 && y3.Cmp(y) == 0)
}

func main() {
	privateKey, err := GenerateKey(elliptic.P256(), rand.Reader)
	if err != nil {
		panic(err)
	}
	msg := "CSCI468/968AdvancedNetworkSecurity,Spring2020"

	message, x, y, a, err := Sign(rand.Reader, privateKey, msg)
	if err != nil {
		panic(err)
	}

	fmt.Println("message:", message)
	fmt.Println("signature: u_t:", x, y)
	fmt.Println("signature: a_z:", a)

	valid := Verify(&privateKey.PublicKey, message, x, y, a)
	fmt.Println("signature verified:", valid)

	fmt.Println(" optimized versions:")

	message1, cv1, a1, err1 := Sign_opt(rand.Reader, privateKey, msg)
	if err1 != nil {
		panic(err)
	}

	fmt.Println("message:", message1)
	fmt.Println("signature: c:", cv1)
	fmt.Println("signature: a_z:", a1)

	valid1 := Verify_opt(&privateKey.PublicKey, message1, cv1, a1)
	fmt.Println("signature verified:", valid1)
}
