#include <RcppEigen.h>
#include <Eigen/Dense>
#include <Eigen/Cholesky>

using namespace Eigen;
using namespace Rcpp;

// [[Rcpp::depends(RcppEigen)]]
// [[Rcpp::export]]
VectorXd xtSx(const MatrixXd& X, const MatrixXd& Sigma, const VectorXd& Y) {
  MatrixXd SX = Sigma.llt().solve(X); // A\b by Cholesky's decomposition
  MatrixXd XSX = (X.adjoint())*SX;    // ldlt() for p.s.d. matrices
  VectorXd XSY = (SX.adjoint())*Y;    // llt() for p.d. matrices
  VectorXd beta = XSX.ldlt().solve(XSY);
  return (beta);
}
