
SEXP CppSamp(SEXP X_) {
  typedef Eigen::ArrayXd   Ar1;
  typedef Eigen::ArrayXXd  Ar2;
  typedef Eigen::Map<Ar2> MAr2;
  
  const MAr2 X(as<MAr2>(X_));
  int m(X.rows()), n(X.cols()), nm1(n – 1);
  Ar1     samp(m);
  RNGScope sc; // Handle GetRNGstate()/PutRNGstate()
  for (int i=0; i < m; ++i) {
    Ar1 ri(X.row(i));
    std::partial_sum(ri.data(), ri.data() + n, ri.data())
      ri /= ri[nm1];    // normalize to sum to 1
    samp[i] = (ri < ::unif_rand()).count() + 1;
  }
  return wrap(samp);
}