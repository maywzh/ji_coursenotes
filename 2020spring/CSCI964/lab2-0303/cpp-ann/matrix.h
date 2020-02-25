#ifndef _MATRIX_H_
#define _MATRIX_H_
#include <vector>
#include <iostream>

class Matrix {
public:
	// constructors
	Matrix();
	Matrix(int m, int n, std::vector<std::vector<double> > matrix);
	Matrix(int m, int n); // zero matrix
	Matrix(std::vector<std::vector<double> > matrix); // zero matrix
	// applies a function over the entire matrix
	template<typename F> void apply(F f) {
		for (int i = 0; i < m; ++i) {
			for (int j = 0; j < n; ++j) {
				matrix[i][j] = f(matrix[i][j]);
			}
		}
	}

	// matrix operations
	Matrix operator+(const Matrix& other) const; // add
	Matrix operator-(const Matrix& other) const; // subtract
	Matrix operator*(const Matrix& other) const; // matrix multiplication
	
	Matrix unitMultiply(const Matrix& other) const;
	Matrix transpose();

	// stream operator
	friend std::ostream& operator<<(std::ostream& out, const Matrix& matrix);

	// randomizations
	void initNormal();
	void init(int m, int n, std::vector<std::vector<double> > &matrix);
	// misc operations
	double sum();
	void normalize();

	// accessors
	int getRows();
	int getCols();
	std::vector<std::vector<double> > getVector();

private:
	int m, n;
	std::vector<std::vector<double> > matrix;
};

#endif