#include <RcppEigen.h>
#include <Eigen/Dense>
#include <Eigen/Cholesky>

using namespace Eigen;
using namespace Rcpp;

// [[Rcpp::depends(RcppEigen)]]
// [[Rcpp::export]]
VectorXd xtSxMod(const MatrixXd& X, const MatrixXd& Sigma, const VectorXd& Y) {
  LLT<MatrixXd> chol = Sigma.llt();
  MatrixXd L = chol.matrixL();
  MatrixXd A = L.triangularView<Lower>().solve(X);
  int p(X.cols());
  MatrixXd XSX(MatrixXd(p, p).setZero().selfadjointView<Lower>().
              rankUpdate(A.adjoint())); // (X.adjoint())*SX;
  VectorXd XSY = (chol.solve(X).adjoint())*Y;
  VectorXd beta = XSX.ldlt().solve(XSY);
  return (beta);
}