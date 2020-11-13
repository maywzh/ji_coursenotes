class customer():
    def __init__(self, arrivingtime, duration, customerId):
        self.arrivingtime = float(arrivingtime) # 到达时间
        self.duration = float(duration) # 占用窗口的时间
        self.startingtime = 0 # 开始占用窗口的时刻
        self.customerId = customerId # 用户ID

    def waitDuration(self): # 用户等待时间
        if self.startingtime > self.arrivingtime:
            return self.startingtime - self.arrivingtime
        else:
            return 0


class server():
    def __init__(self, counter):
        self.servingtime = 0
        self.serverNum = counter
        self.finishingtime = 0
        self.served = []
        self.queue = []

    def servedNum(self):
        # the number of customers that be served
        # 这个窗口接待的顾客
        return len(self.served)

    def finish_time(self):
        # the serving time that used
        return self.finishingtime

def readFile():
    customers = []
    with open('ass2_sample_input') as f:
        serversNum = f.readline()  # the first line is number of servers
        for line in f.readlines(): # the rest are the arriving time and 
            customer = dict()
            eachLine = line.strip('\n').split(sep=' ')
            customer[eachLine[0]] = eachLine[1]
            customers.append(customer) # 顾客数组。每个数组元素是一个字典，字典的key是到达时间，value是服务时间
    return customers, serversNum


def createCustomerList(customers): #生成顾客列表
    customerList = []
    counter = 0
    for eachCustomer in customers:
        oneMoreCustomer = customer(list(eachCustomer.keys())[0], list(eachCustomer.values())[0], counter)
        # print(oneMoreCustomer.duration)
        counter += 1
        customerList.append(oneMoreCustomer)
    return customerList


def createServerList(serversNum): # 生成窗口list
    serversList = []
    counter_1 = 0
    for i in range(int(serversNum)):
        oneMoreServer = server(counter_1)
        counter_1 += 1
        serversList.append(oneMoreServer)
    return serversList


def serverAvailableFirst(serversList): # 找寻等待时间最短的窗口
    shortestWait = serversList[0].finishingtime
    counter = 0
    index = 0
    for server in serversList:
        if server.finishingtime < shortestWait:
            shortestWait = server.finishingtime
            index = counter
        counter += 1
    return serversList[index]
def singleQueueAnalysis():
    maxWaitingtime = 0
    for customer in customerList: # 遍历顾客列表
        anyFreeServer = False # 先将该顾客到达时，是否有空闲窗口的标志设置为false
        for server in serversList: # 遍历窗口列表
            if server.finishingtime <= customer.arrivingtime:  # 如果存在窗口完成服务的时刻比用户列表到达的时刻早
                customer.startingtime = customer.arrivingtime # 客户开始服务的时刻设置成为客户到达窗口的时刻
                server.finishingtime = customer.startingtime + customer.duration # 将该窗口完成服务的时刻赋值为该客户完成该次服务的时刻
                server.servingtime += customer.duration # 将窗口的总服务时间加上该客户的服务时间
                server.served.append(customer.customerId) # 将客户的ID添加到该窗口服务过的客户列表中
                anyFreeServer = True # 将空闲窗口的标志设置为true
                break
        if anyFreeServer == False: # 如果该顾客到达时没有空闲窗口
            server = serverAvailableFirst(serversList) # 找寻等待时间最短的窗口
            customer.startingtime = server.finishingtime # 该顾客的开始服务时刻设置为将找到的等待时间最短的窗口的完成时刻
            server.finishingtime =customer.startingtime + customer.duration # 将找到的等待时间最短的窗口的完成时刻加上该顾客的服务时间
            server.served.append(customer.customerId) # 将客户的ID添加到该窗口服务过的客户列表中
            server.servingtime += customer.duration # 将窗口的总服务时间加上该客户的服务时间
            if customer.waitDuration() > maxWaitingtime: # 顾客最大等待时间
                maxWaitingtime = round(customer.waitDuration(), 3)
        else:
            anyFreeServer = False
    return maxWaitingtime, serversList


def singleoutputInfo(customerList, serversList):
    maxTime,serversList = singleQueueAnalysis()
    lastCustomerDuration = []
    servedAmount = 0
    for server in serversList:
        # print(server.served)
        servedAmount += len(server.served)
        # print(server.finishingtime)
        lastCustomerDuration.append(server.finishingtime)
    print()
    print("Number of people served: ", servedAmount)
    print()
    print("Time that the last customer being completely served: ", max(lastCustomerDuration), " s")
    print()
    servedTimeAmount = 0
    for server in serversList:
        servedTimeAmount += server.servingtime
    print("Average service time: ", round(servedTimeAmount / int(serversNum), 3), " s")
    print()
    waitingCustomerAmount = 0
    for customer in customerList:
        waitingCustomerAmount += customer.waitDuration()
    print("Average time a customer spends in queue: ", round(waitingCustomerAmount / servedAmount, 3), " s")

    print()
    print("Maximum time a customer spends in queue: ", maxTime, " s")
    print()

    givenSecond = int(input("Enter the given second number (0~99999):"))
    if givenSecond < 0 or givenSecond > 99999:
        print("illegal input, the second number is 0~99999!")
    else:
        averageLen = 0
        for customer in customerList:
            if customer.arrivingtime != customer.startingtime and customer.arrivingtime < givenSecond and customer.startingtime > givenSecond:
                averageLen += 1
        print("Average length of queue in any given second: ", averageLen / int(serversNum))

    print()
    waitingQueue = []
    for customer in customerList:
        if customer.arrivingtime != customer.startingtime:
            waitingQueue.append(customer)
    longestQueue = 0
    for customer in waitingQueue:
        QueueLen = 0
        beginMoment = customer.arrivingtime
        endMoment = customer.startingtime
        for waitedCustomer in waitingQueue:
            if waitedCustomer.arrivingtime < beginMoment and waitedCustomer.startingtime > beginMoment:
                QueueLen += 1
            elif waitedCustomer.arrivingtime >= beginMoment and waitedCustomer.startingtime <= endMoment:
                QueueLen += 1
            elif waitedCustomer.arrivingtime > beginMoment and waitedCustomer.arrivingtime < endMoment and waitedCustomer.startingtime > endMoment:
                QueueLen += 1
            if QueueLen > longestQueue:
                longestQueue = QueueLen
    print("Maximum Length of queue: ", longestQueue)

    print()
    print("Total idle time for each server:")
    counter_print = 0
    for server in serversList:
        # print(lastCustomerDuration)
        # print(server.servingtime)
        print("\tserver %d:" % counter_print, round(max(lastCustomerDuration) - server.servingtime, 3), " s")
        counter_print += 1


if __name__ == '__main__':
    customers = readFile()[0]
    serversNum = readFile()[1]
    customerList = createCustomerList(customers)
    serversList = createServerList(serversNum)
    print("=========================Single Queue=============================")
    singleoutputInfo(customerList, serversList)

