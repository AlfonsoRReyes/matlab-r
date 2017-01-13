#include <RcppEigen.h>
#include <Eigen/Dense>
#include <Eigen/Cholesky>


using Eigen::Map;
using Eigen::MatrixXi;
// Map the integer matrix AA from R
const Map<MatrixXi> A(as<Map<MatrixXi> >(AA));
// evaluate and return the transpose of A
const MatrixXi
  At(A.transpose());
return wrap(At);