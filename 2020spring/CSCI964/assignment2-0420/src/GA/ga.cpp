/************************************************************
 *      ga.cpp - GA Program for CSCI964 - Ass2
 *      Written by: Koren Ward May 2010
 *      Modified by: maywzh
 *      Changes: maywzh
 *************************************************************/
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <string>
#include <vector>
#define EulerDist(a, b)                                                        \
  sqrt((a.x - b.x) * (a.x - b.x) * 1.0 + (a.y - b.y) * (a.y - b.y) * 1.0)

using namespace std;

const int cDebug = 0;

enum Xover { eRandom, eUniform, eOnePoint, eTwoPoint };

const Xover CrossoverType = eTwoPoint; //变异方式
const double cCrossoverRate = 0.75;    //杂交率
const double cMutationRate = 0.001;    //变异率
const int cNumGens = 150;              //世代数
const int cPopSize = 100; // 种群个体数 即城市路线的个数
const int cTournamentSize = 5;
const int Seed = 1234;
const int cTargetFitness = 80; //目标适应度
static int cIndividualLength;  //基因长度 即城市序列长度

void InitPop(int ***CrntPop, int ***NextPop, int **Fitness, int **BestMenber);
void FreeMem(int **CrntPop, int **NextPop, int *Fitness, int *BestMember);
int Tournament(int *Fitness, int TournamentSize);
int EvaluateFitness(int *Member);
void Crossover(int *P1, int *P2, int *C1, int *C2);
void Copy(int *P1, int *P2, int *C1, int *C2);
void Mutate(int *Member);
double Rand01();    // 0..1
int RandInt(int n); // 0..n-1

int NCity; //城市数

double **dist_map; // 两两城市间欧拉距离表
double **cost_map; // 两两城市间花费表
double sum = 0;    //当前最短路径长度
const double TypeCostMap[3][3] = {
    {10.0, 7.5, 5.0}, {7.5, 5.0, 2.5}, {5.0, 2.5, 1.0}};

//城市
struct city {
  int x;    //横坐标
  int y;    //纵坐标
  int type; //类型
};

// --------tool function-------
vector<city> citys; //城市列表

// // 城市间的欧拉距离
// double EulerDist(city &a, city &b) {
//   return sqrt((a.x - b.x) * (a.x - b.x) * 1.0 +
//               (a.y - b.y) * (a.y - b.y) * 1.0);
// }

// 计算一个基因序列的花费
double GetCostBetweenCity(int a, int b) {
  return dist_map[a][b] * TypeCostMap[citys[a].type - 1][citys[b].type - 1];
}

// [min, max] 之间随机数
int RandomBetween(int min, int max) {
  // srand((unsigned)time(NULL));
  return (rand() % (max - min + 1)) + min;
}

// 随机排列一个随机序列
void RandomArray(int *arr, int arrlen) {
  for (int i = arrlen - 1; i != 0; i--) {
    int j = RandomBetween(0, i);
    int tmp = arr[i];
    arr[i] = arr[j];
    arr[j] = tmp;
  }
}

string BoolToOut(bool flag) {
  if (flag)
    return "true";
  else
    return "false";
}

// 思路
//  在该问题中，每一条路径就是所谓的染色体（解的编码），每条路径的长度就是该个体的适应性（路径长度越短，适应性越强）。交叉操作就是选择两条路径，取一个分界点k，将两条路径分别以分界点k分成前后两段，并且将两条路径重新组合得到新的两条路径。这里的交叉操作蕴含了变异操作，但是能够让子代继承父代的优良特性。变异操作也是实现群体多样性的一种手段，也是全局寻优的保证，具体实现为，按照给定的变异率，对选定的变异的个体，随机的选取三个整数u

