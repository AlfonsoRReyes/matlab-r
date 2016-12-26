#include <Rcpp.h>
#include <cmath>

// suncc needs help to disambiguate between sqrt( float ) and sqrt(double) 
inline static double sqrt_double(double x) { return ::sqrt(x); }

using namespace Rcpp; 

// [[Rcpp::export]]
List MatrixExample(const NumericMatrix & orig) {
  NumericMatrix mat(orig.nrow(), orig.ncol());	
  
  // we could query size via
  //   int n = mat.nrow(), k=mat.ncol();
  // and loop over the elements, but using the STL is so much nicer
  // so we use a STL transform() algorithm on each element
  std::transform(orig.begin(), orig.end(), mat.begin(), sqrt_double );
  
  return List::create(Named("result") = mat, 
                      Named("original") = orig);
}