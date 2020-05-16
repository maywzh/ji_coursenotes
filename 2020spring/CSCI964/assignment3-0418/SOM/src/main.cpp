#include "ClassesSOM.h"
#include "SOM.h"
#include </usr/local/include/eigen3/Eigen/eigen>
#include <fstream>
#include <iostream>
#include <sstream>
#include <stdlib.h> /* srand, rand */
#include <string>

using namespace std;

int main() {

  SOM test;
  test.ReadData("/Users/icortes/Desktop/SOMcpp/SOM/colorsInput.csv", 3000, 3);
  // test.ReadData("/Users/icortes/Desktop/SOMcpp/SOM/ThreeColors.txt", 3, 3);
  test.InitializeMap(50, 50);
  test.PrintToCSVFileRowWise(
      "/Users/icortes/Desktop/SOMcpp/SOM/SOMColorsBeforeTraining.csv",
      test.SOMMap, test.xsize, test.ysize, test.InputVectorSize);

  test.SigmaNeighbouringInitial = 25;
  test.SigmaNeighbourhoodFinal = 1;
  test.LearningRateInitial = 0.8;
  test.LearningRateFinal = 0.25;

  test.Train(100);
  test.PrintToCSVFileRowWise(
      "/Users/icortes/Desktop/SOMcpp/SOM/ColorsResults.csv", test.SOMMap,
      test.xsize, test.ysize, test.InputVectorSize);

  // std::cout << test.MaxValueInputData;

  std::cout << "lambda :" << test.lambda << "\n";
  std::cout << "L0 :" << test.LearningRateInitial << "\n";
  std::cout << "Sigma0 Neighbours:" << test.SigmaNeighbouringInitial << "\n";
  std::cout << "L :" << test.LearningRate << "\n";
  std::cout << "Sigma Neighbours:" << test.SigmaNeighbouring << "\n";
  return 0;
}