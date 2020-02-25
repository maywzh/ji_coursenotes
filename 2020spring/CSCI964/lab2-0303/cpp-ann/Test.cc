#include <iostream>
#include <eigen3/Eigen/Dense>
using namespace Eigen;
using namespace std;
int main()
{
    MatrixXd m1(2, 3);
    MatrixXd m2(3, 2);
    m1 << 1, 1, 1,
        2, 2, 2;
    m2 << 1, 1,
        2, 2,
        3, 3;
    std::cout << m1 * m2 << endl;
}
