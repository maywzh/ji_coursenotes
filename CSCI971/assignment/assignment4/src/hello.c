#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int Sbox_bit = 3;
unsigned int Sbox_1[8] = {0x00, 0x05, 0x03, 0x02, 0x06, 0x01, 0x04, 0x07};
int main()
{
    int i, j;
    int Sbox_size = 0x1 << Sbox_bit;
    // unsigned int **map = (unsigned int **)malloc(Sbox_size * sizeof(unsigned int *));
    // for (int i = 0; i < Sbox_size; i++)
    //     map[i] = (unsigned int *)malloc(Sbox_size * sizeof(unsigned int));
    unsigned int map[8][8];
    for (i = 0; i < Sbox_size; i++)
        for (j = 0; j < Sbox_size; j++)
            map[i][j] = 0;
    for (i = 0; i < Sbox_size; i++)
    {
        for (j = 0; j < Sbox_size; j++)
        {
            printf("%d ", map[i][j]);
        }
        printf("\r\n");
    }
    printf("%d", Sbox_size);
    return 0;
}