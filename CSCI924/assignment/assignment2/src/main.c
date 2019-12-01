//Author: 梅王智汇 Wangzhihui Mei
//CCNU Number: 2019124044
//UOW Number: 6603385
#include <stdio.h>
#include <stdarg.h>

const double epsilon = 0.0001, gamma = 0.9, rewards[5] = {1, -1, 0, 1, 3},
             prob_actiontostate[5][4][5] = {
                 {{0.2, 0.8, 0, 0, 0}, {0, 0, 1, 0, 0}, {1, 0, 0, 0, 0}, {0.8, 0, 0.2, 0, 0}},
                 {{0.7, 0, 0, 0.3, 0}, {0, 0.1, 0, 0.9, 0}, {0, 0, 0.8, 0.2, 0}, {0.8, 0.2, 0, 0, 0}},
                 {{0, 0.5, 0.5, 0, 0}, {0, 0.5, 0.5, 0, 0}, {0, 0, 1, 0, 0}, {0.5, 0, 0.5, 0, 0}},
                 {{0, 0, 0, 1, 0}, {0, 0.3, 0, 0.7, 0}, {0, 0, 0, 0, 1}, {0, 0, 0, 0.5, 0.5}},
                 {{0, 0, 0.3, 0, 0.7}, {0, 0, 0, 0.6, 0.4}, {0, 0, 0, 0.9, 0.1}, {0.8, 0, 0, 0, 0.2}}};

double abs_double(double x)
{
    return x > 0 ? x : -x;
}

int main()
{
    double J[5] = {0, 0, 0, 0, 0};
    double nextJ[5] = {0, 0, 0, 0, 0};
    double delta;
    int step = 0, optimalk = -1;
    char optimalaction[5] = { 'X', 'X', 'X', 'X', 'X' };
    do
    {
        delta = 0;
        for (int i = 0; i < 5; i++)
        {
            double maxaction = 0;
            for (int k = 0; k < 4; k++)
            {
                double temp = 0;
                for (int j = 0; j < 5; j++)
                {
                    temp += gamma * prob_actiontostate[i][k][j] * J[j];
                }
                if (maxaction < temp)
                {
                    maxaction = temp;
                    optimalaction[i] = 'A' + k;
                }
            }
            nextJ[i] = maxaction + rewards[i];
            delta = delta < abs_double(nextJ[i] - J[i]) ? abs_double(nextJ[i] - J[i]) : delta;
        }
        for (int i = 0; i < 5; i++)
        {
            J[i] = nextJ[i];
            nextJ[i] = 0;
        }
        printf("step %d:\n     J: %6.4f, %6.4f, %6.4f, %6.4f, %6.4f \n", step++, J[0], J[1], J[2], J[3], J[4]);
        printf("Policy: S1->%c    S2->%c    S3->%c    S4->%c    S5->%c \n", optimalaction[0], optimalaction[1], optimalaction[2], optimalaction[3], optimalaction[4]);
    } while (delta > epsilon);
    return 0;
}
