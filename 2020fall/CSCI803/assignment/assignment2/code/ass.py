class customer():
    def __init__(self, arrivalTime, serveTime, customerId):
        self.arrivalTime = float(arrivalTime)
        self.serveTime = float(serveTime)
        self.inTurnTime = 0
        self.customerId = customerId

    def waitserveTime(self): # how long a cunstomer waiting
        if self.inTurnTime > self.arrivalTime:
            return self.inTurnTime - self.arrivalTime
        else:
            return 0


class server():
    def __init__(self, sid):
        self.servingtime = 0
        self.serverId = sid
        self.finishingtime = 0
        self.served = []
        self.queue = []

    def servedNum(self):
        # the number of customers that be served
        return len(self.served)

    def finish_time(self):
        # the serving time that used
        return self.finishingtime

def readFile(filepath):
    customers = []
    with open(filepath) as f:
        n_servers = int(f.readline().strip())  # the first line is number of servers
        for line in f.readlines(): # the rest are the arriving time and 
            customer = dict()
            eachLine = line.strip('\n').split(sep=' ')
            customer[eachLine[0]] = eachLine[1]
            customers.append(customer)
    return customers, n_servers


def createCustomerList(customers):
    customerList = []
    counter = 0
    for eachCustomer in customers:
        oneMoreCustomer = customer(list(eachCustomer.keys())[0], list(eachCustomer.values())[0], counter)
        counter += 1
        customerList.append(oneMoreCustomer)
    return customerList


def createServerList(n_servers):
    serversList = []
    for i in range(n_servers):
        serversList.append(server(i))
    return serversList


def serverAvailableFirst(serversList):
    leastWait = serversList[0].finishingtime
    counter = 0
    index = 0
    for server in serversList:
        if server.finishingtime < leastWait:
            leastWait = server.finishingtime
            index = counter

        counter += 1
    return serversList[index]


def findShortestQueue(selectingCustomer, serversList):
    index = 0
    counter = 0
    shortestQueue = 99999999
    for server in serversList:
        if len(server.queue) == 0:
            return server
        else:
            waitingCounter = 0
            for waitingQueue in server.queue:
                if waitingQueue.arrivalTime < selectingCustomer.arrivalTime and selectingCustomer.arrivalTime < waitingQueue.inTurnTime:
                    waitingCounter += 1
            if waitingCounter < shortestQueue:
                shortestQueue = waitingCounter
                index = counter
        counter += 1
    return serversList[index]


def singleQueueSimulation():
    maxWaitingtime = 0
    for customer in customerList:
        anyFreeServer = False
        for server in serversList:
            if server.finishingtime <= customer.arrivalTime:
                server.finishingtime = customer.arrivalTime + customer.serveTime
                server.servingtime += customer.serveTime
                server.served.append(customer.customerId)
                customer.inTurnTime = customer.arrivalTime
                anyFreeServer = True
                break

        if anyFreeServer == False:
            server = serverAvailableFirst(serversList)
            customer.inTurnTime = server.finishingtime
            server.finishingtime += customer.serveTime
            server.served.append(customer.customerId)
            server.servingtime += customer.serveTime
            if customer.waitserveTime() > maxWaitingtime:
                maxWaitingtime = round(customer.waitserveTime(), 3)
        else:
            anyFreeServer = False
    return maxWaitingtime, serversList

def multiQueueSimulation():
    maxWaitingtime = 0
    for customer in customerList:
        anyFreeServer = False
        for server in serversList:
            if server.finishingtime <= customer.arrivalTime:
                server.finishingtime = customer.arrivalTime + customer.serveTime
                server.servingtime += customer.serveTime
                server.served.append(customer.customerId)
                customer.inTurnTime = customer.arrivalTime

                anyFreeServer = True
                break

        if anyFreeServer == False:
            server = findShortestQueue(customer, serversList)
            customer.inTurnTime = server.finishingtime
            server.finishingtime += customer.serveTime
            server.served.append(customer.customerId)
            server.servingtime += customer.serveTime
            server.queue.append(customer)

            if customer.waitserveTime() > maxWaitingtime:
                maxWaitingtime = round(customer.waitserveTime(), 3)
        else:
            anyFreeServer = False
    return maxWaitingtime, serversList


