from Crypto.Cipher import ChaCha20_Poly1305
from Crypto.Cipher import AES
from Crypto.Util.Padding import unpad,pad
from Crypto.Random import get_random_bytes
from Crypto.PublicKey import DSA
from Crypto.Signature import DSS
from Crypto.Hash import SHA256
import bcrypt

class AES_GCM():
    def __init__(self,key,nonce):
        self.head=b'127.0.0.1'
        self.key=key
        self.nonce=nonce

    def decrypt(self, ciphertext):
        try:
            cipher = AES.new(self.key, AES.MODE_GCM, self.nonce)
            cipher.update(self.head)
            plaintext = cipher.decrypt(ciphertext)
            return plaintext
        except (ValueError, KeyError) as e:
            print("Incorrect decryption",e)

    def encrypt(self, data):
        try:
            cipher = AES.new(self.key, AES.MODE_GCM,self.nonce)
            cipher.update(self.head)
            ciphertext= cipher.encrypt(data)
            return ciphertext
        except (ValueError, KeyError):
            print("Incorrect encryption")


class ChaCha20_Poly1305():
    def __init__(self,key,nonce):
        self.head=b'127.0.0.1'
        self.key = key
        self.nonce = nonce

    def decrypt(self, ciphertext):
        try:
            cipher = ChaCha20_Poly1305.new(self.key, self.nonce)
            cipher.update(self.head)
            plaintext = cipher.decrypt_and_verify(ciphertext[:12], ciphertext[12:])
            return plaintext
        except (ValueError, KeyError):
            print("Incorrect decryption")

    def encrypt(self, data):
        try:
            cipher = ChaCha20_Poly1305.new(self.key, self.nonce)
            cipher.update(self.head)
            ciphertext, tag = cipher.encrypt_and_digest(data)
            return tag+ciphertext
        except (ValueError, KeyError):
            print("Incorrect encryption")

class AES_CBC():
    def __init__(self,key,iv):
        self.iv=iv
        self.key=key

    def decrypt(self, ciphertext):
        try:
            cipher = AES.new(self.key, AES.MODE_CBC, self.iv)
            plaintext = unpad(cipher.decrypt(ciphertext), AES.block_size)
            return plaintext
        except (ValueError, KeyError):
            print("Incorrect decryption")

    def encrypt(self, data):
        try:
            cipher = AES.new(self.key, AES.MODE_CBC, self.iv)
            ciphertext = cipher.encrypt(pad(data, AES.block_size))
            return ciphertext
        except (ValueError, KeyError):
            print("Incorrect encryption")

class AES_CTR():
    def __init__(self,key,nonce):
        self.nonce=nonce
        self.key=key

    def decrypt(self, ciphertext):
        try:
            cipher = AES.new(self.key, AES.MODE_CTR, self.nonce)
            plaintext = cipher.decrypt(ciphertext)
            return plaintext
        except (ValueError, KeyError):
            print("Incorrect decryption")

    def encrypt(self, data):
        try:
            cipher = AES.new(self.key, AES.MODE_CTR, self.nonce)
            ciphertext = cipher.encrypt(data)
            return ciphertext
        except (ValueError, KeyError):
            print("Incorrect encryption")