// blog.csdn.net/qq547276542/article/details/77805423
// Step1: 确定编码机制, 生成初始种群.
// 解决TSP问题通常采用城市序号对路径进行编码,
// 按照访问城市的顺序排列组成编码.
// Step2: 计算种群中每个个体的适应度值.
// TSP求解是要寻找使目标函数最小的个体, 因此选择适应度 函数fitness(i) =
// D/f(Ri) 设置常数𝐷, 防止路径值 过大而导致适应度函数倒数接近于0.
// 可以看出, 巡游路径越小, 适应度值越大. Step3: 选择算子.
// 通常采用精英个体保存策略和赌轮选择算子, 即适应度最高的个体一定被选择.
// 计算每个个体在整个种群适应度中的被选择概率和累计概率分别为
// p(i)=fitness(i)/sum(fitness(i)),Q(i)=sum(pj)
//通过随机数𝑟所在的区间范围选择遗传个体.
// Step4: 交叉算子. 由交叉概率𝑝𝑐 选择若干父体并进行配对,
// 按照交叉算法的规则生成新个体,
// 常用的规范方法有单点交叉、部分映射交叉、循环交叉等.
// Step5: 变异算子.
// 为了保持种群个体的多样性, 防止陷入局部最优, 需要按照某一变异概率pm
// 随机确定变异个体, 并实行相应变异操作, 通常采用逆序 变异算子.
// Step6:
// 迭代终止条件. 若满足预定的终止条件 (达到最大迭代次数), 则停止迭代,
// 所得的路径认为是 满意的路径; 否则, 转至Step2, 计算新一代种群中每
// 个个体的适应度值.

//===========================================================

// 读取以及初始化数据
// 初始化欧拉距离表
// 初始化
void LoadData(string filename) {
  ifstream fin;
  fin.open(filename);
  if (!fin.good()) {
    cout << "File not found!\n";
    exit(1);
  }
  fin >> NCity;
  cIndividualLength = NCity;
  dist_map = new double *[NCity];
  cost_map = new double *[NCity];
  for (int i = 0; i < NCity; i++) {
    city c;
    fin >> c.x >> c.y >> c.type;
    citys.push_back(c);
  }
  // Initialize the distance map
  for (int i = 0; i < NCity; i++) {
    dist_map[i] = new double[NCity];
    cost_map[i] = new double[NCity];
    for (int j = 0; j < NCity; j++) {
      dist_map[i][j] = EulerDist(citys[i], citys[j]);
      cost_map[i][j] =
          dist_map[i][j] * TypeCostMap[citys[i].type - 1][citys[j].type - 1];
    }
  }
}

//判定一个序列是否符合规则 每个点都只访问一次
bool Validate(int *arr, int num) {
  bool flag = true;
  short *bitmap = new short[num];

  for (int i = 0; i < num; i++)
    bitmap[i] = 0;
  for (int i = 0; i < num; i++) {
    if (bitmap[arr[i]] != 0) {
      flag = false;
      break;
    } else
      bitmap[arr[i]]++;
  }
  if (flag)
    for (int i = 0; i < num; i++)
      if (bitmap[i] == 0) {
        flag = false;
        break;
      }
  delete[] bitmap;
  return flag;
}

//计算一个序列的总长 由0出发到0结束
//接受 visit_order 0->1->4->13...->96  (len=cIndividualLength, 最后回到终点0
//总共是len段)
double CalTotalDistance(int *visit_order, int seqn) {
  double totdist = 0;
  for (int i = 0; i < seqn; i++) {
    if (i < seqn - 1) {
      totdist += cost_map[visit_order[i]][visit_order[i + 1]];
    } else {
      totdist += cost_map[visit_order[i]][visit_order[0]];
    }
  }
  return totdist;
}

//打印数据
void PrintData() {
  for (int i = 0; i < citys.size(); i++)
    cout << citys[i].x << citys[i].y << citys[i].type << endl;
}

// double Current_Dist(vector<city> &citys) {
//   double sum = 0;
//   for (int i = 1; i < citys.size(); i++) {
//     sum += dist_map[citys[i]][citys[i - 1]];
//   }
// }

