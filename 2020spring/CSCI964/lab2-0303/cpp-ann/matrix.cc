#include "matrix.h"
#include <iostream>
#include <limits.h>
#include <random>

using namespace std;

struct invalid_dimensions {};
Matrix::Matrix():
m{0}, n{0} {
	vector<vector<double>> tmp;
	for (int i = 0; i < m; ++i) {
		vector<double> row;
		for (int j = 0; j < n; ++j) {
			row.emplace_back(0);
		}
		tmp.emplace_back(row);
	}
	matrix = tmp;
}

Matrix::Matrix(vector<vector<double>> matrix):
matrix{matrix} {
	m = matrix.size();
	n = matrix[0].size();
}
Matrix::Matrix(int m, int n, vector<vector<double>> matrix):
m{m}, n{n}, matrix{matrix} {}

Matrix::Matrix(int m, int n):
m{m}, n{n} {
	vector<vector<double>> tmp;
	for (int i = 0; i < m; ++i) {
		vector<double> row;
		for (int j = 0; j < n; ++j) {
			row.emplace_back(0);
		}
		tmp.emplace_back(row);
	}

	matrix = tmp;
}

Matrix Matrix::operator+(const Matrix& other) const {
	if (m != other.m || n != other.n) {
		throw invalid_dimensions {};
	}

	Matrix result {m, n};
	for (int i = 0; i < m; ++i) {
		for (int j = 0; j < n; ++j) {
			result.matrix[i][j] = matrix[i][j] + other.matrix[i][j];
		}
	}

	return result;
}

double neg(double n) {
	return -n;
}

Matrix Matrix::operator-(const Matrix& other) const {
	Matrix tmp = other;
	tmp.apply(neg);

	return *this + tmp;;
}

Matrix Matrix::operator*(const Matrix& other) const {
	if (n != other.m) {
		throw invalid_dimensions {};
	}

	Matrix result {m, other.n};
	for (int i = 0; i < m; ++i) {
		for (int j = 0; j < other.n; ++j) {
			double sum = 0;
			for (int k = 0; k < n; ++k) {
				sum += matrix[i][k] * other.matrix[k][j];
			}
			result.matrix[i][j] = sum;
		}
	}

	return result;
}

Matrix Matrix::unitMultiply(const Matrix& other) const {
	if (m != other.m || n != other.n) {
		throw invalid_dimensions {};
	}

	Matrix result {m, n};
	for (int i = 0; i < m; ++i) {
		for (int j = 0; j < n; ++j) {
			result.matrix[i][j] = matrix[i][j] * other.matrix[i][j];
		}
	}

	return result;
}

Matrix Matrix::transpose() {
	Matrix result {n, m};
	for (int i = 0; i < m; ++i) {
		for (int j = 0; j < n; ++j) {
			result.matrix[j][i] = matrix[i][j];
		}
	}

	return result;
}

void Matrix::initNormal() {
	std::default_random_engine gen;
	std::normal_distribution<double> distribution(0.0, 1.0);
	for (int i = 0; i < m; ++i) {
		for (int j = 0; j < n; ++j) {
			matrix[i][j] = distribution(gen);
		}
	}
}

void Matrix::init(int sm, int sn, std::vector<std::vector<double>> &set_matrix) {
	m = sm;
	n = sn;
	for (int i = 0; i < sm; ++i)
	{
		for (int j = 0; j < sn; ++j) {
			matrix[i][j] = set_matrix[i][j];
		}
	}
}

double Matrix::sum() {
	double sum = 0;
	for (int i = 0; i < m; ++i) {
		for (int j = 0; j < n; ++j) {
			sum += matrix[i][j];
		}
	}

	return sum;
}

void Matrix::normalize() {
	double cur_max = INT_MIN;
	for (int i = 0; i < m; ++i) {
		for (int j = 0; j < n; ++j) {
			if (matrix[i][j] > cur_max) {
				cur_max = matrix[i][j];
			}
		}
	}

	for (int i = 0; i < m; ++i) {
		for (int j = 0; j < n; ++j) {
			matrix[i][j] /= cur_max;
		}
	}
}

int Matrix::getRows() {
	return m;
}

int Matrix::getCols() {
	return n;
}

vector<vector<double>> Matrix::getVector() {
	return matrix;
}

ostream& operator<<(ostream& out, const Matrix& mat) {
	for (int i = 0; i < mat.m; ++i) {
		for (int j = 0; j < mat.n; ++j) {
			out << mat.matrix[i][j] << " ";
		}
		out << endl;
	}

	return out;
}
