/*
@AUTHOR Raindrop Team
UTF-8
*/
#include<stdio.h>
#include<stdlib.h>
#include"raindrop.h"

//Please choose the number of rounds you want to encrypt !
#define Enc_Round 60

int Key_Schedule_128(unsigned char *Seedkey, unsigned char *Subkey)
{
	unsigned int KeyState[8];
	Key_Unsigned_Char_To_Unsigned_Int(Seedkey, KeyState, 16);

	unsigned int *RoundKey;
	int RoundKey_len = 16;
	if ((RoundKey = (unsigned int *)malloc(Enc_Round*RoundKey_len * sizeof(unsigned int))) == NULL)
	{
		printf("Low Memory!\n");
		return -1;
	}
	for (int index = 0; index<Enc_Round*RoundKey_len; index++)
	{
		RoundKey[index] = 0x00;
	}

	for (int round = 0; round<Enc_Round; round++)
	{
		for (int col = 0; col<4; col++)
		{
			RoundKey[16 * round + 4 * 0 + col] = (KeyState[col] >> 13) & 0x7;
			RoundKey[16 * round + 4 * 1 + col] = (KeyState[col] >> 8) & 0x1F;
			RoundKey[16 * round + 4 * 2 + col] = (KeyState[col] >> 5) & 0x7;
			RoundKey[16 * round + 4 * 3 + col] = (KeyState[col]) & 0x1F;
		}
		KeyState[3] ^= (round + 1);
		for (int index = 0; index<4; index++)
		{
			OperationA(KeyState);
		}
	}

	Round_SubKey_Unsigned_Int_To_Unsigned_Char(RoundKey, Subkey, 8, Enc_Round);

	free(RoundKey);
	return 0;
}

int Key_Schedule(unsigned char *Seedkey, int KeyLen, unsigned char Direction, unsigned char *Subkey)
{
	int key_result;
	if (KeyLen == 128)
	{
		key_result = Key_Schedule_128(Seedkey, Subkey);
		if (key_result != 0)
		{
			return -1;
		}
	}

	if (Direction == 1)
	{
		unsigned char *tmpSubkey;
		int tmpSubkey_len = Enc_Round * KeyLen / 16;
		if ((tmpSubkey = (unsigned char *)malloc(tmpSubkey_len * sizeof(unsigned char))) == NULL)
		{
			printf("Low Memory!\n");
			return -1;
		}
		for (int index = 0; index<tmpSubkey_len; index++)
		{
			tmpSubkey[index] = 0x0;
		}
		//Invert Subkey
		for (int round = 0; round<Enc_Round; round++)
		{
			for (int pos = 0; pos<tmpSubkey_len / Enc_Round; pos++)
			{
				tmpSubkey[tmpSubkey_len / Enc_Round * round + pos] = Subkey[tmpSubkey_len / Enc_Round * (Enc_Round - round - 1) + pos];
			}
		}
		for (int index = 0; index<tmpSubkey_len; index++)
		{
			Subkey[index] = tmpSubkey[index];
		}
		free(tmpSubkey);
	}

	return 0;
}

