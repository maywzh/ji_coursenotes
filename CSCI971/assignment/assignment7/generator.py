for i in range(2, 13):
    num = 1
    cset = set()
    for j in range(1, 20):
        num *= i
        cset.add(num % 13)
    print(i, cset)