def singleoutputInfo(customerList, serversList):
    serversList = singleQueueSimulation()[1]
    lastCustomerserveTime = []
    servedAmount = 0
    for server in serversList:
        # print(server.served)
        servedAmount += len(server.served)
        # print(server.finishingtime)
        lastCustomerserveTime.append(server.finishingtime)
    print()
    print("Number of people served: ", servedAmount)
    print()
    print("Time that the last customer being completely served: ", max(lastCustomerserveTime), " s")
    print()
    servedTimeAmount = 0
    for server in serversList:
        servedTimeAmount += server.servingtime
    print("Average service time: ", round(servedTimeAmount / int(n_servers), 3), " s")
    print()
    waitingCustomerAmount = 0
    for customer in customerList:
        waitingCustomerAmount += customer.waitserveTime()
    print("Average time a customer spends in queue: ", round(waitingCustomerAmount / servedAmount, 3), " s")

    print()
    print("Maximum time a customer spends in queue: ", singleQueueSimulation()[0], " s")
    print()

    givenSecond = int(input("Enter the given second number (0~99999):"))
    if givenSecond < 0 or givenSecond > 99999:
        print("illegal input, the second number is 0~99999!")
    else:
        averageLen = 0
        for customer in customerList:
            if customer.arrivalTime != customer.inTurnTime and customer.arrivalTime > givenSecond - 1 and customer.arrivalTime < givenSecond:
                averageLen += 1
        print("Average length of queue in any given second: ", averageLen)

    print()
    waitingQueue = []
    for customer in customerList:
        if customer.arrivalTime != customer.inTurnTime:
            waitingQueue.append(customer)
    longestQueue = 0
    for customer in waitingQueue:
        QueueLen = 0
        beginMoment = customer.arrivalTime
        endMoment = customer.inTurnTime
        for waitedCustomer in waitingQueue:
            if waitedCustomer.arrivalTime < beginMoment and waitedCustomer.inTurnTime > beginMoment:
                QueueLen += 1
            elif waitedCustomer.arrivalTime >= beginMoment and waitedCustomer.inTurnTime <= endMoment:
                QueueLen += 1
            elif waitedCustomer.arrivalTime > beginMoment and waitedCustomer.arrivalTime < endMoment and waitedCustomer.inTurnTime > endMoment:
                QueueLen += 1
            if QueueLen > longestQueue:
                longestQueue = QueueLen
    print("Maximum Length of queue: ", longestQueue)

    print()
    print("Total idle time for each server:")
    counter_print = 0
    for server in serversList:
        print("\tserver %d:" % counter_print, round(max(lastCustomerserveTime) - server.servingtime, 3), " s")
        counter_print += 1

def mutipleoutputInfo(customerList, serversList):
    serversList = multiQueueSimulation()[1]
    lastCustomerserveTime = []
    servedAmount = 0
    for server in serversList:
        servedAmount += len(server.served)
        lastCustomerserveTime.append(server.finishingtime)
    print()
    print("Number of people served: ", servedAmount)
    print()
    print("Time that the last customer being completely served: ", max(lastCustomerserveTime), " s")
    print()
    servedTimeAmount = 0
    for server in serversList:
        servedTimeAmount += server.servingtime
    print("Average service time: ", round(servedTimeAmount / int(n_servers), 3), " s")
    print()
    waitingCustomerAmount = 0
    for customer in customerList:
        waitingCustomerAmount += customer.waitserveTime()
    print("Average time a customer spends in queue: ", round(waitingCustomerAmount / servedAmount, 3), " s")

    print()
    print("Maximum time a customer spends in queue: ", multiQueueSimulation()[0], " s")
    print()

    givenSecond = int(input("Enter the given second number (0~99999):"))
    if givenSecond < 0 or givenSecond > 99999:
        print("illegal input, the second number is 0~99999!")
    else:
        averageLen = 0
        for customer in customerList:
            if customer.arrivalTime != customer.inTurnTime and customer.arrivalTime > givenSecond - 1 and customer.arrivalTime < givenSecond:
                averageLen += 1
        print("Average length of queue in any given second: ", averageLen)

    print()
    waitingQueue = []
    for customer in customerList:
        if customer.arrivalTime != customer.inTurnTime:
            waitingQueue.append(customer)
    longestQueue = 0
    for customer in waitingQueue:
        QueueLen = 0
        beginMoment = customer.arrivalTime
        endMoment = customer.inTurnTime
        for waitedCustomer in waitingQueue:
            if waitedCustomer.arrivalTime < beginMoment and waitedCustomer.inTurnTime > beginMoment:
                QueueLen += 1
            elif waitedCustomer.arrivalTime >= beginMoment and waitedCustomer.inTurnTime <= endMoment:
                QueueLen += 1
            elif waitedCustomer.arrivalTime > beginMoment and waitedCustomer.arrivalTime < endMoment and waitedCustomer.inTurnTime > endMoment:
                QueueLen += 1
            if QueueLen > longestQueue:
                longestQueue = QueueLen
    print("Maximum Length of queue: ", longestQueue)

    print()
    print("Total idle time for each server:")
    counter_print = 0
    for server in serversList:
        print("\tserver %d:" % counter_print, round(max(lastCustomerserveTime) - server.servingtime, 3), " s")
        counter_print += 1


if __name__ == '__main__':
    customers, n_servers = readFile("./data.txt")
    customerList = createCustomerList(customers)
    serversList = createServerList(n_servers)
    print("=========================Single Queue=============================")
    singleoutputInfo(customerList, serversList)
    print()
    print("=========================Multiple Queue=============================")
    mutipleoutputInfo(customerList, serversList)








