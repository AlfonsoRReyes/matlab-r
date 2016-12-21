% First generate some 2-D multivariate normal
% random variables, with mean MU and 
% covariance SIGMA. This uses a Statistics
% Toolbox function.
n = 100;
mu = [-2, 2];
sigma = [1,.5;.5,1];
X = mvnrnd(mu,sigma,n);
plot(X(:,1),X(:,2),'.')