mlab_eig <- function(M) {
  # get the eigenvectors and eigenvalues of the covariance matrix
  eig <- eigen(M)  # calculate the eigenVv of the covariance of X
  # shift the columns in the eigenvectors as in Matlab
  V <- eig$vectors
  VV <- V[, 2:1]
  # square root of the diagonal of eigenvalues withut infinite
  eigen_values <- eig$values
  eigen_values_mlab <- rev(eigen_values)   # reverse the eigen values as in Matlab
  D <- diag(eigen_values_mlab)
  # DD <- diag((diag(D))^(-1/2))
  
  return(list(V = VV, D = D))
}


"%^%" <- function(x, n)
  # create a special operator for raising matrix to a power
  with(eigen(x), 
       vectors %*% 
         (values^n * t(vectors))
  )



segmentInf <- function(xs, ys, ...){
  # draw infinite line given two point coordinates
  fit <- lm(ys~xs)
  abline(fit, ...)
}


projectionMatrixLine <- function(M, ...) {
  # draw the projection line given the projection matrix of angle theta
  segmentInf(M[,1], M[,2], ...)
}


repmat <- function(a, n, m) {
  kronecker(matrix(1, n, m), a)
}
