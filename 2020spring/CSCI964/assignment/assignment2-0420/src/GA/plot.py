import matplotlib.pyplot as plt
import platform

if __name__ == "__main__":
    # re_result = re.compile(r'^(best path cost：\s*)(\d+)(\.\d+)?$')
    # with open('tsp100', 'r') as f:
    #     lines  = f.readlines()
    #     m = re_result.match(txt).groups()
    #     print(m)
    datas1 = datas2 = datas3 = []
    with open("100out.txt") as f:
        datas1 = list(map(lambda x: float(x.strip()), f.readlines()))
    with open("200out.txt") as f:
        datas2 = list(map(lambda x: float(x.strip()), f.readlines()))
    with open("500out.txt") as f:
        datas3 = list(map(lambda x: float(x.strip()), f.readlines()))
    fig = plt.figure()
    ax1 = fig.add_subplot(111)
    ax1.plot(range(len(datas1)), [data for data in datas1],
             color="b",
             label='100citys')
    ax1.plot(range(len(datas2)), [data for data in datas2],
             color="r",
             label='200citys')
    ax1.plot(range(len(datas3)), [data for data in datas3],
             color="g",
             label='500citys')
    plt.text(0, 0, "dfs")
    ax1.set_title("GA algorithm training")
    ax1.set_xlabel("epoch")
    ax1.set_ylabel("The total travel cost")
    fig.legend(loc="upper right")
    if platform.system() == "Linux":
        plt.savefig("./fig")
        plt.show()

    else:
        plt.show()
