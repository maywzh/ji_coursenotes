/*
@AUTHOR Raindrop Team
UTF-8
*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

unsigned int **df_Sbox(unsigned int *Sbox, int Sbox_bit)
{
	int i, j;
	int Sbox_size = 0x1 << Sbox_bit;
	unsigned int **map = (unsigned int **)malloc(Sbox_size * sizeof(unsigned int *));
	for (i = 0; i < Sbox_size; i++)
		map[i] = (unsigned int *)malloc(Sbox_size * sizeof(unsigned int));
	for (i = 0; i < Sbox_size; i++)
		for (j = 0; j < Sbox_size; j++)
			map[i][j] = 0;
	for (i = 0; i < Sbox_size; i++)
		for (j = 0; j < Sbox_size; j++)
			map[i ^ j][Sbox[i] ^ Sbox[j]] += 1;

	return map;
}

void free_df_Sbox(unsigned int **map, int Sbox_bit)
{
	int row_num = 1 << Sbox_bit;
	for (int i = 0; i < row_num; i++)
		free(map[i]);
	free(map);
}

int main(void)
{
	int i, j;
	printf("Sbox Diff Table: \r\n");
	unsigned int Sbox_1[8] = {0x00, 0x05, 0x03, 0x02, 0x06, 0x01, 0x04, 0x07};
	unsigned int Sbox_2[32] = {0x00, 0x05, 0x0a, 0x0b, 0x14, 0x11, 0x16, 0x17, 0x09, 0x0c, 0x03, 0x02, 0x0d, 0x08, 0x0f, 0x0e, 0x12, 0x15, 0x18, 0x1b, 0x06, 0x01, 0x04, 0x07, 0x1a, 0x1d, 0x10, 0x13, 0x1e, 0x19, 0x1c, 0x1f};
	unsigned int **df_Sbox3 = df_Sbox(Sbox_1, 3);
	unsigned int **df_Sbox5 = df_Sbox(Sbox_2, 5);
	for ( i = 0; i < 8; i++)
    {
        for ( j = 0; j < 8; j++)
        {
            printf("%d ", df_Sbox3[i][j]);
        }
        printf("\r\n");
    }
	for (i = 0; i < 32; i++)
    {
        for ( j = 0; j < 32; j++)
        {
            printf("%d ", df_Sbox5[i][j]);
        }
        printf("\r\n");
    }
	
	free_df_Sbox(df_Sbox3, 3);
	free_df_Sbox(df_Sbox5, 5);
	return 0;
}
