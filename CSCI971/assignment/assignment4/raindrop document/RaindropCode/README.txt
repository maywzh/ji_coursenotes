1、raindrop.h 头文件中包含密钥生成算法中的轮函数，即OperationA、OperationB;以及将unsigned char 类型的数组转换成unsigned int类型的数组，便于将明文放入4*4的状态中；以及将unsigned int类型的数组转换成unsigned char类型的数组，便于将4*4状态的密文转换成unsigned char类型；以及二进制数组与unsigned int类型相互转化的函数。
2、Raindrop.c 是主函数，包含加密算法的轮函数（128-128、128-256、256-256）；以及密钥生成算法；三个要求的加密、解密、按要求轮数加密的函数接口；主函数中的程序为测试程序，会输出每一轮的状态。（！！！注意：运行之前要检查最开始的宏定义，即#define Enc_Round 60，60为轮数，在运行任何版本加密算法之前，要先确认轮数。例：想要加密128-256版本，加密45轮，需要将宏定义改成#define Enc_Round 45；
3、TestVector 是测试向量，包括加密与解密，建议不要用记事本打开，可以采用Notepad打开查看。
                                      
		      