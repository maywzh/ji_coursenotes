#include <fstream>
#include <iostream>
#include <math.h>
#include <sstream>
#include <stdlib.h>
#include <string>
#include <time.h>

using namespace std;

#define m 6
#define n 6
#define som_sum 36

void readdata(float data[][4]) {
  ifstream infile;
  infile.open("./SOM_MNIST_data.txt");
  for (int i = 0; i < 28; i++) {
    for (int j = 0; j < 28; j++) {
      infile >> data[i][j];
    }
  }
  infile.close();
}

void InitializeRandoms(float Arr[som_sum][1000]) {
  int i = 0, j = 0;
  srand(time(NULL));

  for (i = 0; i < som_sum; ++i) {
    for (j = 0; j < 28; ++j) {
      Arr[i][j] = (rand() % 1000) / 1000.000;
    }
  }
}

void print_data(float data[][4]) {
  int i, j;
  for (i = 0; i < 28; i++) {
    for (j = 0; j < 28; j++) {
      printf("%6.4f ", data[i][j]);
    }
    printf("\n");
  }
}

void ind2sub(int *I, int *J) {
  int i, j;
  int count = 0;
  for (j = 0; j < n; j++) {
    for (i = 0; i < m; i++) {
      I[count] = i;
      J[count] = j;
      count++;
    }
  }

  for (int z = 0; z < som_sum; z++)
    printf("%d ", I[z]);
  printf("\n");
  for (int z = 0; z < som_sum; z++)
    printf("%d ", J[z]);
  printf("\n");
}

int main() {
  int data_row, data_clown;
  float learn0 = 0.6;
  float learn_rate = learn0;
  int learn_para = 1000;
  int iter = 8000;
  int neighbor0 = 2;
  int neighbor_redius = neighbor0;
  int neighbor_para = 1000 / log(neighbor0);
  int I[1000] = {0};
  int J[1000] = {0};
  int i, j;
  float data[13][4] = {0};
  float data_x[4] = {0};
  float Arr[som_sum][1000] = {0};
  float min;
  int min_num;
  float summ[40];
  int x, y;

  readdata(data);
  print_data(data);
  InitializeRandoms(Arr);
  ind2sub(I, J);

  for (int tt = 1; tt <= iter; tt++) {
    for (i = 0; i < 13; i++) {
      for (j = 0; j < 4; j++) {
        data_x[j] = data[i][j];
      }
      for (int t = 0; t <= som_sum; t++) // 36��
      {
        float sum = 0;
        for (int e = 0; e < 4; e++) {
          float mul = (data_x[e] - Arr[t][e]) * (data_x[e] - Arr[t][e]);
          sum = sum + mul;
        }
        if (t == 0) {
          min = sqrt(sum);
          min_num = 1;
        } else {
          if (sqrt(sum) < min) {
            min = sqrt(sum);
            min_num = t;
          }
        }
      }
      x = I[min_num];
      y = J[min_num];

      int A[som_sum][2];
      int B[som_sum][2];
      int C[som_sum][2];
      int D[som_sum];
      double distance_som[som_sum];

      for (int a = 0; a < som_sum; a++) {
        A[a][0] = I[a];
        B[a][0] = x;
        C[a][0] = (A[a][0] - B[a][0]) * (A[a][0] - B[a][0]);

        A[a][1] = J[a];
        B[a][1] = y;
        C[a][1] = (A[a][1] - B[a][1]) * (A[a][1] - B[a][1]);
        D[a] = C[a][0] + C[a][1];
        distance_som[a] = exp(D[a] / (-2) * neighbor_redius * neighbor_redius);
      }

      for (j = 0; j < som_sum; j++) {
        for (int a = 0; a < 4; a++) {
          Arr[j][a] = Arr[j][a] +
                      learn_rate * (distance_som[j] * (data_x[a] - Arr[j][a]));
        }
      }
    }

    learn_rate = learn0 * exp(-tt / learn_para);
    neighbor_redius = neighbor_redius * exp(-tt / neighbor_para);
  }
}
