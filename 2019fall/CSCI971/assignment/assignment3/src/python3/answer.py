import sys
import re
import numpy
from Crypto.Cipher import AES


def strxor(a, b):
    """XOR two hex strings like "3eab" and "fef1"

    :Parameters:
      a : hex string
        the first parameter
      b : hex string
        the second parameter
    :Returns:
      hex format of a ^ b.
    """
    return "".join([chr(ord(x) ^ ord(y)) for (x, y) in zip(a[: len(b)], b[: len(a)])])


def BytesXor(b1, b2):
    return [a ^ b for a, b in zip(b1, b2)]


def BytesToHex(bins):
    return ''.join(["%02x" % x for x in bins]).strip()

def hexstr2bytes(hexstring):
    return bytes.fromhex(hexstring)


# |key| = 16byte block-size = 16byte so the |ctblock| = 16byte + block_num * 16byte
def AES_CTR_Decrypt(key, ct, blockSize):
    ctBlocks = [ct[i:i+(blockSize*2)]
                for i in range(0, len(ct), (blockSize * 2))]
    # hexstring 2chars => 1byte
    iv = ctBlocks.pop(0)
    iv_int = int(iv, 16)
    # the first block is IV
    cypherTextBlocksDecoded = list(map(hexstr2bytes, ctBlocks))
    pt = ""
    i = 0
    for c in cypherTextBlocksDecoded:
        ctr = hex(iv_int+i)[2:]
        encIV = AES.new(hexstr2bytes(key), AES.MODE_ECB).encrypt(ctr)
        plaintext = str(BytesXor(encIV, c), encoding="ASCII")
        i = i + 1
        pt = plaintext + pt
    return pt


def AES_CBC_Decrypt(key, ct, blockSize):
    ctBlocks = [ct[i:i+(blockSize*2)]
                for i in range(0, len(ct), (blockSize*2))]
    ctBlocksDecoded = list(
        map(hexstr2bytes, ctBlocks))
    pt = ""
    iter = len(ctBlocksDecoded)
    for c in reversed(ctBlocksDecoded):
        iter = iter - 1
        if(iter > 0):
            cipher = AES.new(hexstr2bytes(key), AES.MODE_ECB).decrypt(c)
            plaintext = strxor(cipher, ctBlocksDecoded[iter - 1])
            pt = plaintext + pt

    paddingAmount = ord(pt[len(pt)-1:])

    return pt[:-paddingAmount]


def run():
    """
    main process
    """
    keys = [
        "140b41b22a29beb4061bda66b6747e14",
        "140b41b22a29beb4061bda66b6747e14",
        "36f18357be4dbd77f050515c73fcf9f2",
        "36f18357be4dbd77f050515c73fcf9f2"
    ]
    cipherTexts = [
        "4ca00ff4c898d61e1edbf1800618fb2828a226d160dad07883d04e008a7897ee2e4b7465d5290d0c0e6c6822236e1daafb94ffe0c5da05d9476be028ad7c1d81",
        "5b68629feb8606f9a6667670b75b38a5b4832d0f26e1ab7da33249de7d4afc48e713ac646ace36e872ad5fb8a512428a6e21364b0c374df45503473c5242a253",
        "69dda8455c7dd4254bf353b773304eec0ec7702330098ce7f7520d1cbbb20fc388d1b0adb5054dbd7370849dbf0b88d393f252e764f1f5f7ad97ef79d59ce29f5f51eeca32eabedd9afa9329",
        "770b80259ec33beb2561358a9f2dc617e46218c0a53cbeca695ae45faa8952aa0e311bde9d4e01726d3184c34451"
    ]
    blockSize = 16  # 16-byte encryption
    #q1 = AES_CBC_Decrypt(keys[0], cipherTexts[0], blockSize)
    #q2 = AES_CBC_Decrypt(keys[1], cipherTexts[1], blockSize)
    q3 = AES_CTR_Decrypt(keys[2], cipherTexts[2], blockSize)
    q4 = AES_CTR_Decrypt(keys[3], cipherTexts[3], blockSize)
    print(q3)
    print(q4)


if __name__ == "__main__":
    run()
