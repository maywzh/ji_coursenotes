/************************************************************
 *      ga.cpp - GA Program for CSCI964 - Ass2
 *      Written by: Koren Ward May 2010
 *      Modified by: maywzh
 *      Changes: maywzh
 *************************************************************/

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
#include "math.h"
#include "time.h"
#include <fstream>
#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <vector>
using namespace std;

#define MAXVALUE 10000000 //路径最大值上限

#define MaxEpoc 900000
#define pcross 0.65    // 0.5
#define pmutation 0.09 // 0.05
#define POPSIZE 4000   // 500

#define N 100000 //需要根据实际求得的路径值修正
unsigned seed = (unsigned)time(0);
vector<double> Hash;

int city_num_t = 0;
int CITY_NUM;

double cost_matrix[3][3] = {10, 7.5, 5, 7.5, 5, 2.5, 5, 2.5, 1};

typedef struct City {
  double x;
  double y;
  int type;
} City;

vector<City> CitySequence;

//城市带权欧拉距离
vector<vector<double>> CityDistance;

typedef struct {
  vector<vector<int>> colony; // int colony[POPSIZE][CITY_NUM +1]; 首尾都是0
  double fitness[POPSIZE];  // 每个个体的适应值，即1/Distance[POPSIZE]
  double Distance[POPSIZE]; //每个个体的总路径
  vector<int> BestRooting; // int BestRooting[CITY_NUM + 1];//最优城市路径序列
  double BestFitness; //最优路径适应值
  double BestValue;   //最优路径长度
  int BestNum;
} TSP, *PTSP;

//计算城市距离带权词典
void CalDistance() {
  int i, j;
  double temp1, temp2;
  for (i = 0; i < CITY_NUM; i++) {
    vector<double> v_tmp;
    for (j = 0; j < CITY_NUM; j++) { //最后一个城市还应该返回到出发节点
      temp1 = CitySequence[j].x - CitySequence[i].x;
      temp2 = CitySequence[j].y - CitySequence[i].y;
      int type_city_i = CitySequence[i].type;
      int type_city_j = CitySequence[j].type;
      double per_cost = cost_matrix[type_city_i][type_city_j];
      v_tmp.push_back((sqrt(temp1 * temp1 + temp2 * temp2) * per_cost));
    }
    CityDistance.push_back(v_tmp);
  }
}

// 复制数组
void Copy(int a[], int b[]) {
  int i = 0;
  for (i = 0; i < CITY_NUM + 1; i++) {
    a[i] = b[i];
  }
}

// 复制数组
void Copy(vector<int> &a, vector<int> b) { a = b; }

// 检查合法性序列
bool check(TSP &city, int pop, int num, int k) {
  int i;
  for (i = 0; i <= num; i++) {
    if (k == city.colony[pop][i])
      return true; //新生成节点存在于已经生成的路径中
  }
  return false; //新生成节点没有存在于已经生成的路径中
}

// 初始化种群
void InitColony(TSP &city) {
  int i, j, r;
  for (i = 0; i < POPSIZE; i++) {
    city.colony[i][0] = 0;
    city.colony[i][CITY_NUM] = 0;
    city.BestValue = MAXVALUE;
    city.BestFitness = 0; //适应值越大越好
  }

  for (i = 0; i < POPSIZE; i++) {
    for (j = 1; j < CITY_NUM; j++) {
      r = rand() % (CITY_NUM - 1) + 1; //产生1～CITY_NUM-1之间的随机数
      while (check(city, i, j, r)) //随机产生城市序号，即为city.colony[i][j]赋值
      {
        r = rand() % (CITY_NUM - 1) + 1;
      }

      city.colony[i][j] = r;
    }
  }
}

//个体适应度
void CalFitness(TSP &city) {
  int i, j;
  int start, end;
  int Best = 0;
  for (i = 0; i < POPSIZE; i++) { //求每个个体的总路径，适应值
    city.Distance[i] = 0;
    for (j = 1; j <= CITY_NUM; j++) {
      start = city.colony[i][j - 1];
      end = city.colony[i][j];
      city.Distance[i] =
          city.Distance[i] +
          CityDistance[start][end]; // city.Distance[i]每个个体的总路径
    }
    city.fitness[i] = N / city.Distance[i];
    if (city.fitness[i] >
        city.fitness[Best]) //选出最大的适应值，即选出所有个体中的最短路径
      Best = i;
  }
  Copy(city.BestRooting, city.colony[Best]); //将最优个体拷贝给city.BestRooting
  city.BestFitness = city.fitness[Best];
  city.BestValue = city.Distance[Best];
  city.BestNum = Best;
}

