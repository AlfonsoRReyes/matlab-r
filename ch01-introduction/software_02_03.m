% First generate some 2-D multivariate normal
% random variables, with mean MU and 
% covariance SIGMA. This uses a Statistics
% Toolbox function.

% make the example reproducible
randn('state', 123)

n = 100;
mu = [-2, 2];
sigma = [1,.5;.5,1];
X = mvnrnd(mu,sigma,n);
% plot(X(:,1),X(:,2),'.')

#writetable(X, 'table.txt')
#type('table.txt')

% Now sphere the data.
xbar = mean(X);
% Get the eigenvectors and eigenvalues of the 
% covariance matrix.
[V,D] = eig(cov(X));
% Center the data.
Xc = X - ones(n,1)*xbar;
% Sphere the data.
E = V' * Xc';
Z = ((D)^(-1/2)*E)';
plot(Z(:,1),Z(:,2),'.')