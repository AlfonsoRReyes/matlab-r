# software-inspection




------
# Objective
Transform the origina data set to a diferent set of coordinates system to detect a pattern. In this example we will transform to spherical coordinates.



Loading the Matlab software array:

```r
library(R.matlab)

# read the Matlab array
software.mat <- readMat("../data/software.mat", fixNames = TRUE)
```


Names of the Matlab objects:

```r
names(software.mat)
```

```
[1] "prepsloc" "defsloc"  "mtgsloc"  "prepage"  "defpage" 
```

The file software.mat contains the preparation time in minutes (prepage, prepsloc), the total work hours in minutes for the meeting (mtgsloc), and the number of defects found (defpage, defsloc). 

The variables are normalized by the size of the inspection (the number of pages or SLOC – single lines of code).
 

```r
prepsloc <- software.mat$prepsloc
defsloc <- software.mat$defsloc
```



```r
plot(prepsloc, defsloc)
```

![](02-software-inspection_files/figure-html/unnamed-chunk-4-1.png)<!-- -->

## Transformation

the relationship between the variables is difficult to understand. 
We will plot first a log/log plot of the data.

### log/log plot


```r
# first data transformation
X = log(prepsloc)
Y = log(defsloc)

# plot the transformed data
plot(X, Y, 
     xlab = "Log PrepTime/SLOC",
     ylab = "Log Defects/SLOC"
)
```

![](02-software-inspection_files/figure-html/unnamed-chunk-5-1.png)<!-- -->

We now have a better idea of the relationship between these two variables.

_"Some transformations of the data may lead to insights or discovery of
structures that we might not otherwise see. However, as with any analysis,
we should be careful about creating something that is not really there, but is
just an artifact of the processing. Thus, in any application of EDA, the analyst
should go back to the subject area and consult domain experts to verify and
help interpret the results."_

## Sphering the data
This type of standardization called sphering pertains to multivariate data,
and it serves a similar purpose as the 1-D standardization methods given
above. The transformed variables will have a p-dimensional mean of 0 and a
covariance matrix given by the identity matrix.


### Multivariate normal


```r
n <- 100
mu <- c(-2, 2)
sigma <- matrix(c(1, 0.5, 0.5, 1), nrow = 2)
n
```

```
[1] 100
```

```r
mu
```

```
[1] -2  2
```

```r
sigma
```

```
     [,1] [,2]
[1,]  1.0  0.5
[2,]  0.5  1.0
```

Generating a 2-D multivariate normal:

```r
library(MASS)

set.seed(123)
head(X)
```

```
           [,1]
[1,] -0.7236064
[2,] -0.6161861
[3,] -0.6161861
[4,] -1.1664349
[5,] -0.8266786
[6,] -0.8266786
```

```r
X <- mvrnorm(n, mu, sigma)
#plot(X[, 1], X[, 2])
```

$Z_i = \Lambda^{(-1/2)} \; Q^T \; X_c^T$

where:

$\Lambda$  is the diagonal matrix whose diagonal elements are the corresponding eigenvalues of the matrix $A$.

$Q$ is the (eigenvectors) square (N×N) matrix whose $i^{th}$ column is the eigenvector $q_i$ of the matrix $A$.

Sphering the data using Matlab like functions:


```r
source("../matlab.R")

# read the matrix from Matlab table
x_table <- read.csv('table.csv', header = FALSE)

# convert to matrix
X <- as.matrix(x_table)
xbar <- colMeans(X)   # calculate the means of the columns

# get the eigenvectors and eigenvalues of the covariance matrix
eig <- mlab_eig(cov(X))  # calculate the eigenVv of the covariance of X
D <- eig$D
V <- eig$V

# center the data
Xc <- X - matrix(1, n, 1) %*% xbar

# Sphere the data
z <- D %^% (-1/2) %*% t(V) %*% t(Xc)  # using a custom built ^ operator
Z <- t(z)                             # transpose to plot

plot(Z[, 1], Z[, 2])
```

![](02-software-inspection_files/figure-html/unnamed-chunk-8-1.png)<!-- -->



Original code


```r
# read the matrix from Matlab table
x_table <- read.csv('table.csv', header = FALSE)

# convert to matrix
X <- as.matrix(x_table)
xbar <- colMeans(X)   # calculate the means of the columns

# get the eigenvectors and eigenvalues of the covariance matrix
eig <- eigen(cov(X))  # calculate the eigenVv of the covariance of X
# shift the columns in the eigenvectors as in Matlab
V <- eig$vectors
VV <- V[, 2:1]
# square root of the diagonal of eigenvalues withut infinite
eigen_values <- eig$values
eigen_values_mlab <- rev(eigen_values)   # reverse the eigen values as in Matlab
D <- diag(eigen_values_mlab)
DD <- diag((diag(D))^(-1/2))

# center the data
Xc <- X - matrix(1, n, 1) %*% xbar

# Sphere the data
z <- DD %*% t(VV) %*% t(Xc)
Z <-t(z)                    # transpose to plot

plot(Z[, 1], Z[, 2])
```

![](02-software-inspection_files/figure-html/unnamed-chunk-9-1.png)<!-- -->

What about creating a function to imitate what Matlab does with `eig()`


```r
source("../matlab.R")

# read the matrix from Matlab table
x_table <- read.csv('table.csv', header = FALSE)

# convert to matrix
X <- as.matrix(x_table)

eig_ret <- mlab_eig(cov(X))
eig_ret
```

```
$V
           [,1]      [,2]
[1,] -0.7327235 0.6805265
[2,]  0.6805265 0.7327235

$D
          [,1]    [,2]
[1,] 0.5899912 0.00000
[2,] 0.0000000 1.28509
```











array multiplication has direction:


```r
X <- matrix(rnorm(5*2), ncol=2)   # create matrix of 5x2
dim(X)
```

```
[1] 5 2
```

```r
xbar <- colMeans(X)
xbar
```

```
[1]  0.67498648 -0.05251753
```

```r
ones <- array(1, c(5,1))

ones %*% xbar
```

```
          [,1]        [,2]
[1,] 0.6749865 -0.05251753
[2,] 0.6749865 -0.05251753
[3,] 0.6749865 -0.05251753
[4,] 0.6749865 -0.05251753
[5,] 0.6749865 -0.05251753
```

```r
# xbar %*% ones   # will throw an error
```

Raising a matrix to a negative power:

```r
"%^%" <- function(x, n)
        with(eigen(x), 
             vectors %*% 
               (values^n * t(vectors))
             )

# Your toy example then becomes

m <- matrix(c(1, 0.4, 0.4, 1), nrow = 2) 

m %^% (-0.5)
```

```
           [,1]       [,2]
[1,]  1.0680744 -0.2229201
[2,] -0.2229201  1.0680744
```

Another example using the eigen vector of the problem

```r
d <- matrix(c(0.5899912, 0, 0, 1.28509), nrow = 2) 
d %^% (-0.5)
```

```
         [,1]      [,2]
[1,] 1.301899 0.0000000
[2,] 0.000000 0.8821313
```

Raising a matrix to a negative power:

```r
R <- matrix(c(0.5899912, 0, 0, 1.28509), nrow = 2) 
emat <- eigen( R )

emat$vectors %*% 
  diag(emat$values^(-1/2)) %*%
  t(emat$vectors)
```

```
         [,1]      [,2]
[1,] 1.301899 0.0000000
[2,] 0.000000 0.8821313
```

