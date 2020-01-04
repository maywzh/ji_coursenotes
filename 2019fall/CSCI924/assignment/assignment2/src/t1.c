#include <stdio.h>
#include <math.h>
#define M 4         //目标行数
#define N 5         //目标列数
#define MaxSize 100 //栈最多元素个数
int mg[9][10] = {   //一个迷宫，其四周要加上均为1的外框
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    {1, 1, 0, 0, 0, 0, 0, 0, 1, 1},
    {1, 1, 0, 1, 0, 1, 1, 0, 1, 1},
    {1, 1, 0, 1, 0, 0, 1, 0, 1, 1},
    {1, 1, 0, 0, 1, 1, 0, 0, 1, 1},
    {1, 1, 0, 0, 0, 0, 0, 1, 0, 1},
    {1, 1, 1, 1, 1, 1, 1, 0, 0, 1},
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1}};
struct migong
{
    int i;                       //路径横坐标
    int j;                       //路径纵坐标
    int di;                      //方向
} Stack[MaxSize], Path[MaxSize]; //定义栈和存放最短路径的数组
int top = -1;                    //栈顶指针
int count = 1;                   //路径数计数
int minlen = MaxSize;            //最短路径长度
void mgpath()
{ //路径为:(i,j)->(M,N)
    int i, j, di, find, k;
    top++;
    Stack[top].i = 5;
    Stack[top].j = 7;
    Stack[top].di = -1;
    mg[1][1] = -1; //初始结点进栈
    while (top > -1)
    { //栈不空时循环
        i = Stack[top].i;
        j = Stack[top].j;
        di = Stack[top].di;
        if (i == M && j == N)
        { //找到了出口，输出路径
            printf("M:  ", count++);
            for (k = 0; k <= top; k++)
            {
                printf("(%d,%d)  ", Stack[k].j, abs(Stack[k].i - 8));
                if ((k + 1) % 5 == 0) //输出时每5个结点换一行
                    printf("\n\t");
            }
            printf("\n");
            if (top + 1 < minlen)
            { //比较输出最短路径
                for (k = 0; k <= top; k++)
                    Path[k] = Stack[k];
                minlen = top + 1;
            }
            mg[Stack[top].i][Stack[top].j] = 0; //让该位置变为其他路径的可走结点
            top--;
            i = Stack[top].i;
            j = Stack[top].j;
            di = Stack[top].di;
        }
        find = 0;
        while (di < 4 && find == 0)
        { //找下一个可走结点
            di++;
            switch (di)
            {
            case 0:
                i = Stack[top].i - 1;
                j = Stack[top].j;
                break; //上面
            case 1:
                i = Stack[top].i;
                j = Stack[top].j + 1;
                break; //右边
            case 2:
                i = Stack[top].i + 1;
                j = Stack[top].j;
                break; //下面
            case 3:
                i = Stack[top].i;
                j = Stack[top].j - 1;
                break; //左边
            }
            if (mg[i][j] == 0)
                find = 1;
        }
        if (find == 1)
        {                       //找到了下一个可走结点
            Stack[top].di = di; //修改原栈顶元素的di值
            top++;              //下一个可走结点进栈
            Stack[top].i = i;
            Stack[top].j = j;
            Stack[top].di = -1;
            mg[i][j] = -1; //避免重复走到该结点
        }
        else
        {
            mg[Stack[top].i][Stack[top].j] = 0; //让该位置变为其他路径的可走结点
            top--;
        }
    }
    printf("最短路径如下:\n");
    printf("长度:  %d\n", minlen);
    printf("路径:  ");
    for (k = 0; k < minlen; k++)
    {
        printf("(%d,%d)  ", Path[k].j, abs(Path[k].i - 8));
        if ((k + 1) % 5 == 0) //输出时每5个结点换一行
            printf("\n\t");
    }
    printf("\n");
}
int main()
{
    printf("迷宫所有路径如下:\n");
    mgpath();
    return 0;
}