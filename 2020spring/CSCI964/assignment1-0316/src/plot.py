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
    filename1 = "./model1.txt"
    datas = readData(filename1)
    fig = plt.figure("")
    ax1 = fig.add_subplot(111)
    ax1.plot(range(100000), [data[1] for data in datas], color="b", label='AvgError')
    ax1.set_title("HLayer=(5,10,5) LR=0.05")
    ax1.set_xlabel("epoch")
    ax1.set_ylabel("training accuracy")
    ax2 = ax1.twinx()  # this is the important function
    ax2.plot(range(100000), [data[3] for data in datas], color="r", label='Error rate')
    #ax2.xlabel("epoch")
    ax2.set_ylabel("Error rate%")
    fig.legend(loc="upper right")
    plt.show()