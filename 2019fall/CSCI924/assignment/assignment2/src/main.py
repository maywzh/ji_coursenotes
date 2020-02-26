# python 3.7.4
# Author: 梅王智汇 Wangzhihui Mei
# CCNU Number: 2019124044
# UOW Number: 6603385
import string
import re
from collections import deque


def getPos(str):
    g = re.findall('[0-9]+', str)
    return int(g[0]), int(g[1])


def readDB(filename):
    maxx = 0
    maxy = 0
    canvisits = []
    start = []
    end = []
    with open(filename) as f:
        lines = f.readlines()
        for line in lines:
            line = line.replace("\n", "").replace("\r\n",
                                                  "").strip().replace(' ', '')
            ifMap = re.search('^s\([0-9]+,[0-9]+\)\.$', line)
            ifGoal = re.search('^goalState\([0-9]+,[0-9]+\)\.$', line)
            ifStart = re.search('^startState\([0-9]+,[0-9]+\)\.$', line)
            if ifMap:
                maxx = maxx if maxx > getPos(line)[0] else getPos(line)[0]
                maxy = maxy if maxy > getPos(line)[1] else getPos(line)[1]
                canvisits.append(getPos(line))
            elif ifStart:
                start = getPos(line)
            elif ifGoal:
                end = getPos(line)
    return canvisits, start, end, maxx, maxy


def findPath(maze, start, end, r, c):
    # four direction vector
    ds = [[0, 1], [0, -1], [1, 0], [-1, 0]]
    # value map filled with [infv, init_dir]
    value = [[[r * c, -1] for j in range(c + 2)] for i in range(r + 2)]
    queue = deque()
    queue.append([start[1], start[0]])
    # start from the start point
    value[start[1]][start[0]][0] = 0
    value[start[1]][start[0]][1] = 4
    maze[start[1]][start[0]] = -1  # Ever visit the node mark as -1
    while (queue):
        curpos = queue.popleft()  # queue pop the node
        i = curpos[0]
        j = curpos[1]
        maze[i][j] = -1  # Ever visit the node mark as -1
        # iterate 4 directions
        for k in range(4):
            # If the node can be visit and not ever visited
            nexti = i + ds[k][0]
            nextj = j + ds[k][1]
            if maze[nexti][nextj] == 0:
                queue.append([nexti, nextj])
                if value[nexti][nextj][0] > value[i][j][0] + 1:
                    value[nexti][nextj][0] = value[i][j][0] + 1
                    value[nexti][nextj][1] = k
    # Out put the outcome
    if maze[end[1]][end[0]] != -1:
        print("no solution")
        return
    else:
        print("shortest path: %d" % (value[end[1]][end[0]][0] + 1))
        i = end[1]
        j = end[0]
        path = [(j, i)]
        while (value[i][j][1] != 4):
            dsidx = value[i][j][1]
            i -= ds[dsidx][0]
            j -= ds[dsidx][1]
            path.append((j, i))
        while (len(path) > 0):
            print(path.pop())


if __name__ == "__main__":
    canvisits, start, end, maxj, maxi = readDB("./DB.pl")
    # Generate the map
    roboMap = [[1 for j in range(maxj + 2)] for i in range(maxi + 2)]
    for canvisit in canvisits:
        roboMap[canvisit[1]][canvisit[0]] = 0
    findPath(roboMap, start, end, maxi, maxj)