//初始化种群 对每个个体（序列）随机一个不同的城市序列
void InitPop(int ***CrntPop, int ***NextPop, int **Fitness, int **BestMember) {
  int i, j, k;
  srand(Seed);
  //分配空间
  *CrntPop = new int *[cPopSize]; //当前种群
  *NextPop = new int *[cPopSize]; //下一个种群
  for (i = 0; i < cPopSize; i++) {
    (*CrntPop)[i] = new int[cIndividualLength];
    (*NextPop)[i] = new int[cIndividualLength];
  }
  *Fitness = new int[cPopSize]; //每个种群的个体都有适应度
  *BestMember = new int[cIndividualLength]; //最佳个体（走法）
  if (Fitness == NULL || BestMember == NULL)
    exit(1);
  //初始化序列 每个种群一个不同的序列
  for (i = 0; i < cPopSize; i++) {
    int seq[cIndividualLength - 1];
    // 设置0号节点为默认起始节点和终止节点
    // 重排后面的(cIndividualLength -1)个节点序
    for (j = 0; j < cIndividualLength - 1; j++) {
      seq[j] = j;
    }
    RandomArray(seq, cIndividualLength - 1);
    (*CrntPop)[i][0] = 0;
    for (j = 1; j < cIndividualLength; j++) {
      (*CrntPop)[i][j] = seq[j - 1] + 1;
    }
  }
}

//释放堆内存
void FreeMem(int **CrntPop, int **NextPop, int *Fitness, int *BestMenber) {
  for (int i = 0; i < cPopSize; i++) {
    delete[] CrntPop[i];
    delete[] NextPop[i];
  }
  for (int i = 0; i < NCity; i++) {
    delete[] dist_map[i];
    delete[] cost_map[i];
  }
  delete dist_map;
  delete cost_map;
  delete CrntPop;
  delete NextPop;
  delete Fitness;
  delete BestMenber;
}
//===========================================================

//评估Fitness 取路径长度T的倒数
int EvaluateFitness(int *Member) {
  // Evaluates fitness based on bit pattern
  int i;
  int TheFitness = 0;
  for (i = 0; i < cIndividualLength / 6; i++)
    TheFitness += Member[i] == 0;
  for (; i < cIndividualLength * 2 / 6; i++)
    TheFitness += Member[i] == 1;
  for (; i < cIndividualLength * 3 / 6; i++)
    TheFitness += Member[i] == 0;
  for (; i < cIndividualLength * 4 / 6; i++)
    TheFitness += Member[i] == 1;
  for (; i < cIndividualLength * 5 / 6; i++)
    TheFitness += Member[i] == 0;
  for (; i < cIndividualLength; i++)
    TheFitness += Member[i] == 1;
  return (TheFitness);
}
//================================================================

//旅行
int Tournament(int *Fitness, int TournamentSize) {
  int WinFit = -99999, Winner;
  for (int i = 0; i < TournamentSize; i++) {
    int j = RandInt(cPopSize);
    if (Fitness[j] > WinFit) {
      WinFit = Fitness[j];
      Winner = j;
    }
  }
  return Winner;
}

//交叉
void Crossover(int *P1, int *P2, int *C1, int *C2) {
  int i, Left, Right;
  switch (CrossoverType) {
  case eRandom: // swap random genes
    srand(Seed);
    for (i = 0; i < cIndividualLength; i++) {
      // 模拟杂交率命中
      if (RandInt(100) + 1 > 100 * cCrossoverRate) {
        C1[i] = P1[i];
        C2[i] = P2[i];
      } else {
        C1[i] = P2[i];
        C2[i] = P1[i];
      }
    }
    break;
  case eUniform: // swap odd/even genes
    for (i = 0; i < cIndividualLength; i++) {
      if (i % 2) {
        C1[i] = P1[i];
        C2[i] = P2[i];
      } else {
        C1[i] = P2[i];
        C2[i] = P1[i];
      }
    }
    break;
  case eOnePoint: // perform 1 point x-over
    Left = RandInt(cIndividualLength);
    if (cDebug) {
      printf("Cut points: 0 <= %d <= %d\n", Left, cIndividualLength - 1);
    }
    for (i = 0; i <= Left; i++) {
      C1[i] = P1[i];
      C2[i] = P2[i];
    }
    for (i = Left + 1; i < cIndividualLength; i++) {
      C1[i] = P2[i];
      C2[i] = P1[i];
    }
    break;
  case eTwoPoint: // perform 2 point x-over
    Left = RandInt(cIndividualLength - 1);
    Right = Left + 1 + RandInt(cIndividualLength - Left - 1);
    if (cDebug) {
      printf("Cut points: 0 <= %d < %d <= %d\n", Left, Right,
             cIndividualLength - 1);
    }
    for (i = 0; i <= Left; i++) {
      C1[i] = P1[i];
      C2[i] = P2[i];
    }
    for (i = Left + 1; i <= Right; i++) {
      C1[i] = P2[i];
      C2[i] = P1[i];
    }
    for (i = Right + 1; i < cIndividualLength; i++) {
      C1[i] = P1[i];
      C2[i] = P2[i];
    }
    break;
  default:
    printf("Invalid crossover?\n");
    exit(1);
  }
}

