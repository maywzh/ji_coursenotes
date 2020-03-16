import matplotlib.pyplot as plt


def readData(filename):
    y = []
    x = []
    datas = []
    with open(filename) as f:
        lines = f.readlines()
    for line in lines:
        # datas = list(map(float, line.split(' ').strip(' ').strip('\n')[:]))
        datas.append(list(map(float, line.split())))
    return datas


if __name__ == "__main__":
    filename1 = "./trainfile.txt"
    datas = readData(filename1)
    fig = plt.figure()
    ax1 = fig.add_subplot(111)
    ax1.plot(range(len(datas)), [data[1] for data in datas], color="b", label='AvgError')
    title = ""
    with open("param.txt") as paraf:
        title = paraf.readlines()[0]
    # with open("testresult.txt") as testf:
    #     title = title + "\n" + testf.readline()
    plt.text(0, 0, "dfs")
    ax1.set_title(title)
    ax1.set_xlabel("epoch")
    ax1.set_ylabel("training accuracy")
    ax2 = ax1.twinx()  # this is the important function
    ax2.plot(range(len(datas)), [data[3] for data in datas], color="r", label='Error rate')
    #ax2.xlabel("epoch")
    ax2.set_ylabel("Error rate%")
    fig.legend(loc="upper left")
    plt.show()