#include <Rcpp.h>
using namespace Rcpp;

int fibCpp(const int n) {
  if(n == 0){
    return(0);
  } else if(n == 1){
    return(1);
  } else {
    return(fibCpp(n-1) + fibCpp(n-2));
  }
}

extern "C" SEXP fibWrapper(SEXP ns) {
  int n = Rcpp::as<int>(ns);
  int fib = fibCpp(n);
  return(Rcpp::wrap(fib));
}
