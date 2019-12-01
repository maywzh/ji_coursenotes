#include <stdio.h>

int main(void)
{
	int a = 21;
	int b = 4;
	int c = a % b;

	printf("%d mod %d = %d\n", a, b, c);
	return 0;
}