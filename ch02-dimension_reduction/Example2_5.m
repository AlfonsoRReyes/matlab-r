% Example 2.5
% In this example, we illustrate intrinsic dimensionality. 

% Draw the figure.
theta = 0:.1:4*pi;
x = cos(theta);
y = sin(theta);
z = 0.1*theta;
plot3(x,y,z,'k')
grid on

% Generate the random numbers
n = 500;
theta = unifrnd(0,4*pi,1,n);
x = cos(theta);
y=sin(theta);
z = 0.1*(theta);
X = [x(:),y(:),z(:)];

% get the distances
pkg load statistics
ydist = pdist(X);
idhat = idpettis(ydist,n);
