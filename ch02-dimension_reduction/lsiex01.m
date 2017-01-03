load ../data/lsiex
% Loads up variables: X, termdoc, docs and words.
% Convert the matrix to one that has columns 
% with a magnitude of 1.
[n,p] = size(termdoc);
for i = 1:p
 no(:,i) = norm(X(:,i));
 termdoc(:,i) = X(:,i)/no(:,i);
 
end