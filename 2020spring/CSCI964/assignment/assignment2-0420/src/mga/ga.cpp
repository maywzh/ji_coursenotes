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

// ----------------------Macro----------------------
#define EulerDist(a, b)                                                        \
  sqrt((a.x - b.x) * (a.x - b.x) * 1.0 + (a.y - b.y) * (a.y - b.y) * 1.0)

#define Rand01() (rand() / (double)(RAND_MAX))
#define RandInt(r) (int(rand() / (double(RAND_MAX) + 1) * r))
#define RandomBetween(min, max) ((rand() % (max - min + 1)) + min)
#define Hit(p, r) (int(rand() / (double(RAND_MAX) + 1) * r) < p * r)
#define Bool(f) (f ? "True" : "False")
#define VisitCostBetweenCity(a, b)                                             \
  (dist_map[a][b] * TypeCostMap[citys[a].type - 1][citys[b].type - 1])
#define PrintLn(FORMAT, VALUE) printf(FORMAT "\n", VALUE)
// ----------------------Macro----------------------
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
const double cTargetFitness = 1.0 / 5000; //目标适应度
static int cIndividualLength;             //基因长度 即城市序列长度

void InitPop(int ***CrntPop, int ***NextPop, int **Fitness, int **BestMenber);
void FreeMem(int **CrntPop, int **NextPop, int *Fitness, int *BestMember);
int Tournament(int *Fitness, int TournamentSize);
int EvaluateFitness(int *Member);
double EvaluateFitness(int *visit_order, int len);
void Crossover(int *P1, int *P2, int *C1, int *C2);
void Copy(int *P1, int *P2, int *C1, int *C2);
void Mutate(int *Member);
// double Rand01(); // 0..1
// int RandInt(int n); // 0..n-1

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

// 随机排列一个随机序列
void RandomArray(int *arr, int arrlen) {
  for (int i = arrlen - 1; i != 0; i--) {
    int j = RandomBetween(0, i);
    int tmp = arr[i];
    arr[i] = arr[j];
    arr[j] = tmp;
  }
}

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
  fin >> cIndividualLength;
  dist_map = new double *[cIndividualLength];
  cost_map = new double *[cIndividualLength];
  for (int i = 0; i < cIndividualLength; i++) {
    city c;
    fin >> c.x >> c.y >> c.type;
    citys.push_back(c);
  }
  // Initialize the distance map
  for (int i = 0; i < cIndividualLength; i++) {
    dist_map[i] = new double[cIndividualLength];
    cost_map[i] = new double[cIndividualLength];
    for (int j = 0; j < cIndividualLength; j++) {
      dist_map[i][j] = EulerDist(citys[i], citys[j]);
      cost_map[i][j] = VisitCostBetweenCity(i, j);
    }
  }
}

