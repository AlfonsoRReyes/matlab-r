load ../data/lsiex
% Loads up variables: X, termdoc, docs and words.
% Convert the matrix to one that has columns 
% with a magnitude of 1.
[n,p] = size(termdoc);
for i = 1:p
 no(:,i) = norm(X(:,i));
 termdoc(:,i) = X(:,i)/no(:,i);
 
end


q1 = [1 0 1 0 0 0]';
q2 = [1 0 0 0 0 0]';

% Find the cosine of the angle between 
% columns of termdoc and query.
% Note that the magnitude of q1 is not 1.
m1 = norm(q1);
cosq1a = q1'*termdoc/m1;
% Note that the magnitude of q2 is 1.
cosq2a = q2'*termdoc;

% Find the singular value decomposition.
[u,d,v] = svd(termdoc);