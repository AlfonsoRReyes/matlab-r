#include <RcppArmadillo.h>   

// [[Rcpp::depends(RcppArmadillo)]] 

// [[Rcpp::export]]   
arma::vec getEigen(arma::mat M) { 
  return arma::eig_sym(M);      
} 