void Enc_128_128(unsigned int Plaintext[2][16], unsigned int Ciphertext[2][16], unsigned char *Subkey, int CryptRound)
{
	unsigned int Sbox_1[8] = { 0x00,0x05,0x03,0x02,0x06,0x01,0x04,0x07 };
	unsigned int Sbox_2[32] = { 0x00,0x05,0x0a,0x0b,0x14,0x11,0x16,0x17,0x09,0x0c,0x03,0x02,0x0d,0x08,0x0f,0x0e,0x12,0x15,0x18,0x1b,0x06,0x01,0x04,0x07,0x1a,0x1d,0x10,0x13,0x1e,0x19,0x1c,0x1f };
	int MR[4][4] = {
		0,0,1,1,
		1,0,0,1,
		0,1,0,0,
		1,1,0,0
	};
	int BitRot[4] = { 0,6,7,12 };
	int tmpRotNum = 16;
	unsigned int tmpRotValue = 0xFFFF;
	int Arr1_UsedinBitRot[4] = { 13,8,5,0 };
	int Arr2_UsedinBitRot[4] = { 0x7,0x1F,0x7,0x1F };

	unsigned int RoundKey[Enc_Round * 16];
	Round_SubKey_Unsigned_Char_To_Unsigned_Int(RoundKey, Subkey, 128 / 16, Enc_Round);

	unsigned int tmpPlaintext[2][16];
	unsigned int tmpState[16];
	unsigned int tmpColValue[4];
	unsigned int tmpV[4];
	//Begin Encryption
	for (int round = 0; round<CryptRound; round++)
	{
		//StatePrintf
		printf("Round=%d:\n", round + 1);
		printf("LeftState:              RightState:\n");
		for (int i = 0; i < 4; i++)
		{
			for (int j = 0; j < 4; j++)
			{
				printf("0x%02x ", Plaintext[0][4 * i + j]);
			}
			printf("    ");
			for (int j = 0; j < 4; j++)
			{
				printf("0x%02x ", Plaintext[1][4 * i + j]);
			}
			printf("    \n");
		}
		printf("\n");

		//Add Round Key
		//printf("Add Round Key\n");
		for (int pos = 0; pos < 16; pos++)
		{
			//Plaintext[1][pos] ^= RoundKey[16 * round + pos];
            Plaintext[1][pos] ^= 0x00;
        }

        for (int pos = 0; pos<16; pos++)
		{
			tmpPlaintext[0][pos] = Plaintext[0][pos];
			tmpPlaintext[1][pos] = Plaintext[1][pos];
		}

		//printf("Sbox\n");
		// for (int pos = 0; pos<4; pos++)
		// {
		// 	tmpState[pos] = Sbox_1[Plaintext[0][pos]];
		// 	tmpState[pos + 4] = Sbox_2[Plaintext[0][pos + 4]];
		// 	tmpState[pos + 8] = Sbox_1[Plaintext[0][pos + 8]];
		// 	tmpState[pos + 12] = Sbox_2[Plaintext[0][pos + 12]];
		// }
		// for (int pos = 0; pos<16; pos++)
		// {
		// 	Plaintext[0][pos] = tmpState[pos];
		// }

		//MixRow
		for (int row = 0; row<4; row++)
		{
			for (int col = 0; col<4; col++)
			{
				tmpState[4 * row + col] = (Plaintext[0][4 * row + 0] * MR[0][col]) ^ (Plaintext[0][4 * row + 1] * MR[1][col]) ^ (Plaintext[0][4 * row + 2] * MR[2][col]) ^ (Plaintext[0][4 * row + 3] * MR[3][col]);
			}
		}
		for (int pos = 0; pos<16; pos++)
		{
			Plaintext[0][pos] = tmpState[pos];
		}
		//BitRot
		for (int col = 0; col<4; col++)
		{
			tmpColValue[col] = (Plaintext[0][col] << Arr1_UsedinBitRot[0]) ^ (Plaintext[0][4 + col] << Arr1_UsedinBitRot[1]) ^ (Plaintext[0][8 + col] << Arr1_UsedinBitRot[2]) ^ (Plaintext[0][12 + col] << Arr1_UsedinBitRot[3]);
			tmpV[col] = left_circular_rotate_state(tmpColValue[col], BitRot[col], tmpRotNum, tmpRotValue);
			tmpState[col] = (tmpV[col] >> Arr1_UsedinBitRot[0])&Arr2_UsedinBitRot[0];
			tmpState[4 + col] = (tmpV[col] >> Arr1_UsedinBitRot[1])&Arr2_UsedinBitRot[1];
			tmpState[8 + col] = (tmpV[col] >> Arr1_UsedinBitRot[2])&Arr2_UsedinBitRot[2];
			tmpState[12 + col] = (tmpV[col] >> Arr1_UsedinBitRot[3])&Arr2_UsedinBitRot[3];
		}
		for (int pos = 0; pos<16; pos++)
		{
			Plaintext[0][pos] = tmpState[pos];
		}
		printf("After MixRow and BitRot\n");
		for (int i = 0; i < 4; i++)
		{
			for (int j = 0; j < 4; j++)
			{
				printf("0x%02x ", Plaintext[0][4 * i + j]);
			}
			printf("    ");
			for (int j = 0; j < 4; j++)
			{
				printf("0x%02x ", Plaintext[1][4 * i + j]);
			}
			printf("    \n");
		}
		printf("\n");

		if (round == (CryptRound - 1))
		{
			for (int pos = 0; pos<16; pos++)
			{
				Ciphertext[0][pos] = tmpPlaintext[0][pos];
				Ciphertext[1][pos] = tmpPlaintext[1][pos] ^ Plaintext[0][pos];
			}
		}
		else
		{
			for (int pos = 0; pos<16; pos++)
			{
				Ciphertext[1][pos] = tmpPlaintext[0][pos];
				Ciphertext[0][pos] = tmpPlaintext[1][pos] ^ Plaintext[0][pos];
			}
		}

		for (int pos = 0; pos<16; pos++)
		{
			Plaintext[0][pos] = Ciphertext[0][pos];
			Plaintext[1][pos] = Ciphertext[1][pos];
		}
	}
	//Ciphertext Printf
	printf("Round=%d:\n", CryptRound + 1);
	printf("LeftState:              RightState:\n");
	for (int i = 0; i < 4; i++)
	{
		for (int j = 0; j < 4; j++)
		{
			printf("0x%02x ", Ciphertext[0][4 * i + j]);
		}
		printf("    ");
		for (int j = 0; j < 4; j++)
		{
			if (j == 3)
			{
				printf("0x%02x\n", Ciphertext[1][4 * i + j]);
			}
			else
			{
				printf("0x%02x ", Ciphertext[1][4 * i + j]);
			}
		}
	}
	printf("\n");
}