// 轮盘赌选择法
void Select(TSP &city) {
  vector<vector<int>> TempColony;
  TempColony.resize(POPSIZE);
  for (int i = 0; i < POPSIZE; i++) {
    TempColony[i].resize(CITY_NUM + 1);
  }

  int i, j, t;
  double s;
  double GaiLv[POPSIZE];
  double SelectP[POPSIZE + 1];
  double avg;
  double sum = 0;
  for (i = 0; i < POPSIZE; i++) {
    sum += city.fitness[i];
  }
  for (i = 0; i < POPSIZE; i++) {
    GaiLv[i] = city.fitness[i] / sum;
  }
  SelectP[0] = 0;
  for (i = 0; i < POPSIZE; i++) {
    SelectP[i + 1] = SelectP[i] + GaiLv[i] * RAND_MAX;
  }
  TempColony[0] = city.colony[city.BestNum];

  for (t = 1; t < POPSIZE; t++) {
    double ran = rand() % RAND_MAX + 1;
    s = (double)ran / 100.0;
    for (i = 1; i < POPSIZE; i++) {
      if (SelectP[i] >= s)
        break;
    }
    TempColony[t] = city.colony[i - 1];
    // memcpy(TempColony[t], city.colony[i - 1], sizeof(TempColony[t]));
  }
  for (i = 0; i < POPSIZE; i++) {
    city.colony[i] = TempColony[i];
    //        memcpy(city.colony[i], TempColony[i], sizeof(TempColony[i]));
  }
}

// 交叉
// 城市 概率
void Cross(TSP &city, double pc) {
  int i, j, t, l;
  int a, b, ca, cb;

  vector<int> Temp1;
  Temp1.resize(CITY_NUM + 1);

  vector<int> Temp2;
  Temp2.resize(CITY_NUM + 1);

  //    int Temp1[CITY_NUM + 1], Temp2[CITY_NUM + 1];
  for (i = 0; i < POPSIZE; i++) {
    double s = ((double)(rand() % RAND_MAX)) / RAND_MAX;
    if (s < pc) {
      cb = rand() % POPSIZE;
      ca = cb;
      if (ca == city.BestNum || cb == city.BestNum)
        continue;

      l = rand() % 19 + 1;             // 1-19
      a = rand() % (CITY_NUM - l) + 1; // 1-37

      vector<double> abc(CITY_NUM);
      Hash = abc;

      Temp1[0] = Temp1[CITY_NUM] = 0;
      for (j = 1; j <= l; j++) {
        Temp1[j] = city.colony[cb][a + j - 1];
        Hash[Temp1[j]] = 1;
      }
      for (t = 1; t < CITY_NUM; t++) {
        if (Hash[city.colony[ca][t]] == 0) {
          Temp1[j++] = city.colony[ca][t];
          Hash[city.colony[ca][t]] = 1;
        }
      }
      city.colony[ca] = Temp1;
    }
  }
}

// 计算适应度
double GetFittness(int a[]) {
  int i, start, end;
  double Distance = 0;
  for (i = 0; i < CITY_NUM; i++) {
    start = a[i];
    end = a[i + 1];
    Distance += CityDistance[start][end];
  }
  return N / Distance;
}

// 计算适应度
double GetFittness(vector<int> a) {
  int i, start, end;
  double Distance = 0;
  for (i = 0; i < CITY_NUM; i++) {
    start = a[i];
    end = a[i + 1];
    Distance += CityDistance[start][end];
  }
  return N / Distance;
}

