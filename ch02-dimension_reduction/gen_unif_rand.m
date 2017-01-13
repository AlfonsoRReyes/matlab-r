% Generate the random numbers
% unifrnd is from the Statistics Toolbox.
n = 500;

theta = unifrnd(0,4*pi,1,n);
% Use in the equations for a helix.
x = cos(theta); 
y=sin(theta);
z = 0.1*(theta);

% Put into a data matrix.
X = [x(:),y(:),z(:)];