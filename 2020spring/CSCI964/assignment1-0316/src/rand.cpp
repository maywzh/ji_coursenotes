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

// return an ordinal array
void InitArray(int *arr, int n)
{
    for (int i = 0; i < n; i++)
    {
        arr[i] = i;
    }
}
void RandomArray(int *arr, int n, int ordering)
{

    if (ordering == 0)
    {
        for (int i = 0; i < n; i++)
        {
            arr[i] = i;
        }
    }
    else if (ordering == 1)
    {
        for (int i = n - 1; i != 0; i--)
        {
            int j = random_between(0, i);
            int tmp = arr[i];
            arr[i] = arr[j];
            arr[j] = tmp;
        }
    }
    else if (ordering == 2)
    {
        int ii = random_between(0, n - 1);
        int jj = random_between(0, n - 1);
        int tmp = arr[ii];
        arr[ii] = arr[jj];
        arr[jj] = tmp;
    }
    else
    {
        for (int i = 0; i < n; i++)
        {
            arr[i] = i;
        }
    }
}

void PrintArray(int *arr, int n)
{
    for (int i = 0; i < n; i++)
    {
        cout << arr[i] << " ";
    }
    cout << endl;
}

int main()
{

    srand((unsigned)time(NULL));
    // for (int i = 0; i < 10; i++)
    // {
    //     int a = random_between(0, 10);
    //     cout << a << endl;
    // }
    int i, j;
    int NumPats = 10;
    int Ordering = 1;
    int *arr = new int[NumPats];
    //Pattern 0
    // if (Ordering == 0)
    //     InitArray(arr, NumPats, false);
    // // Pattern 1
    // else if (Ordering == 1)
    //     InitArray(arr, NumPats, true);
    // // Pattern 2
    // else if (Ordering == 2)
    // {
    //     int ii = random_between(0, NumPats - 1);
    //     int jj = random_between(0, NumPats - 1);
    //     int tmp = arr[i];
    //     arr[i] = arr[j];
    //     arr[j] = tmp;
    // }
    // else
    // {
    //     InitArray(arr, NumPats, false); //TODO: Pattern 3
    // }
    RandomArray(arr, NumPats, 0);
    PrintArray(arr, NumPats);
    RandomArray(arr, NumPats, 1);
    PrintArray(arr, NumPats);
    RandomArray(arr, NumPats, 2);
    PrintArray(arr, NumPats);
    RandomArray(arr, NumPats, 2);
    PrintArray(arr, NumPats);
    delete[] arr;

    return 0;
}