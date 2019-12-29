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
            line = line.replace("\n", "").replace(
                "\r\n", "").strip().replace(' ', '')
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


if __name__ == "__main__":
    canvisits, start, end, maxj, maxi = readDB("./DB.pl")
    # Generate the map
    roboMap = [[1 for j in range(maxj + 2)] for i in range(maxi + 2)]
    for canvisit in canvisits:
        roboMap[canvisit[1]][canvisit[0]] = 0
    dv = [[0, 1], [0, -1], [1, 0], [-1, 0]]
    # record the path
    vmap = [[[maxi * maxj, -1] for j in range(maxj + 2)] for i in range(maxi + 2)]

    def dfs(maze, i, j, diridx, depth):
        if vmap[i][j][0] > depth:
            vmap[i][j][0] = depth
            vmap[i][j][1] = diridx
        else:
            return depth
        if (i == end[1] and j == end[0]):
            return
        else:
            for k in range(4):
                nexti = i + dv[k][0]
                nextj = j + dv[k][1]
                if maze[nexti][nextj] == 0:
                    dfs(maze, nexti, nextj, k, depth+1)
    dfs(roboMap, start[1], start[0], 4, 0)
    for i in range(maxi + 2):
        print(vmap[i])
       # Out put the outcome
    if vmap[end[1]][end[0]][1] == -1:
        print("no solution")
    else:
        print("shortest path: %d" % (vmap[end[1]][end[0]][0]+1))
        i = end[1]
        j = end[0]
        path = [(j, i)]
        while (vmap[i][j][1] != 4):
            dsidx = vmap[i][j][1]
            i -= dv[dsidx][0]
            j -= dv[dsidx][1]
            path.append((j, i))
        while (len(path) > 0):
            print(path.pop())