//变异
void Mutate(int *Member) {
  int Pick = RandInt(cIndividualLength); //取基因的某一个位置
  Member[Pick] = !Member[Pick];
}

void Copy(int *P1, int *P2, int *C1, int *C2) {
  for (int i = 0; i < cIndividualLength; i++) {
    C1[i] = P1[i];
    C2[i] = P2[i];
  }
}
//=================================================================
// return random between [0,1]
double Rand01() { // 0..1
  return (rand() / (double)(RAND_MAX));
}

// return random between [0, n-1]
int RandInt(int n) { return int(rand() / (double(RAND_MAX) + 1) * n); }

int main(int argc, char *argv[]) {

  int **CrntPop, **NextPop; // the crnt & next population lives here
  int *Fitness, BestFitness = 0, *BestMember; // fitness vars
  int i, TargetReached = false;
  string fname;
  cout << "Enter data filename:" << endl;
  cin >> fname;
  LoadData(fname);
  InitPop(&CrntPop, &NextPop, &Fitness, &BestMember);
  for (int Gen = 0; Gen < cNumGens; Gen++) {
    for (i = 0; i < cPopSize; i++) {

      // Evaluate the fitness of pop members
      Fitness[i] = EvaluateFitness(CrntPop[i]);
      if (BestFitness < Fitness[i]) { // save best member
        BestFitness = Fitness[i];
        for (int j = 0; j < cIndividualLength; j++)
          BestMember[j] = CrntPop[i][j];
        if (Fitness[i] >= cTargetFitness) {
          TargetReached = true;
          break;
        }
      }
    }
    if (TargetReached)
      break;

    // Produce the next population
    for (i = 0; i < cPopSize; i += 2) {
      int Parent1 = Tournament(Fitness, cTournamentSize);
      int Parent2 = Tournament(Fitness, cTournamentSize);
      if (cCrossoverRate > Rand01())
        Crossover(CrntPop[Parent1], CrntPop[Parent2], NextPop[i],
                  NextPop[i + 1]);
      else
        Copy(CrntPop[Parent1], CrntPop[Parent2], NextPop[i], NextPop[i + 1]);
      if (cMutationRate < Rand01())
        Mutate(NextPop[i]);
      if (cMutationRate < Rand01())
        Mutate(NextPop[i + 1]);
    }
    int **Tmp = CrntPop;
    CrntPop = NextPop;
    NextPop = Tmp;

    cout << setw(3) << Gen << ':' << setw(5) << BestFitness << endl;
  }
  if (TargetReached)
    cout << "Target fitness reached: " << BestFitness << "!\n";
  else
    cout << "Target fitness not reached: " << BestFitness << "!\n";
  cout << "Best Individual: ";
  for (i = 0; i < cIndividualLength; i++)
    cout << BestMember[i];
  cout << endl;
  FreeMem(CrntPop, NextPop, Fitness, BestMember);
  char s[20];
  cin.getline(s, 20);
  return 0;
}
