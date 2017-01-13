#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
int fibCpp(const int n) {
  if(n == 0){
    return(0);
  } else if(n == 1){
    return(1);
  } else {
    return(fibCpp(n-1) + fibCpp(n-2));
  }
}
