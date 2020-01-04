#define left_circular_rotate_state(input,rot_num,tmpRotNum,tmpRotVaule) (((input<<rot_num)&tmpRotVaule)|(input>>(tmpRotNum-rot_num)))

//Sub-functions used in key_schedule
void OperationA(unsigned int KeyState[8])
{
	void binary_data(unsigned int num, unsigned int *Vector, int Length);
	unsigned int Integer_data(unsigned int *Vector, int Length);
	unsigned int TempState[8];
	unsigned int KeyStateInBinary[8][16];
	unsigned int Vector[128];
	TempState[0] = (KeyState[0] >> 10) ^ KeyState[7];
	TempState[1] = KeyState[0];
	TempState[2] = KeyState[1];
	TempState[3] = KeyState[2];
	TempState[4] = KeyState[3];
	TempState[5] = KeyState[4];
	TempState[6] = (KeyState[2] >> 15) ^ KeyState[5];
	TempState[7] = (KeyState[1] >> 15) ^ KeyState[6];
	for (int i = 0; i < 8; i++)
	{
		binary_data(TempState[i], KeyStateInBinary[i], 16);
	}
	for (int i = 0; i < 8; i++)
	{
		for (int j = 0; j < 16; j++)
		{
			Vector[i * 16 + j] = KeyStateInBinary[i][j];
		}
	}
	int TempVector[128];
	for (int i = 0; i < 123; i++)
	{
		TempVector[i] = Vector[i + 5];
	}
	for (int i = 0; i < 5; i++)
	{
		TempVector[i + 123] = Vector[i];
	}
	for (int i = 0; i < 8; i++)
	{
		for (int j = 0; j < 16; j++)
		{
			KeyStateInBinary[i][j] = TempVector[i * 16 + j];
		}
	}
	for (int i = 0; i < 8; i++)
	{
		KeyState[i] = Integer_data(KeyStateInBinary[i], 16);
	}
	
}

void OperationB(unsigned int KeyState[8])
{
	void binary_data(unsigned int num, unsigned int *Vector, int Length);
	unsigned int Integer_data(unsigned int *Vector, int Length);
	unsigned int TempState[8];
	unsigned int KeyStateInBinary[8][32];
	unsigned int Vector[256];
	TempState[0] = (KeyState[1] >> 25) ^ KeyState[7];
	TempState[1] = KeyState[0];
	TempState[2] = KeyState[1];
	TempState[3] = KeyState[2];
	TempState[4] = KeyState[3];
	TempState[5] = KeyState[4];
	TempState[6] = (KeyState[3] <<29) ^ KeyState[5];
	TempState[7] = (KeyState[0] >> 26) ^ KeyState[6];
	for (int i = 0; i < 8; i++)
	{
		binary_data(TempState[i], KeyStateInBinary[i], 32);
	}
	for (int i = 0; i < 8; i++)
	{
		for (int j = 0; j < 32; j++)
		{
			Vector[i * 32 + j] = KeyStateInBinary[i][j];
		}
	}
	int TempVector[256];
	for (int i = 0; i < 243; i++)
	{
		TempVector[i] = Vector[i + 13];
	}
	for (int i = 0; i < 13; i++)
	{
		TempVector[i + 243] = Vector[i];
	}
	for (int i = 0; i < 8; i++)
	{
		for (int j = 0; j < 32; j++)
		{
			KeyStateInBinary[i][j] = TempVector[i * 32 + j];
		}
	}
	for (int i = 0; i < 8; i++)
	{
		KeyState[i] = Integer_data(KeyStateInBinary[i], 32);
	}
	
}

void binary_data(unsigned int num, unsigned int *Vector, int Length)
{
	unsigned int AndNumber = 0x00000001;
	for (int i = 0; i < Length; i++)
	{
		*(Vector + Length - i - 1) = ((num & (AndNumber << i)) >> i);
	}
}

unsigned int Integer_data(unsigned int *Vector, int Length)
{
	unsigned int AndNumber = 0x00000001;
	unsigned int result = 0;
	for (int i = 0; i < Length; i++)
	{
		result = result ^ ((*(Vector + i))*(AndNumber << (Length - i - 1)));
	}
	return result;
}

