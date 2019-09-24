from functools import reduce


def ByteToHex(bins):
    return ''.join(["%02x" % x for x in bins]).strip()


def BytesXor(b1, b2):
    return [a ^ b for a, b in zip(b1, b2)]


m1 = "attack at dawn".encode('ascii')
m2 = "attack at dusk".encode('ascii')
c1 = bytes.fromhex("6c73d5240a948c86981bc294814d")
c2 = reduce(BytesXor, [m1, m2, c1])
print(ByteToHex(c2))
