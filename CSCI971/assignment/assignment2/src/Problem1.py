def xor_left32bit(a, b):
    return not (~((a >> 32) | (b >> 32)) & 0xffffffff)


if __name__ == "__main__":
    output = [(0x9d1a4f78cb28d863,0x75e5e3ea773ec3e6), (0xe86d2de2e1387ae9,0x1792d21db645c008),
               (0x2d1cfa42c0b1d266, 0xeea6e3ddb2146dd0), (0x4af532671351e2e1, 0x87a40cfa8dd39154)]
               
    for idx, outputpair in enumerate(output, start=1):
        if xor_left32bit(outputpair[0],outputpair[1]):
            print(idx)