//type convert functions
void Key_Unsigned_Char_To_Unsigned_Int(unsigned char *Vector, unsigned int Key[8], unsigned int Length_Key)
{
	if (Length_Key == 16)
	{
		for (int Key_Count = 0; Key_Count < 8; Key_Count++)
		{
			unsigned int TempVariant = 0;
			Key[Key_Count] = ((TempVariant ^ (*(Vector + Key_Count * 2))) << 8) ^ (*(Vector + Key_Count * 2 + 1));
		}
	}
	else if (Length_Key == 32)
	{
		for (int Key_Count = 0; Key_Count < 8; Key_Count++)
		{
			unsigned int TempVariant = 0;
			Key[Key_Count] = (TempVariant ^ (*(Vector + Key_Count * 4)) << 24) ^ (TempVariant ^ (*(Vector + Key_Count * 4 + 1)) << 16) ^ (TempVariant ^ (*(Vector + Key_Count * 4 + 2)) << 8) ^ (TempVariant ^ (*(Vector + Key_Count * 4 + 3)));
		}
	}
	else
	{
		printf("\nERRO:Key Length Erro\n");
	}
}

void Round_SubKey_Unsigned_Int_To_Unsigned_Char(unsigned int *Unsigned_Int_Arry, unsigned char *Unsigned_Char_Vector, unsigned int Length_Of_SubKey, int Round)
{
	if (Length_Of_SubKey == 8)
	{
		for (unsigned int Round_Counter = 0; Round_Counter < Round; Round_Counter++)
		{
			for (unsigned int Key_Length_Counter = 0; Key_Length_Counter < Length_Of_SubKey; Key_Length_Counter++)
			{
				if (Key_Length_Counter % 2 == 0)
				{
					*(Unsigned_Char_Vector + Round_Counter * 8 + Key_Length_Counter) = (((*(Unsigned_Int_Arry + Round_Counter * 16 + (Key_Length_Counter / 2))) << 5) ^ (*(Unsigned_Int_Arry + Round_Counter * 16 + ((Key_Length_Counter / 2) + 4))));
				}
				else
				{
					*(Unsigned_Char_Vector + Round_Counter * 8 + Key_Length_Counter) = (((*(Unsigned_Int_Arry + Round_Counter * 16 + (((Key_Length_Counter - 1) / 2) + 8))) << 5) ^ (*(Unsigned_Int_Arry + Round_Counter * 16 + (((Key_Length_Counter - 1) / 2) + 12))));
				}
				
			}
		}
	}
	else if (Length_Of_SubKey == 16)
	{
		for (unsigned int Round_Counter = 0; Round_Counter < Round; Round_Counter++)
		{
			for (int i = 0; i < 4; i++)
			{
				for (int j = 0; j < 4; j++)
				{
					if (i == 0 || i == 2)
					{
						*(Unsigned_Char_Vector + Round_Counter * 16 + 4 * j + i) = ((*(Unsigned_Int_Arry + Round_Counter * 16 + 4 * i + j)) << 1) ^ ((*(Unsigned_Int_Arry + Round_Counter * 16 + 4 * i + j + 4) >> 8));
					}
					else
					{
						*(Unsigned_Char_Vector + Round_Counter * 16 + 4 * j + i) = ((*(Unsigned_Int_Arry + Round_Counter * 16 + 4 * i + j)) & 0xff);
					}
				}
			}
		}
	}
	else
	{
		printf("\nERRO:Key Length Erro\n");
	}
}

