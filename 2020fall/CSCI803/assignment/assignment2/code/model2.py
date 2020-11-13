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

def findShortestQueue(selectingCustomer, serversList): # 找寻最短等待队列的窗口
    index = 0
    counter = 0
    shortestQueue = 99999999
    for server in serversList:

        if len(server.queue) == 0:
            return server
        else:
            waitingCounter = 0
            for waitingQueue in server.queue:
                if waitingQueue.arrivingtime < selectingCustomer.arrivingtime and selectingCustomer.arrivingtime < waitingQueue.startingtime:
                    waitingCounter += 1
            if waitingCounter < shortestQueue:
                shortestQueue = waitingCounter
                index = counter
        counter += 1
    return serversList[index]

def multipleQueueAnalysis():
    maxWaitingtime = 0
    for customer in customerList:
        anyFreeServer = False
        for server in serversList:
            if server.finishingtime <= customer.arrivingtime:
                server.finishingtime = customer.arrivingtime + customer.duration
                server.servingtime += customer.duration
                server.served.append(customer.customerId)
                customer.startingtime = customer.arrivingtime
                anyFreeServer = True
                break

        if anyFreeServer == False:
            server = findShortestQueue(customer, serversList)
            customer.startingtime = server.finishingtime
            server.finishingtime += customer.duration
            server.served.append(customer.customerId)
            server.servingtime += customer.duration
            server.queue.append(customer)
            if customer.waitDuration() > maxWaitingtime:
                maxWaitingtime = round(customer.waitDuration(), 3)
        else:
            anyFreeServer = False
    return maxWaitingtime, serversList

def mutipleoutputInfo(customerList, serversList):
    maxTime,serversList = multipleQueueAnalysis()
    lastCustomerDuration = []
    servedAmount = 0
    for server in serversList:
        servedAmount += len(server.served)
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
        print("\tserver %d:" % counter_print, round(max(lastCustomerDuration) - server.servingtime, 3), " s")
        counter_print += 1

if __name__ == '__main__':
    customers = readFile()[0]
    serversNum = readFile()[1]
    customerList = createCustomerList(customers)
    serversList = createServerList(serversNum)
    print()
    print("=========================Multiple Queue=============================")
    mutipleoutputInfo(customerList, serversList)