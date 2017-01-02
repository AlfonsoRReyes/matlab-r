% filename_str is read from a text file
directoryname_str = "../data";
f = fullfile(directoryname_str, "yeast");
load(f);


[n, p] = size(data);

% center the data
datac = data - repmat(sum(data) /n, n, 1);

%find the covariance matrix_type
covm = cov(datac);

[eigvec,eigval] = eig(covm);
eigval = diag(eigval); % Extract the diagonal elements
% Order in descending order
eigval = flipud(eigval);
eigvec = eigvec(:,p:-1:1);


% Do a scree plot.
figure, plot(1:length(eigval),eigval,'ko-')
title('Scree Plot')
xlabel('Eigenvalue Index - k')
ylabel('Eigenvalue')

% Now for the percentage of variance explained.
pervar = 100*cumsum(eigval)/sum(eigval);

% First get the expected sizes of the eigenvalues.
g = zeros(1,p);
for k = 1:p
for i = k:p
  g(k) = g(k) + 1/i;
end
end
g = g/p;

% next step is to find the proportion of the variance explained.
propvar = eigval/sum(eigval);


% Now for the size of the variance.
avgeig = mean(eigval);
% Find the length of ind:
ind = find(eigval > avgeig);
length(ind)

% So, using 3, we will reduce the dimensionality.
P = eigvec(:,1:3);
Xp = datac*P;
figure,plot3(Xp(:,1),Xp(:,2),Xp(:,3),'k*')
xlabel('PC 1'),ylabel('PC 2'),zlabel('PC 3')
grid on, axis tight

% % So, using 3, we will reduce the dimensionality.
P = eigvec(:,1:3);
Xp = datac*P;
figure,plot3(Xp(:,1),Xp(:,2),Xp(:,3),'k*')
xlabel('PC 1'),ylabel('PC 2'),zlabel('PC 3')
grid on, axis tight