void Round_SubKey_Unsigned_Char_To_Unsigned_Int(unsigned int *Unsigned_Int_Arry, unsigned char *Unsigned_Char_Vector, unsigned int Length_Of_SubKey, int Round)
{
	if (Length_Of_SubKey == 8)
	{
		for (unsigned int Round_Counter = 0; Round_Counter < Round; Round_Counter++)
		{
			for (unsigned int Key_Length_Counter = 0; Key_Length_Counter < Length_Of_SubKey; Key_Length_Counter++)
			{
				if (Key_Length_Counter % 2 == 0)
				{
					*(Unsigned_Int_Arry + Round_Counter * 16 + (Key_Length_Counter / 2)) = (*(Unsigned_Char_Vector + Round_Counter * 8 + Key_Length_Counter)) >> 5;
					*(Unsigned_Int_Arry + Round_Counter * 16 + (Key_Length_Counter / 2) + 4) = (*(Unsigned_Char_Vector + Round_Counter * 8 + Key_Length_Counter)) & 0x1f;
				}
				else
				{
					*(Unsigned_Int_Arry + Round_Counter * 16 + ((Key_Length_Counter - 1) / 2) + 8) = (*(Unsigned_Char_Vector + Round_Counter * 8 + Key_Length_Counter)) >> 5;
					*(Unsigned_Int_Arry + Round_Counter * 16 + ((Key_Length_Counter - 1) / 2) + 12) = (*(Unsigned_Char_Vector + Round_Counter * 8 + Key_Length_Counter)) & 0x1f;
				}

			}
		}
	}
	else if (Length_Of_SubKey == 16)
	{
		for (unsigned int Round_Counter = 0; Round_Counter < Round; Round_Counter++)
		{
			for (int i = 0; i < 4; i++)
			{
				for (int j = 0; j < 4; j++)
				{
					if (i == 0 || i == 2)
					{
						*(Unsigned_Int_Arry + 16 * Round_Counter + 4 * i + j) = (*(Unsigned_Char_Vector + 16 * Round_Counter + 4 * j + i)) >> 1;
					}
					else
					{
						*(Unsigned_Int_Arry + 16 * Round_Counter + 4 * i + j) = (*(Unsigned_Char_Vector + 16 * Round_Counter + 4 * j + i)) ^ (((*(Unsigned_Char_Vector + 16 * Round_Counter + 4 * j + i - 1)) << 8) & 0x1ff);
					}
				}
			}
		}
	}
	else
	{
		printf("\nERRO:Key Length Erro\n");
	}
}

void Plaintext_Unsigned_Char_To_UnsignedInt(unsigned char *Unsigned_Char_Vector, unsigned int Unsigned_Int_Vector[2][16],unsigned int Length_Usigned_Char_Vector)
{
	if (Length_Usigned_Char_Vector == 16)
	{
		unsigned char Unsingned_Char_Arry_Left[16] = { 0 };
		for (int Char_Count = 0; Char_Count < 8; Char_Count++)
		{
			Unsingned_Char_Arry_Left[(Char_Count) * 2] = (*(Unsigned_Char_Vector + Char_Count)) >> 5;
			Unsingned_Char_Arry_Left[(Char_Count) * 2 + 1] = (*(Unsigned_Char_Vector + Char_Count)) & 0x1f;
		}
		for (int i = 0; i < 4; i++)
		{
			for (int j = 0; j < 4; j++)
			{
				Unsigned_Int_Vector[0][4 * i + j] = Unsingned_Char_Arry_Left[4 * j + i];
			}
		}

		unsigned char Unsingned_Char_Arry_Right[16] = { 0 };
		for (int Char_Count = 8; Char_Count < 16; Char_Count++)
		{
			Unsingned_Char_Arry_Right[((Char_Count - 8)) * 2] = (*(Unsigned_Char_Vector + Char_Count)) >> 5;
			Unsingned_Char_Arry_Right[(Char_Count - 8) * 2 + 1] = (*(Unsigned_Char_Vector + Char_Count)) & 0x1f;
		}
		for (int i = 0; i < 4; i++)
		{
			for (int j = 0; j < 4; j++)
			{
				Unsigned_Int_Vector[1][4 * i + j] = Unsingned_Char_Arry_Right[4 * j + i];
			}
		}
	}

	else if (Length_Usigned_Char_Vector == 32)
	{
		unsigned int Unsingned_Char_Arry_Left[16] = { 0 };
		for (int Char_Count = 0; Char_Count < 16; Char_Count++)
		{
			if ((Char_Count) % 2 == 0)
			{
				Unsingned_Char_Arry_Left[Char_Count] = (*(Unsigned_Char_Vector + Char_Count)) >> 1;
			}
			else
			{
				Unsingned_Char_Arry_Left[Char_Count] = (((*(Unsigned_Char_Vector + Char_Count - 1)) << 8)&(0x100)) ^ (*(Unsigned_Char_Vector + Char_Count));
			}
		}

		for (int i = 0; i < 4; i++)
		{
			for (int j = 0; j < 4; j++)
			{
				Unsigned_Int_Vector[0][4 * i + j] = Unsingned_Char_Arry_Left[4 * j + i];
			}
		}

		unsigned int Unsingned_Char_Arry_Right[16] = { 0 };
		for (int Char_Count = 16; Char_Count < 32; Char_Count++)
		{
			if ((Char_Count) % 2 == 0)
			{
				Unsingned_Char_Arry_Right[Char_Count - 16] = (*(Unsigned_Char_Vector + Char_Count)) >> 1;
			}
			else
			{
				Unsingned_Char_Arry_Right[Char_Count - 16] = (((*(Unsigned_Char_Vector + Char_Count - 1)) << 8)&(0x100)) ^ (*(Unsigned_Char_Vector + Char_Count));
			}
		}
		for (int i = 0; i < 4; i++)
		{
			for (int j = 0; j < 4; j++)
			{
				Unsigned_Int_Vector[1][4 * i + j] = Unsingned_Char_Arry_Right[4 * j + i];
			}
		}
	}
}

