'''
Author: maywzh
Date: 2020-11-12 16:02:55
'''

max_queuelength = 0
sum_queuelength = 0
class customer():
    def __init__(self, cid, arrivalTime, serviceTime):
        self.arrivalTime = arrivalTime
        self.serviceTime = serviceTime
        self.myTurnTime = 0
        self.id = cid
        self.server = -1

    def getWaitTime(self):
        if self.myTurnTime > self.arrivalTime:
            return self.myTurnTime - self.arrivalTime
        else:
            return .0

    def getTotalTime(self):
        if self.myTurnTime > self.arrivalTime:
            return self.myTurnTime - self.arrivalTime + self.serviceTime
        else:
            return self.serviceTime

class server():
    def __init__(self, sid):
        self.leftTime = 0
        self.idleTime = 0
        self.pendingQueue = []
        self.doneQueue = []
        self.id = sid


# 读取输入文件
def readFile(filepath):
    customers, servers = [], []
    with open(filepath) as f:
        n_servers = int(f.readline().strip())  # the first line is number of servers
        for i, line in enumerate(f.readlines()):  # the rest are the arriving time and
            customerarrivalTime, customerserviceTime = line.strip('\n').split(sep=' ')
            newCustomer = customer(i, float(customerarrivalTime), float(customerserviceTime))
            customers.append(newCustomer)
        for i in range(n_servers):
            servers.append(server(i))
    return servers, sorted(customers, key=lambda customer: customer.arrivalTime)


# 按最短等待时间分派服务器，即第一种方式-叫号系统
def dispatchServerByTime(servers):
    minLeftTime = servers[0].leftTime
    rtnServerIdx = 0
    for i, v in enumerate(servers):
        if v.leftTime < minLeftTime:
            minLeftTime = v.leftTime
            rtnServerIdx = i
    return rtnServerIdx


# 按最短队列长度分派服务器，即第二种方式-多队列
def dispatchServerByQueue(servers):
    minQueueLength = len(servers[0].pendingQueue)
    rtnServerIdx = 0
    for i, v in enumerate(servers):
        if len(v.pendingQueue) < minQueueLength:
            minQueueLength = len(v.pendingQueue)
            rtnServerIdx = i
    return rtnServerIdx


# 获取最后关闭的服务器
def getLastClosedServer(servers):
    maxLeftTime = servers[0].leftTime
    rtnServerIdx = 0
    for i, v in enumerate(servers):
        if v.leftTime > maxLeftTime:
            rtnServerIdx = i
    return rtnServerIdx


# 更新服务器集群状态
def updateServerState(servers, lastTime, currentTime):
    passedTime = currentTime - lastTime
    tmp_sumqueue = 0
    sum_queuelength = 0
    global max_queuelength 
    for s in servers:
        ## 更新队列
        while len(s.pendingQueue) > 0:
            workingCustomer = s.pendingQueue[0]
            if workingCustomer.myTurnTime + workingCustomer.serviceTime < currentTime:
                s.doneQueue.append(s.pendingQueue.pop(0))
            else:
                break
        if max_queuelength<len(s.pendingQueue):
            max_queuelength = len(s.pendingQueue)
        ## 更新服务器剩余服务时间
        if s.leftTime - passedTime > 0:
            s.leftTime -= passedTime
        else:
            s.idleTime += passedTime - s.leftTime
            s.leftTime = 0
            if len(s.pendingQueue) > 0:
                s.doneQueue.append(s.pendingQueue.pop(0))
        
    #print('now', currentTime)
    #print(list(map(lambda ss: (ss.leftTime, len(ss.pendingQueue)), servers)))

# 第一种方式模拟
def singleQueueSimulation(customers, servers):
    lastTime, currentTime = .0, .0
    total_queuetime = .0
    max_queuetime = .0
    max_queuelength = 0
    for c in customers:
        lastTime, currentTime = currentTime, c.arrivalTime
        updateServerState(servers, lastTime, currentTime)

        dispatchedServerIdx = dispatchServerByTime(servers)
        dispatchedServer = servers[dispatchedServerIdx]
        c.myTurnTime = currentTime + dispatchedServer.leftTime
        dispatchedServer.leftTime += c.serviceTime
        dispatchedServer.pendingQueue.append(c)
        c.server = dispatchedServerIdx

    return currentTime + servers[getLastClosedServer(servers)].leftTime


# 第二种方式模拟
def multiQueueSimulation(customers, servers):
    lastTime, currentTime = .0, .0
    total_servicetime = .0
    total_queuetime = .0
    max_queuetime = .0
    max_queuelength = 0
    for c in customers:
        lastTime, currentTime = currentTime, c.arrivalTime
        updateServerState(servers, lastTime, currentTime)

        total_servicetime += c.serviceTime
        dispatchedServerIdx = dispatchServerByQueue(servers)
        dispatchedServer = servers[dispatchedServerIdx]
        c.myTurnTime = currentTime + dispatchedServer.leftTime
        dispatchedServer.leftTime += c.serviceTime
        dispatchedServer.pendingQueue.append(c)
        c.server = dispatchedServerIdx
    return currentTime + servers[getLastClosedServer(servers)].leftTime


if __name__ == '__main__':
    print('Enter the given second number: ')
    chktime = float(input().strip())


    print('>>>> strategy 1 <<<<')
    servers, customers = readFile('./ass2_sample_input')
    total_simulationtime = singleQueueSimulation(customers, servers)
    total_servicetime = sum(map(lambda c: c.serviceTime, customers))
    total_queuetime = sum(map(lambda c: c.getWaitTime(), customers))
    max_queuetime = max(map(lambda c: c.getWaitTime(), customers))
    total_idletime = sum(map(lambda s: s.idleTime, servers))
    # for c in customers:
        
    print('Number of people served: ', len(customers))
    print('Total simulation time: ', total_simulationtime)
    print('Average service time: ', total_servicetime / len(customers))
    print('Average queue time: ', total_queuetime / len(customers) )
    print('Maximum queue time: ', max_queuetime)
    print('Maximum queue length: ', max_queuelength)
    print('Total idle time: ', total_idletime)




    print('>>>> strategy 2 <<<<')
    servers, customers = readFile('./ass2_sample_input')
    total_simulationtime = multiQueueSimulation(customers, servers)
    total_servicetime = sum(map(lambda c: c.serviceTime, customers))
    total_queuetime = sum(map(lambda c: c.getWaitTime(), customers))
    max_queuetime = max(map(lambda c: c.getWaitTime(), customers))
    total_idletime = sum(map(lambda s: s.idleTime, servers))
    print('Number of people served: ', len(customers))
    print('Total simulation time: ', total_simulationtime)
    print('Average service time: ', total_servicetime / len(customers))
    print('Average queue time: ', total_queuetime / len(customers))
    print('Maximum queue time: ', max_queuetime)
    print('Maximum queue length: ', max_queuelength)
    print('Total idle time: ', total_idletime)