//变异
void Mutation(TSP &city, double pm) {
  int i, k, m;
  vector<int> Temp;
  Temp.resize(CITY_NUM + 1);
  //    int Temp[CITY_NUM + 1];
  for (k = 0; k < POPSIZE; k++) {
    double s = ((double)(rand() % RAND_MAX)) / RAND_MAX; //随机产生概率0~1间
    i = rand() % POPSIZE;            //随机产生0~POPSIZE之间的数
    if (s < pm && i != city.BestNum) // i!=city.BestNum，即保证最优的个体不变异
    {
      int a, b, t;
      a = (rand() % (CITY_NUM - 1)) + 1;
      b = (rand() % (CITY_NUM - 1)) + 1;
      Copy(Temp, city.colony[i]);
      if (a > b) //保证让b>=a
      {
        t = a;
        a = b;
        b = t;
      }
      for (m = a; m < (a + b) / 2; m++) {
        t = Temp[m];
        Temp[m] = Temp[a + b - m];
        Temp[a + b - m] = t;
      }

      if (GetFittness(Temp) < GetFittness(city.colony[i])) {
        a = (rand() % (CITY_NUM - 1)) + 1;
        b = (rand() % (CITY_NUM - 1)) + 1;
        // Copy(Temp,city.colony[i]);
        Temp = city.colony[i];
        if (a > b) {
          t = a;
          a = b;
          b = t;
        }
        for (m = a; m < (a + b) / 2; m++) {
          t = Temp[m];
          Temp[m] = Temp[a + b - m];
          Temp[a + b - m] = t;
        }

        if (GetFittness(Temp) < GetFittness(city.colony[i])) {
          a = (rand() % (CITY_NUM - 1)) + 1;
          b = (rand() % (CITY_NUM - 1)) + 1;
          // Copy(Temp,city.colony[i]);
          Temp = city.colony[i];
          //                    memcpy(Temp, city.colony[i], sizeof(Temp));
          if (a > b) {
            t = a;
            a = b;
            b = t;
          }
          for (m = a; m < (a + b) / 2; m++) {
            t = Temp[m];
            Temp[m] = Temp[a + b - m];
            Temp[a + b - m] = t;
          }
        }
      }
      city.colony[i] = Temp;
      //            memcpy(city.colony[i], Temp, sizeof(Temp));
    }
  }
}

void PrintOut(TSP &city) {
  int i, j;
  printf("best path:\n");
  for (i = 0; i <= CITY_NUM; i++)
    printf("%5d", city.BestRooting[i]);
  printf("\nbest path cost：%f\n", (city.BestValue));
}

City Split(const string &str, const string delim) {
  City city_tmp;
  vector<int> res;
  if ("" == str)
    return city_tmp;
  //先将要切割的字符串从string类型转换为char*类型
  char *strs = new char[str.length() + 1]; //不要忘了
  strcpy(strs, str.c_str());

  char *d = new char[delim.length() + 1];
  strcpy(d, delim.c_str());

  char *p = strtok(strs, d);
  while (p) {
    string s = p; //分割得到的字符串转换为string类型
    int num = atoi(s.c_str());
    res.push_back(num); //存入结果数组
    p = strtok(NULL, d);
  }
  city_tmp = {double(res[0]), double(res[1]), int(res[2])};
  return city_tmp;
}

bool Init(string path_txt, vector<City> &v_city_pos) {
  fstream infile(path_txt);
  string txt_content;
  int cnt = 0;
  while (getline(infile, txt_content)) {
    if (0 == cnt) {
      city_num_t = stoi(txt_content);
    } else {
      City city_tmp = Split(txt_content, " ");
      v_city_pos.push_back(city_tmp);
    }
    cnt += 1;
  }
  if (cnt < 2) {
    return false;
  }

  CITY_NUM = city_num_t;
  Hash.resize(CITY_NUM);

  return true;
}

int main() {
  string filename;
  cout << "Enter File Name:" << endl;
  getline(cin, filename);

  Init(filename, CitySequence);

  TSP city;
  city.colony.resize(POPSIZE);
  for (int i = 0; i < POPSIZE; i++) {
    city.colony[i].resize(CITY_NUM + 1);
  }
  city.BestRooting.resize(CITY_NUM + 1);

  int i;
  srand(seed);
  CalDistance();
  InitColony(city);
  CalFitness(city);

  for (i = 0; i < MaxEpoc; i++) {

    Select(city);              //选择(复制)：轮盘赌法
    Cross(city, pcross);       //交叉
    Mutation(city, pmutation); //变异
    CalFitness(city);          //计算适应值
    if (i % 2000 == 0) {
      cout << "step=" << i << endl;
      PrintOut(city);
    }
  }

  cout << "Optimised Data!" << endl;
  PrintOut(city); //输出
  return 0;
}
