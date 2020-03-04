/*
 * @Author: your name
 * @Date: 2020-03-04 00:53:08
 * @LastEditTime: 2020-03-04 02:46:53
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /ji_coursenotes/2020spring/CSCI964/assignment1-0306/src/rand.cpp
 */
#include <iostream>
using namespace std;
int random_between(int min, int max)
{
    return (rand() % (max - min + 1)) + min;
}

int *RandomArray(int n)
{
    int *arr = new int[n];
    for (int i = 0; i < n; i++)
    {
        arr[i] = i;
    }
    for (int i = n - 1; i >= 1; i--)
    {
        int j = random_between(0, i);
        int tmp = arr[i];
        arr[i] = arr[j];
        arr[j] = tmp;
    }
    return arr;
}

void PrintArray(int *arr, int n)
{
    for (int i = 0; i < n; i++)
    {
        cout << arr[i] << " ";
    }
}

int main()
{

    srand((unsigned)time(NULL));
    // for (int i = 0; i < 10; i++)
    // {
    //     int a = random_between(0, 10);
    //     cout << a << endl;
    // }
    int *arr = RandomArray(10);
    PrintArray(arr, 10);
    delete[] arr;

    return 0;
}