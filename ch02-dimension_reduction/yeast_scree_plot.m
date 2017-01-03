load ../data/yeast

[n,p] = size(data);

% Center the data.
datac = data - repmat(sum(data)/n,n,1); 

% Find the covariance matrix.
covm = cov(datac);

[eigvec,eigval] = eig(covm);
eigvald = diag(eigval); % Extract the diagonal elements

% Order in descending order
eigvale = flipud(eigvald);
eigvece = eigvec(:,p:-1:1);

% Do a scree plot.
figure, plot(1:length(eigvale),eigvale,'ko-')
title('Scree Plot')
xlabel('Eigenvalue Index - k')
ylabel('Eigenvalue')