int Crypt_Enc_Block_Round(unsigned char *input, int in_len, unsigned char *output, int *out_len, unsigned char *key, int keylen, int CryptRound)
{
	unsigned char *Subkey;
	if ((Subkey = (unsigned char *)malloc(CryptRound*keylen / 16 * sizeof(unsigned char *))) == NULL)
	{
		printf("Low Memory!\n");
		return -1;
	}
	for (int index = 0; index<CryptRound*keylen / 16; index++)
	{
		Subkey[index] = 0x00;
	}

	//generate all subkeys
	int gensubkey_result = Key_Schedule(key, keylen, 0, Subkey);
	if (gensubkey_result != 0)
	{
		printf("Something wrong when proceeding key_schedule!\n");
		return -1;
	}

	unsigned int Plaintext[2][16];
	unsigned int Ciphertext[2][16];
	//Convert type of input into unsigned int[2][16].
	Plaintext_Unsigned_Char_To_UnsignedInt(input, Plaintext, in_len / 8);
	if (in_len == 128)
	{
		if (keylen == 128)
		{
			Enc_128_128(Plaintext, Ciphertext, Subkey, Enc_Round);
		}
	}

	Ciphertext_UnsignedInt_To_Unsingned_Char(output, Ciphertext, in_len / 8);

	printf("Ciphertext After %d-Round Encryptions:\n", Enc_Round);
	for (int index = 0; index<in_len / 8; index++)
	{
		printf("0x%02x ", output[index]);
	}
	printf("\n");

	free(Subkey);

	return 0;
}

int Crypt_Enc_Block(unsigned char *input, int in_len, unsigned char *output, int *out_len, unsigned char *key, int keylen)
{
	int enc_round_result;
	if (in_len == 128)
	{
		if (keylen == 128)
		{
			enc_round_result = Crypt_Enc_Block_Round(input, in_len, output, out_len, key, keylen, Enc_Round);
			if (enc_round_result != 0)
			{
				printf("Something wrong when proceeding Crypt_Enc_Block_Round!\n");
				return -1;
			}
		}
		else
		{
			printf("Wrong Key Length!\n");
			return -1;
		}
	}
	else
	{
		printf("Wrong Block Length!\n");
		return -1;
	}

	return 0;
}

int main(void)
{
	printf("Proceeding the encryption test of Raindrop-128-128 ...\n");\
	//Set p0 as 1, we assert it has the highest probiblity to keep its df value
	unsigned char Plaintext[16] = { 0x20,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00};
	unsigned char Ciphertext[16] = { 0x00 };
	unsigned char Seedkey[16] = { 0x00,0x10,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00 };
	int plaintext_length = 128;
	int seedkey_length = 128;
	printf("The Plaintext is :\n");
	for (int i = 0; i < 16; i++)
	{
		printf("0x%02x ", Plaintext[i]);
	}
	printf("\n");
	int enc_result = Crypt_Enc_Block(Plaintext, plaintext_length, Ciphertext, &plaintext_length, Seedkey, seedkey_length);
	if (enc_result != 0)
	{
		printf("Error in Encryption!\n");
	}
	return 0;
}