// 以概率p命中 [0,r) 范围的数
// bool Hit(double p, int r) { return (RandInt(r) < r * p); }

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
void InitPop(int ***CrntPop, int ***NextPop, int **BestMember,
             double **Fitness) {
  int i, j, k;
  srand((unsigned)time(NULL));
  //分配空间
  *CrntPop = new int *[cPopSize]; //当前种群
  *NextPop = new int *[cPopSize]; //下一个种群
  for (i = 0; i < cPopSize; i++) {
    (*CrntPop)[i] = new int[cIndividualLength];
    (*NextPop)[i] = new int[cIndividualLength];
  }
  *Fitness = new double[cPopSize]; //每个种群的个体都有适应度
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
void FreeMem(int **CrntPop, int **NextPop, int *BestMenber, double *Fitness) {
  for (int i = 0; i < cPopSize; i++) {
    delete[] CrntPop[i];
    delete[] NextPop[i];
  }
  for (int i = 0; i < cIndividualLength; i++) {
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

// 计算适应度 为路径长度的倒数 越大越好
double EvaluateFitness(int *visit_order, int len) {
  // Evaluates fitness based on bit pattern
  int i;
  double TheFitness = 1 / CalTotalDistance(visit_order, len);
  return TheFitness;
}

//================================================================

//旅行
int Tournament(double *Fitness, int TournamentSize) {
  double WinFit = -99999;
  int Winner;
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
  return Crossover(P1, P2, C1, C2, cIndividualLength);
  // 去重
}

void Crossover(int *P1, int *P2, int *C1, int *C2, int len) {
  int i, Left, Right;
  int change[len];
  int bitmap[len]; //记录第i个城市所在位置
  for (int i = 0; i < len; i++) {
    change[i] = bitmap[i] = 0;
  }
  switch (CrossoverType) {
  case eRandom: // swap random genes 随机交叉
    srand((unsigned)time(NULL));
    for (i = 0; i < len; i++) {
      // 模拟杂交率命中
      if (!Hit(cCrossoverRate, 10000) || i == 0) { //未命中
        C1[i] = P1[i];
        C2[i] = P2[i];
        change[i] = 0;
      } else {
        C1[i] = P2[i];
        C2[i] = P1[i];
        change[i] = 1;
        bitmap[C1[i]] = i; // 把P2[i] 这个城市放在C1的i的位置
      }
    }
    break;
  case eUniform: // swap odd/even genes 奇偶交叉
    for (i = 0; i < len; i++) {
      if (i % 2) {
        C1[i] = P1[i];
        C2[i] = P2[i];
        change[i] = 0;

      } else {
        C1[i] = P2[i];
        C2[i] = P1[i];
        change[i] = 1;
        bitmap[C1[i]] = i;
      }
    }
    break;
  case eOnePoint:                // 右端交叉
    Left = RandInt(len - 2) + 1; //[1..n - 1]
    if (cDebug) {
      printf("Cut points: 0 <= %d <= %d\n", Left, len - 1);
    }
    for (i = 1; i <= Left; i++) {
      C1[i] = P1[i];
      C2[i] = P2[i];
      change[i] = 0;
    }
    for (i = Left + 1; i < len; i++) {
      C1[i] = P2[i];
      C2[i] = P1[i];
      change[i] = 1;
      bitmap[C1[i]] = i;
    }
    break;
  case eTwoPoint: // perform 2 point x-over 中间段交叉
    Left = 0;
    Right = len - 2;
    RandInt(len - 1);
    Right = Left + 1 + RandInt(len - Left - 1);
    if (cDebug) {
      printf("Cut points: 0 <= %d < %d <= %d\n", Left, Right, len - 1);
    }
    for (i = 0; i <= Left; i++) {
      C1[i] = P1[i];
      C2[i] = P2[i];
      change[i] = 0;
    }
    for (i = Left + 1; i <= Right; i++) {
      C1[i] = P2[i];
      C2[i] = P1[i];
      change[i] = 1;
      bitmap[C1[i]] = i;
    }
    for (i = Right + 1; i < len; i++) {
      C1[i] = P1[i];
      C2[i] = P2[i];
      change[i] = 0;
    }
    break;
  default:
    printf("Invalid crossover?\n");
    exit(1);
  }
  // 去重
  int sidx;
  for (int i = 1; i < len; i++)
    if (change[i] == 0) { //只考虑未被置换的段
      sidx = C1[i];
      //目标: 从C2置换段换出一个不冲突的位点
      while (bitmap[sidx] != 0) { //该城市已在队列中
        sidx = C2[bitmap[sidx]];
      }
      bitmap[sidx] = i;
      change[i] = 1;
      C2[i] = C1[i];
      C1[i] = sidx;
    }
}

// 轮盘赌 按概率选取适应度强的个体
void Select(int **curPop) {}

//变异
void Mutate(int *visit_order, int len) {
  double fit = EvaluateFitness(visit_order, len);
  double fitMutate = 0;
  int cp_visit_order[len];
  for (int i = 0; i < len; i++) {
    cp_visit_order[i] = visit_order[i];
  }
  while (fitMutate <= fit) {
    int a = RandInt(len), b, tmp;
    while (a == b)
      b = RandInt(len);

    tmp = cp_visit_order[a];
    cp_visit_order[a] = cp_visit_order[b];
    cp_visit_order[b] = tmp;
    fitMutate = EvaluateFitness(cp_visit_order, len);
  }
  for (int i = 0; i < len; i++) {
    visit_order[i] = cp_visit_order[i];
  }
}

// 由父母代直接拷贝到子女代
void Copy(int *P1, int *P2, int *C1, int *C2) {
  for (int i = 0; i < cIndividualLength; i++) {
    C1[i] = P1[i];
    C2[i] = P2[i];
  }
}
//=================================================================
// return random between [0,1]
// double Rand01() { // 0..1
//   return (rand() / (double)(RAND_MAX));
// }

// return random between [0, n-1]
// int RandInt(int n) { return int(rand() / (double(RAND_MAX) + 1) * n); }

int main(int argc, char *argv[]) {
  // int len = 7, i;
  // int sidx;
  // int P1[7] = {0, 1, 2, 3, 4, 5, 6};
  // int P2[7] = {0, 3, 2, 5, 4, 6, 1};
  // int C1[7] = {0}, C2[7] = {0};
  // int change[7] = {0};
  // int bitmap[7] = {0};
  // int Left = 1, Right = len - 2;
  // if (cDebug) {
  //   printf("Cut points: 0 < %d <= %d < %d\n", Left, Right, len);
  // }
  // for (i = 0; i < Left; i++) {
  //   C1[i] = P1[i];
  //   C2[i] = P2[i];
  //   change[i] = 0;
  // }
  // for (i = Left; i < Right; i++) {
  //   C1[i] = P2[i];
  //   C2[i] = P1[i];
  //   change[i] = 1;
  //   bitmap[C1[i]] = i;
  // }
  // for (i = Right; i < len; i++) {
  //   C1[i] = P1[i];
  //   C2[i] = P2[i];
  //   change[i] = 0;
  // }
  // for (int i = 0; i < len; i++) {
  //   cout << C1[i] << " ";
  // }
  // cout << endl;
  // for (int i = 0; i < len; i++) {
  //   cout << C2[i] << " ";
  // }
  // cout << endl;
  // for (int i = 0; i < len; i++) {
  //   cout << bitmap[i] << " ";
  // }
  // cout << endl;
  // for (int i = 0; i < len; i++) {
  //   cout << change[i] << " ";
  // }
  // cout << endl;
  // for (int i = 1; i < len; i++)
  //   if (change[i] == 0) { //只考虑未被置换的段
  //     sidx = C1[i];
  //     //目标: 从C2置换段换出一个不冲突的位点
  //     while (bitmap[sidx] != 0) { //该城市已在队列中
  //       sidx = C2[bitmap[sidx]];
  //     }
  //     bitmap[sidx] = i;
  //     change[i] = 1;
  //     C2[i] = C1[i];
  //     C1[i] = sidx;
  //   }
  // for (int i = 0; i < len; i++) {
  //   cout << C1[i] << " ";
  // }
  // cout << endl;
  // for (int i = 0; i < len; i++) {
  //   cout << C2[i] << " ";
  // }
  // cout << endl;

  // int **CrntPop, **NextPop; // the crnt & next population lives here
  // double *Fitness;          //越大越好
  // int BestFitness = 0;      //越大越好
  // int *BestMember;          // fitness individual
  // int i, TargetReached = false;
  // string fname;
  // cout << "Enter data filename:" << endl;
  // cin >> fname;
  // LoadData(fname);
  // InitPop(&CrntPop, &NextPop, &BestMember, &Fitness);
  // for (int Gen = 0; Gen < cNumGens; Gen++) {
  //   for (i = 0; i < cPopSize; i++) {

  //     // Evaluate the fitness of pop members
  //     Fitness[i] = EvaluateFitness(CrntPop[i], cIndividualLength);
  //     if (BestFitness < Fitness[i]) { // save best member
  //       BestFitness = Fitness[i];
  //       for (int j = 0; j < cIndividualLength; j++)
  //         BestMember[j] = CrntPop[i][j];
  //       if (Fitness[i] >= cTargetFitness) {
  //         TargetReached = true;
  //         break;
  //       }
  //     }
  //   }
  //   if (TargetReached)
  //     break;

  //   // Produce the next population
  //   for (i = 0; i < cPopSize; i += 2) {
  //     int Parent1 = Tournament(Fitness, cTournamentSize);
  //     int Parent2 = Tournament(Fitness, cTournamentSize);
  //     if (cCrossoverRate > Rand01())
  //       Crossover(CrntPop[Parent1], CrntPop[Parent2], NextPop[i],
  //                 NextPop[i + 1]);
  //     else
  //       Copy(CrntPop[Parent1], CrntPop[Parent2], NextPop[i], NextPop[i + 1]);
  //     if (cMutationRate < Rand01())
  //       Mutate(NextPop[i]);
  //     if (cMutationRate < Rand01())
  //       Mutate(NextPop[i + 1]);
  //   }
  //   int **Tmp = CrntPop;
  //   CrntPop = NextPop;
  //   NextPop = Tmp;

  //   cout << setw(3) << Gen << ':' << setw(5) << BestFitness << endl;
  // }
  // if (TargetReached)
  //   cout << "Target fitness reached: " << BestFitness << "!\n";
  // else
  //   cout << "Target fitness not reached: " << BestFitness << "!\n";
  // cout << "Best Individual: ";
  // for (i = 0; i < cIndividualLength; i++)
  //   cout << BestMember[i];
  // cout << endl;
  // FreeMem(CrntPop, NextPop, BestMember, Fitness);
  // char s[20];
  // cin.getline(s, 20);
  // return 0;
}
