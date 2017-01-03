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



% Project the query vectors.
q1t = u(:,1:3)'*q1;
q2t = u(:,1:3)'*q2;
% Now find the cosine of the angle between the query 
% vector and the columns of the reduced rank matrix,
% scaled by D.
for i = 1:5
 sj = d(1:3,1:3)*v(i,1:3)';
 m3 = norm(sj);
 cosq1b(i) = sj'*q1t/(m3*m1);
 cosq2b(i) = sj'*q2t/(m3);
end


% Now find the cosine of the angle between the query 
% vector and the columns of the reduced rank matrix,
% scaled by D.
for i = 1:5
 sj = d(1:3,1:3) * v(i,1:3)';
 m3 = norm(sj);
 cosq1b(i) = sj'*q1t/(m3*m1);
 cosq2b(i) = sj'*q2t/(m3);
end