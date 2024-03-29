import numpy
sb3 = [0x00, 0x05, 0x03, 0x02, 0x06, 0x01, 0x04, 0x07]
sb5 = [0x00, 0x05, 0x0a, 0x0b, 0x14, 0x11, 0x16, 0x17, 0x09, 0x0c, 0x03, 0x02, 0x0d, 0x08, 0x0f, 0x0e, 0x12, 0x15, 0x18, 0x1b, 0x06, 0x01, 0x04, 0x07, 0x1a, 0x1d, 0x10, 0x13, 0x1e, 0x19, 0x1c, 0x1f]


def dif_table(s, bitnum):  # compute each differential table
    d = 0x1 << bitnum
    dt = numpy.zeros((d, d))
    for i in range(d):
        for j in range(d):
            dt[i ^ j][s[i] ^ s[j]] += 1
    # convert numpy.float64 to numpy.int
    return dt.astype(int)


def print_table(map, bitnum):
    d = 0x1 << bitnum
    for i in range(d):
        for j in range(d):
            if j==d-1:
                print("%d " % map[i][j], end="")
            else:
                print("%d, " % map[i][j], end="")
        print('')

if __name__ == "__main__":
    print_table(dif_table(sb3, 3), 3)
    print_table(dif_table(sb5, 5), 5)
