import numpy
sb3 = [0x00, 0x05, 0x03, 0x02, 0x06, 0x01, 0x04, 0x07]
sb5 = [0x00, 0x05, 0x0a, 0x0b, 0x14, 0x11, 0x16, 0x17, 0x09, 0x0c, 0x03, 0x02, 0x0d, 0x08, 0x0f, 0x0e, 0x12, 0x15, 0x18, 0x1b, 0x06, 0x01, 0x04, 0x07, 0x1a, 0x1d, 0x10, 0x13, 0x1e, 0x19, 0x1c, 0x1f]


def dif_table(s3, s5):  # compute each differential table
    dt3 = numpy.zeros((8, 8))
    dt5 = numpy.zeros((32, 32))
    for i in range(8):
        for j in range(8):
            dt3[i ^ j][s3[i] ^ s3[j]] += 1
    for i in range(32):
        for j in range(32):
            dt5[i ^ j][s5[i] ^ s5[j]] += 1

    # convert numpy.float64 to numpy.int
    return dt3.astype(int), dt5.astype(int)


def print_table(map, dimention):
    for i in range(dimention):
        for j in range(dimention):
            print("%d" % map[i][j])
        print("\r\n")

if __name__ == "__main__":
    print(dif_table(sb3, sb5))
