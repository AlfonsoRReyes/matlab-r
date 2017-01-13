#include <Rcpp.h>
#include <cmath>        // std::exp(double)
#include <valarray>     // std::valarray, std::exp(valarray)

using namespace Rcpp;

// [[Rcpp::export]]
NumericVector dnormCpp(NumericVector x, double mu, double sigma) {
   // const double MYPI = 3.141592;
   // I think PI is available in cmath
   int n = x.size();
   NumericVector d(n);
   NumericVector ret(n);
   for(int i = 0; i < n; i++){
     d[i] = (x[i] - mu)/sigma;
     d[i] *= d[i];
     ret[i] = exp(-0.5*d[i])/(sqrt(2*PI)*sigma);
   }
   return(ret);
}
