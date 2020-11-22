'''
Author: maywzh
Date: 2020-11-20 23:15:35
LastEditTime: 2020-11-20 23:15:59
LastEditors: maywzh
Description: 
FilePath: /ji_coursenotes/2020fall/CSCI803/lab/lab7/code/nqueen.py
maywzh，All rights reserved.
'''
def totalNQueens(n):
    ans = 0
    solu = [0 for i in range(n)]

    def valid_solu(t) -> bool:
        for i in range(t):
            if abs(solu[i] - solu[t]) == abs(i - t) or solu[i] == solu[t]:
                return False
        return True

    def backtrack(t: int):
        if t >= n:
            nonlocal ans
            ans += 1
            return
        for i in range(n):
            solu[t] = i
            if valid_solu(t):
                backtrack(t + 1)

    backtrack(0)
    return ans

print(totalNQueens(8))