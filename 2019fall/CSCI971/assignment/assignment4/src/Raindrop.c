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

int Key_Schedule_256(unsigned char *Seedkey, unsigned char *Subkey)
{
	unsigned int KeyState[8];
	Key_Unsigned_Char_To_Unsigned_Int(Seedkey, KeyState, 32);

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
			RoundKey[16 * round + 4 * 0 + col] = (KeyState[col] >> (25)) & 0x7F;
			RoundKey[16 * round + 4 * 1 + col] = (KeyState[col] >> (16)) & 0x1FF;
			RoundKey[16 * round + 4 * 2 + col] = (KeyState[col] >> (9)) & 0x7F;
			RoundKey[16 * round + 4 * 3 + col] = (KeyState[col]) & 0x1FF;
		}
		KeyState[2] ^= (round + 1);
		for (int index = 0; index<4; index++)
		{
			OperationB(KeyState);
		}
	}

	Round_SubKey_Unsigned_Int_To_Unsigned_Char(RoundKey, Subkey, 16, Enc_Round);

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
	else
	{
		key_result = Key_Schedule_256(Seedkey, Subkey);
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
		printf("LeftState:              RightState:             KeyState:\n");
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
			printf("    ");
			for (int j = 0; j < 4; j++)
			{
				if (j == 3)
				{
					printf("0x%02x\n", RoundKey[16 * round + 4 * i + j]);
				}
				else
				{
					printf("0x%02x ", RoundKey[16 * round + 4 * i + j]);
				}
			}
		}
		printf("\n");

		//Add Round Key
		for (int pos = 0; pos<16; pos++)
		{
			Plaintext[1][pos] ^= RoundKey[16 * round + pos];
		}
		for (int pos = 0; pos<16; pos++)
		{
			tmpPlaintext[0][pos] = Plaintext[0][pos];
			tmpPlaintext[1][pos] = Plaintext[1][pos];
		}
		//Sbox
		for (int pos = 0; pos<4; pos++)
		{
			tmpState[pos] = Sbox_1[Plaintext[0][pos]];
			tmpState[pos + 4] = Sbox_2[Plaintext[0][pos + 4]];
			tmpState[pos + 8] = Sbox_1[Plaintext[0][pos + 8]];
			tmpState[pos + 12] = Sbox_2[Plaintext[0][pos + 12]];
		}
		for (int pos = 0; pos<16; pos++)
		{
			Plaintext[0][pos] = tmpState[pos];
		}
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

void Enc_128_256(unsigned int Plaintext[2][16], unsigned int Ciphertext[2][16], unsigned char *Subkey, int CryptRound)
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

	unsigned char *tmpSubkey;
	int tmpSubkey_len = CryptRound * 8;
	if ((tmpSubkey = (unsigned char *)malloc(tmpSubkey_len * sizeof(unsigned char))) == NULL)
	{
		printf("Low Memory!\n");
	}
	for (int index = 0; index<tmpSubkey_len; index++)
	{
		tmpSubkey[index] = 0x00;
	}
	int counter_tmp = 0;
	for (int index = 0; index<tmpSubkey_len * 2; index++)
	{
		if ((index % 4 == 0) || (index % 4 == 1))
		{
			tmpSubkey[counter_tmp] = Subkey[index];
			counter_tmp++;
		}
	}

	unsigned int RoundKey[Enc_Round * 16];
	Round_SubKey_Unsigned_Char_To_Unsigned_Int(RoundKey, tmpSubkey, 128 / 16, Enc_Round);

	free(tmpSubkey);

	unsigned int tmpPlaintext[2][16];
	unsigned int tmpState[16];
	unsigned int tmpColValue[4];
	unsigned int tmpV[4];
	//Begin Encryption
	for (int round = 0; round<CryptRound; round++)
	{
		printf("Round=%d:\n", round + 1);
		printf("LeftState:              RightState:             KeyState:\n");
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
			printf("    ");
			for (int j = 0; j < 4; j++)
			{
				if (j == 3)
				{
					printf("0x%02x\n", RoundKey[16 * round + 4 * i + j]);
				}
				else
				{
					printf("0x%02x ", RoundKey[16 * round + 4 * i + j]);
				}
			}
		}
		printf("\n");
		//Add Round Key
		for (int pos = 0; pos<16; pos++)
		{
			Plaintext[1][pos] ^= RoundKey[16 * round + pos];
		}
		for (int pos = 0; pos<16; pos++)
		{
			tmpPlaintext[0][pos] = Plaintext[0][pos];
			tmpPlaintext[1][pos] = Plaintext[1][pos];
		}
		//Sbox
		for (int pos = 0; pos<4; pos++)
		{
			tmpState[pos] = Sbox_1[Plaintext[0][pos]];
			tmpState[pos + 4] = Sbox_2[Plaintext[0][pos + 4]];
			tmpState[pos + 8] = Sbox_1[Plaintext[0][pos + 8]];
			tmpState[pos + 12] = Sbox_2[Plaintext[0][pos + 12]];
		}
		for (int pos = 0; pos<16; pos++)
		{
			Plaintext[0][pos] = tmpState[pos];
		}
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

