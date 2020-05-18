import matplotlib.pyplot as plt

if __name__ == "__main__":
    datas = []
    data_str_list = ""
    with open("./distance.txt") as f:
        data_str_list = f.readline().strip().split()

    datas = list(map(float, data_str_list))
    plt.ylabel('distance between t-th and (t+1)-th iteration')     
    plt.xlabel('epoch')        #可以忽略，只是用来标注表的信息而已
    plt.title("the distance each epoch")
    plt.plot(datas[244:])
    plt.show()