void Ciphertext_UnsignedInt_To_Unsingned_Char(unsigned char *Unsigned_Char_Vector, unsigned int Unsigned_Int_Vector[2][16], unsigned int Length_Usigned_Char_Vector)
{
	if (Length_Usigned_Char_Vector == 16)
	{
		unsigned char Unsingned_Char_Arry_Left[16] = { 0 };
		for (int i = 0; i < 4; i++)
		{
			for (int j = 0; j < 4; j++)
			{
				Unsingned_Char_Arry_Left[4 * j + i] = Unsigned_Int_Vector[0][4 * i + j];
			}
		}
		for (int Char_Count = 0; Char_Count < 8; Char_Count++)
		{
			*(Unsigned_Char_Vector + Char_Count) = (Unsingned_Char_Arry_Left[(Char_Count) * 2] << 5) ^ ((Unsingned_Char_Arry_Left[(Char_Count) * 2 + 1]) & 0x1f);
		}


		unsigned char Unsingned_Char_Arry_Right[16] = { 0 };
		for (int i = 0; i < 4; i++)
		{
			for (int j = 0; j < 4; j++)
			{
				Unsingned_Char_Arry_Right[4 * j + i] = Unsigned_Int_Vector[1][4 * i + j];
			}
		}
		for (int Char_Count = 8; Char_Count < 16; Char_Count++)
		{
			*(Unsigned_Char_Vector + Char_Count) = (Unsingned_Char_Arry_Right[((Char_Count - 8)) * 2] << 5) ^ ((Unsingned_Char_Arry_Right[(Char_Count - 8) * 2 + 1]) & 0x1f);
		}

	}

	else if (Length_Usigned_Char_Vector == 32)
	{
		unsigned int Unsingned_Char_Arry_Left[16] = { 0 };
		for (int i = 0; i < 4; i++)
		{
			for (int j = 0; j < 4; j++)
			{
				Unsingned_Char_Arry_Left[4 * j + i] = Unsigned_Int_Vector[0][4 * i + j];
			}
		}
		for (int Char_Count = 0; Char_Count < 16; Char_Count++)
		{
			if ((Char_Count % 2) == 0)
			{
				*(Unsigned_Char_Vector + Char_Count) = (Unsingned_Char_Arry_Left[Char_Count] << 1) ^ ((Unsingned_Char_Arry_Left[Char_Count + 1] & 0x100) >> 8);
			}
			else
			{
				*(Unsigned_Char_Vector + Char_Count) = Unsingned_Char_Arry_Left[Char_Count] & 0xff;
			}
		}


		unsigned int Unsingned_Char_Arry_Right[16] = { 0 };
		for (int i = 0; i < 4; i++)
		{
			for (int j = 0; j < 4; j++)
			{
				Unsingned_Char_Arry_Right[4 * j + i] = Unsigned_Int_Vector[1][4 * i + j];
			}
		}
		for (int Char_Count = 16; Char_Count < 32; Char_Count++)
		{
			if ((Char_Count % 2) == 0)
			{
				*(Unsigned_Char_Vector + Char_Count) = (Unsingned_Char_Arry_Right[Char_Count - 16] << 1) ^ ((Unsingned_Char_Arry_Right[Char_Count - 16 + 1] & 0x100) >> 8);
			}
			else
			{
				*(Unsigned_Char_Vector + Char_Count) = Unsingned_Char_Arry_Right[Char_Count - 16] & 0xff;
			}
		}

	}
	else
	{
		printf("\nERRO:Length Erro\n");
	}

}