void Enc_256_256(unsigned int Plaintext[2][16], unsigned int Ciphertext[2][16], unsigned char *Subkey, int CryptRound)
{
	unsigned int Sbox_1[128] = {
		0x00,0x05,0x0a,0x0b,0x14,0x11,0x16,0x17,0x28,0x2d,0x22,0x23,0x2c,0x29,0x2e,0x2f,0x50,0x55,0x5a,0x5b,0x44,0x41,0x46,0x47,0x58,0x5d,0x52,0x53,0x5c,0x59,0x5e,0x5f,0x21,0x24,0x2b,0x2a,0x35,0x30,0x37,0x36,0x09,0x0c,0x03,0x02,0x0d,0x08,0x0f,0x0e,0x31,0x34,0x3b,0x3a,0x25,0x20,0x27,0x26,0x39,0x3c,0x33,0x32,0x3d,0x38,0x3f,0x3e,0x42,0x45,0x48,0x4b,0x56,0x51,0x54,0x57,0x6a,0x6d,0x60,0x63,0x6e,0x69,0x6c,0x6f,0x12,0x15,0x18,0x1b,0x06,0x01,0x04,0x07,0x1a,0x1d,0x10,0x13,0x1e,0x19,0x1c,0x1f,0x62,0x65,0x68,0x6b,0x76,0x71,0x74,0x77,0x4a,0x4d,0x40,0x43,0x4e,0x49,0x4c,0x4f,0x72,0x75,0x78,0x7b,0x66,0x61,0x64,0x67,0x7a,0x7d,0x70,0x73,0x7e,0x79,0x7c,0x7f
	};
	unsigned int Sbox_2[512] = {
		0x00,0x05,0x0a,0x0b,0x14,0x11,0x16,0x17,0x28,0x2d,0x22,0x23,0x2c,0x29,0x2e,0x2f,0x50,0x55,0x5a,0x5b,0x44,0x41,0x46,0x47,0x58,0x5d,0x52,0x53,0x5c,0x59,0x5e,0x5f,0xa0,0xa5,0xaa,0xab,0xb4,0xb1,0xb6,0xb7,0x88,0x8d,0x82,0x83,0x8c,0x89,0x8e,0x8f,0xb0,0xb5,0xba,0xbb,0xa4,0xa1,0xa6,0xa7,0xb8,0xbd,0xb2,0xb3,0xbc,0xb9,0xbe,0xbf,0x140,0x145,0x14a,0x14b,0x154,0x151,0x156,0x157,0x168,0x16d,0x162,0x163,0x16c,0x169,0x16e,0x16f,0x110,0x115,0x11a,0x11b,0x104,0x101,0x106,0x107,0x118,0x11d,0x112,0x113,0x11c,0x119,0x11e,0x11f,0x160,0x165,0x16a,0x16b,0x174,0x171,0x176,0x177,0x148,0x14d,0x142,0x143,0x14c,0x149,0x14e,0x14f,0x170,0x175,0x17a,0x17b,0x164,0x161,0x166,0x167,0x178,0x17d,0x172,0x173,0x17c,0x179,0x17e,0x17f,0x81,0x84,0x8b,0x8a,0x95,0x90,0x97,0x96,0xa9,0xac,0xa3,0xa2,0xad,0xa8,0xaf,0xae,0xd1,0xd4,0xdb,0xda,0xc5,0xc0,0xc7,0xc6,0xd9,0xdc,0xd3,0xd2,0xdd,0xd8,0xdf,0xde,0x21,0x24,0x2b,0x2a,0x35,0x30,0x37,0x36,0x09,0x0c,0x03,0x02,0x0d,0x08,0x0f,0x0e,0x31,0x34,0x3b,0x3a,0x25,0x20,0x27,0x26,0x39,0x3c,0x33,0x32,0x3d,0x38,0x3f,0x3e,0xc1,0xc4,0xcb,0xca,0xd5,0xd0,0xd7,0xd6,0xe9,0xec,0xe3,0xe2,0xed,0xe8,0xef,0xee,0x91,0x94,0x9b,0x9a,0x85,0x80,0x87,0x86,0x99,0x9c,0x93,0x92,0x9d,0x98,0x9f,0x9e,0xe1,0xe4,0xeb,0xea,0xf5,0xf0,0xf7,0xf6,0xc9,0xcc,0xc3,0xc2,0xcd,0xc8,0xcf,0xce,0xf1,0xf4,0xfb,0xfa,0xe5,0xe0,0xe7,0xe6,0xf9,0xfc,0xf3,0xf2,0xfd,0xf8,0xff,0xfe,0x102,0x105,0x108,0x10b,0x116,0x111,0x114,0x117,0x12a,0x12d,0x120,0x123,0x12e,0x129,0x12c,0x12f,0x152,0x155,0x158,0x15b,0x146,0x141,0x144,0x147,0x15a,0x15d,0x150,0x153,0x15e,0x159,0x15c,0x15f,0x1a2,0x1a5,0x1a8,0x1ab,0x1b6,0x1b1,0x1b4,0x1b7,0x18a,0x18d,0x180,0x183,0x18e,0x189,0x18c,0x18f,0x1b2,0x1b5,0x1b8,0x1bb,0x1a6,0x1a1,0x1a4,0x1a7,0x1ba,0x1bd,0x1b0,0x1b3,0x1be,0x1b9,0x1bc,0x1bf,0x42,0x45,0x48,0x4b,0x56,0x51,0x54,0x57,0x6a,0x6d,0x60,0x63,0x6e,0x69,0x6c,0x6f,0x12,0x15,0x18,0x1b,0x06,0x01,0x04,0x07,0x1a,0x1d,0x10,0x13,0x1e,0x19,0x1c,0x1f,0x62,0x65,0x68,0x6b,0x76,0x71,0x74,0x77,0x4a,0x4d,0x40,0x43,0x4e,0x49,0x4c,0x4f,0x72,0x75,0x78,0x7b,0x66,0x61,0x64,0x67,0x7a,0x7d,0x70,0x73,0x7e,0x79,0x7c,0x7f,0x182,0x185,0x188,0x18b,0x196,0x191,0x194,0x197,0x1aa,0x1ad,0x1a0,0x1a3,0x1ae,0x1a9,0x1ac,0x1af,0x1d2,0x1d5,0x1d8,0x1db,0x1c6,0x1c1,0x1c4,0x1c7,0x1da,0x1dd,0x1d0,0x1d3,0x1de,0x1d9,0x1dc,0x1df,0x122,0x125,0x128,0x12b,0x136,0x131,0x134,0x137,0x10a,0x10d,0x100,0x103,0x10e,0x109,0x10c,0x10f,0x132,0x135,0x138,0x13b,0x126,0x121,0x124,0x127,0x13a,0x13d,0x130,0x133,0x13e,0x139,0x13c,0x13f,0x1c2,0x1c5,0x1c8,0x1cb,0x1d6,0x1d1,0x1d4,0x1d7,0x1ea,0x1ed,0x1e0,0x1e3,0x1ee,0x1e9,0x1ec,0x1ef,0x192,0x195,0x198,0x19b,0x186,0x181,0x184,0x187,0x19a,0x19d,0x190,0x193,0x19e,0x199,0x19c,0x19f,0x1e2,0x1e5,0x1e8,0x1eb,0x1f6,0x1f1,0x1f4,0x1f7,0x1ca,0x1cd,0x1c0,0x1c3,0x1ce,0x1c9,0x1cc,0x1cf,0x1f2,0x1f5,0x1f8,0x1fb,0x1e6,0x1e1,0x1e4,0x1e7,0x1fa,0x1fd,0x1f0,0x1f3,0x1fe,0x1f9,0x1fc,0x1ff
	};
	int MR[4][4] = {
		0,0,1,1,
		1,0,0,1,
		0,1,0,0,
		1,1,0,0
	};
	int BitRot[4] = { 0,12,14,24 };
	int tmpRotNum = 32;
	unsigned int tmpRotValue = 0xFFFFFFFF;
	int Arr1_UsedinBitRot[4] = { 25,16,9,0 };
	int Arr2_UsedinBitRot[4] = { 0x7F,0x1FF,0x7F,0x1FF };

	unsigned int RoundKey[Enc_Round * 16];
	Round_SubKey_Unsigned_Char_To_Unsigned_Int(RoundKey, Subkey, 256 / 16, Enc_Round);

	unsigned int tmpPlaintext[2][16];
	unsigned int tmpState[16];
	unsigned int tmpColValue[4];
	unsigned int tmpV[4];
	//Begin Encryption
	for (int round = 0; round<CryptRound; round++)
	{
		printf("Round=%d:\n", round + 1);
		printf("LeftState:                  RightState:                 KeyState:\n");
		for (int i = 0; i < 4; i++)
		{
			for (int j = 0; j < 4; j++)
			{
				printf("0x%03x ", Plaintext[0][4 * i + j]);
			}
			printf("    ");
			for (int j = 0; j < 4; j++)
			{
				printf("0x%03x ", Plaintext[1][4 * i + j]);
			}
			printf("    ");
			for (int j = 0; j < 4; j++)
			{
				if (j == 3)
				{
					printf("0x%03x\n", RoundKey[16 * round + 4 * i + j]);
				}
				else
				{
					printf("0x%03x ", RoundKey[16 * round + 4 * i + j]);
				}
			}
		}
		printf("\n");
		//Add Round Key
		for (int pos = 0; pos<16; pos++)
		{
			Plaintext[1][pos] ^= RoundKey[16 * round + pos];
		}
		for (int pos = 0; pos<16; pos++)
		{
			tmpPlaintext[0][pos] = Plaintext[0][pos];
			tmpPlaintext[1][pos] = Plaintext[1][pos];
		}
		//Sbox
		for (int pos = 0; pos<4; pos++)
		{
			tmpState[pos] = Sbox_1[Plaintext[0][pos]];
			tmpState[pos + 4] = Sbox_2[Plaintext[0][pos + 4]];
			tmpState[pos + 8] = Sbox_1[Plaintext[0][pos + 8]];
			tmpState[pos + 12] = Sbox_2[Plaintext[0][pos + 12]];
		}
		for (int pos = 0; pos<16; pos++)
		{
			Plaintext[0][pos] = tmpState[pos];
		}
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
	printf("Round=%d:\n", CryptRound + 1);
	printf("LeftState:                  RightState:\n");
	for (int i = 0; i < 4; i++)
	{
		for (int j = 0; j < 4; j++)
		{
			printf("0x%03x ", Ciphertext[0][4 * i + j]);
		}
		printf("    ");
		for (int j = 0; j < 4; j++)
		{
			if (j == 3)
			{
				printf("0x%03x\n", Ciphertext[1][4 * i + j]);
			}
			else
			{
				printf("0x%03x ", Ciphertext[1][4 * i + j]);
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
		else
		{
			Enc_128_256(Plaintext, Ciphertext, Subkey, Enc_Round);
		}
	}
	else
	{
		Enc_256_256(Plaintext, Ciphertext, Subkey, Enc_Round);
	}

	//Convert type of output into unsigned char[].
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
		else if (keylen == 256)
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
	else if (in_len == 256)
	{
		if (keylen == 256)
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

int Crypt_Dec_Block_Round(unsigned char *input, int in_len, unsigned char *output, int *out_len, unsigned char *key, int keylen, int CryptRound)
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
	int gensubkey_result = Key_Schedule(key, keylen, 1, Subkey);
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
		else
		{
			Enc_128_256(Plaintext, Ciphertext, Subkey, Enc_Round);
		}
	}
	else
	{
		Enc_256_256(Plaintext, Ciphertext, Subkey, Enc_Round);
	}

	//Convert type of output into unsigned char[].
	Ciphertext_UnsignedInt_To_Unsingned_Char(output, Ciphertext, in_len / 8);

	printf("Plaintext After %d-Round Decryptions:\n", Enc_Round);
	for (int index = 0; index<in_len / 8; index++)
	{
		printf("0x%02x ", output[index]);
	}
	printf("\n");

	free(Subkey);

	return 0;
}

int Crypt_Dec_Block(unsigned char *input, int in_len, unsigned char *output, int *out_len, unsigned char *key, int keylen)
{
	int dec_round_result;
	if (in_len == 128)
	{
		if (keylen == 128)
		{
			dec_round_result = Crypt_Dec_Block_Round(input, in_len, output, out_len, key, keylen, 60);
			if (dec_round_result != 0)
			{
				printf("Something wrong when proceeding Crypt_Dec_Block_Round!\n");
				return -1;
			}
		}
		else if (keylen == 256)
		{
			dec_round_result = Crypt_Dec_Block_Round(input, in_len, output, out_len, key, keylen, 80);
			if (dec_round_result != 0)
			{
				printf("Something wrong when proceeding Crypt_Dec_Block_Round!\n");
				return -1;
			}
		}
		else
		{
			printf("Wrong Key Length!\n");
			return -1;
		}
	}
	else if (in_len == 256)
	{
		if (keylen == 256)
		{
			dec_round_result = Crypt_Dec_Block_Round(input, in_len, output, out_len, key, keylen, 120);
			if (dec_round_result != 0)
			{
				printf("Something wrong when proceeding Crypt_Dec_Block_Round!\n");
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
	//test Encryption of Raindrop-128-128
#if 1
	printf("Proceeding the encryption test of Raindrop-128-128 ...\n");
	unsigned char Plaintext[16] = { 0x35,0x35,0x56,0x56,0x77,0x77,0x98,0x98,0x65,0x25,0x26,0x76,0x87,0x87,0x48,0x58 };
	unsigned char Ciphertext[16] = { 0x00 };
	unsigned char Seedkey[16] = { 0x00,0x00,0x00,0x01,0x00,0x02,0x00,0x03,0x00,0x04,0x00,0x05,0x00,0x06,0x00,0x07 };
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
#endif

	//test Decryption of Raindrop-128-128
#if 0
	printf("Proceeding the decryption test of Raindrop-128-128 ...\n");
	unsigned char Ciphertext[16] = { 0x3b,0xd7,0x67,0x42,0x14,0x2e,0x91,0xa6,0xe1,0xd8,0x47,0x49,0x58,0xfc,0xbe,0xf6 };
	unsigned char Plaintext[16] = { 0x00 };
	unsigned char Seedkey[16] = { 0x00,0x00,0x00,0x01,0x00,0x02,0x00,0x03,0x00,0x04,0x00,0x05,0x00,0x06,0x00,0x07 };
	int plaintext_length = 128;
	int seedkey_length = 128;
	printf("The Ciphertext is :\n");
	for (int i = 0; i < 16; i++)
	{
		printf("0x%02x ", Ciphertext[i]);
	}
	printf("\n");
	int dec_result = Crypt_Dec_Block(Ciphertext, plaintext_length, Plaintext, &plaintext_length, Seedkey, seedkey_length);
	if (dec_result != 0)
	{
		printf("Error in Decryption!\n");
	}
#endif

	//test Encryption of Raindrop-128-256
#if 0
	printf("Proceeding the encryption test of Raindrop-128-256 ...\n");
	unsigned char Plaintext[16] = { 0x35,0x35,0x56,0x56,0x77,0x77,0x98,0x98,0x65,0x25,0x26,0x76,0x87,0x87,0x48,0x58 };
	unsigned char Ciphertext[16] = { 0x00 };
	unsigned char Seedkey[32] = { 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x02,0x00,0x00,0x00,0x03,0x00,0x00,0x00,0x04,0x00,0x00,0x00,0x05,0x00,0x00,0x00,0x06,0x00,0x00,0x00,0x07 };
	int plaintext_length = 128;
	int seedkey_length = 256;
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
#endif

	//test Decryption of Raindrop-128-256
#if 0
	printf("Proceeding the decryption test of Raindrop-128-256 ...\n");
	unsigned char Ciphertext[16] = { 0x54,0xd2,0xa8,0xe6,0x48,0xf1,0x72,0x93,0xa7,0x04,0xc4,0x52,0x74,0x05,0xbc,0x96 };
	unsigned char Plaintext[16] = { 0x00 };
	unsigned char Seedkey[32] = { 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x02,0x00,0x00,0x00,0x03,0x00,0x00,0x00,0x04,0x00,0x00,0x00,0x05,0x00,0x00,0x00,0x06,0x00,0x00,0x00,0x07 };
	int plaintext_length = 128;
	int seedkey_length = 256;
	printf("The Ciphertext is :\n");
	for (int i = 0; i < 16; i++)
	{
		printf("0x%02x ", Ciphertext[i]);
	}
	printf("\n");
	int dec_result = Crypt_Dec_Block(Ciphertext, plaintext_length, Plaintext, &plaintext_length, Seedkey, seedkey_length);
	if (dec_result != 0)
	{
		printf("Error in Decryption!\n");
	}
#endif

	//test Encryption of Raindrop-256-256
#if 0
	printf("Proceeding the encryption test of Raindrop-256-256 ...\n");
	unsigned char Plaintext[32] = { 0x03,0x05,0x13,0x13,0x05,0x06,0x21,0x14,0x07,0x07,0x23,0x15,0x09,0x08,0x25,0x16,0x23,0x15,0x33,0x23,0x25,0x16,0x23,0x24,0x27,0x17,0x23,0x25,0x29,0x18,0x25,0x26 };
	unsigned char Ciphertext[32] = { 0x00 };
	unsigned char Seedkey[32] = { 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x02,0x00,0x00,0x00,0x03,0x00,0x00,0x00,0x04,0x00,0x00,0x00,0x05,0x00,0x00,0x00,0x06,0x00,0x00,0x00,0x07};
	int plaintext_length = 256;
	int seedkey_length = 256;
	printf("The Plaintext is :\n");
	for (int i = 0; i < 32; i++)
	{
		printf("0x%02x ", Plaintext[i]);
	}
	printf("\n");
	int enc_result = Crypt_Enc_Block(Plaintext, plaintext_length, Ciphertext, &plaintext_length, Seedkey, seedkey_length);
	if (enc_result != 0)
	{
		printf("Error in Encryption!\n");
	}
#endif

	//test Decryption of Raindrop-256-256
#if 0
	printf("Proceeding the decryption test of Raindrop-256-256 ...\n");
	unsigned char Ciphertext[32] = { 0x4e,0xe7,0xdf,0xdc,0xba,0x7d,0x13,0x8a,0x8f,0x50,0x62,0x19,0xc6,0x1e,0x43,0xed,0x19,0xc5,0x24,0x4b,0x06,0xe2,0xd6,0x91,0x3a,0x9b,0x2b,0xc7,0x43,0x6e,0x68,0x8c };
	unsigned char Plaintext[32] = { 0x00 };
	unsigned char Seedkey[32] = { 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x02,0x00,0x00,0x00,0x03,0x00,0x00,0x00,0x04,0x00,0x00,0x00,0x05,0x00,0x00,0x00,0x06,0x00,0x00,0x00,0x07 };
	int plaintext_length = 256;
	int seedkey_length = 256;
	printf("The Ciphertext is :\n");
	for (int i = 0; i < 32; i++)
	{
		printf("0x%02x ", Ciphertext[i]);
	}
	printf("\n");
	int dec_result = Crypt_Dec_Block(Ciphertext, plaintext_length, Plaintext, &plaintext_length, Seedkey, seedkey_length);
	if (dec_result != 0)
	{
		printf("Error in Decryption!\n");
	}
#endif

	return 0;
}
