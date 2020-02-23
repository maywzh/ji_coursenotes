#include <iostream>
using namespace std;

class Ann {
public:
	explicit Ann(int _SampleN, int nNIL, int nNOL, const int nNHL, float _sR = 0):
	SampleCount(_SampleN), numNodesInputLayer(nNIL), numNodesOutputLayer(nNOL),
	numNodesHiddenLayer(nNHL), studyRate(_sR){

        // 创建权值空间，并初始化
        srand(time(NULL));
        weights = new double**[2];
        weights[0] = new double *[numNodesInputLayer];
        for (int i = 0; i < numNodesInputLayer; ++i) {
            weights[0][i] = new double[numNodesHiddenLayer];
            for (int j = 0; j < numNodesHiddenLayer; ++j) {
                weights[0][i][j] = (rand() % (2000) / 1000.0 - 1);
            }
        }

        weights[1] = new double *[numNodesHiddenLayer];
        for (int i = 0; i < numNodesHiddenLayer; ++i) {
            weights[1][i] = new double[numNodesOutputLayer];
            for (int j = 0; j < numNodesOutputLayer; ++j) {
                weights[1][i][j] = (rand() % (2000) / 1000.0 - 1);
            }
        }

        // 创建偏置空间，并初始化
        bias = new double *[2];
        bias[0] = new double[numNodesHiddenLayer];
        for (int i = 0; i < numNodesHiddenLayer; ++i) {
            bias[0][i] = (rand() % (2000) / 1000.0 - 1);
        }
        bias[1] = new double[numNodesOutputLayer];
        for (int i = 0; i < numNodesOutputLayer; ++i) {
            bias[1][i] = (rand() % (2000) / 1000.0 - 1);
        }

        //创建隐藏层各结点的输出值空间
        hidenLayerOutput = new double[numNodesHiddenLayer];
        //创建输出层各结点的输出值空间
        outputLayerOutput = new double[numNodesOutputLayer];

        //创建所有样本的权值更新量存储空间
        allDeltaWeights = new double ***[_SampleN];
        for (int k = 0; k < _SampleN; ++k) {
            allDeltaWeights[k] = new double**[2];
            allDeltaWeights[k][0] = new double *[numNodesInputLayer];
            for (int i = 0; i < numNodesInputLayer; ++i) {
                allDeltaWeights[k][0][i] = new double[numNodesHiddenLayer];
            }
            allDeltaWeights[k][1] = new double *[numNodesHiddenLayer];
            for (int i = 0; i < numNodesHiddenLayer; ++i) {
                allDeltaWeights[k][1][i] = new double[numNodesOutputLayer];
            }
        }

        //创建所有样本的偏置更新量存储空间
        allDeltaBias = new double **[_SampleN];
        for (int k = 0; k < _SampleN; ++k) {
            allDeltaBias[k] = new double *[2];
            allDeltaBias[k][0] = new double[numNodesHiddenLayer];
            allDeltaBias[k][1] = new double[numNodesOutputLayer];
        }

        //创建存储所有样本的输出层输出空间
        outputMat = new double*[_SampleN];
        for (int k = 0; k < _SampleN; ++k) {
            outputMat[k] = new double[numNodesOutputLayer];
        }
    }
	~Ann();
	void train(int _sampleNum, float** _trainMat, int** _labelMat);
	void predict(float* in, float* proba);

private:
	int numNodesInputLayer;
	int numNodesOutputLayer;
	int numNodesHiddenLayer;
	int SampleCount;   // 总的训练样本数
	double ***weights;  // 网络权值
	double **bias;      // 网络偏置
	float studyRate;    // 学习率

	double *hidenLayerOutput;     //隐藏层各结点的输出值
	double *outputLayerOutput;     //输出层各结点的输出值

	double ***allDeltaBias;        //所有样本的偏置更新量
	double ****allDeltaWeights;    //所有样本的权值更新量
	double **outputMat;            //所有样本的输出层输
	
	void train_vec(const float* _trainVec, const int* _labelVec, int index);
	double sigmod(double x) { return 1 / (1 + exp(-1 * x)); }
	bool isNotConver(const int _sampleNum, int** _labelMat, double _thresh);

};