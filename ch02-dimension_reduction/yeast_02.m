% Now for the percentage of variance explained.
pervar = 100*cumsum(eigvale)/sum(eigvale);

% First get the expected sizes of the eigenvalues.
g = zeros(1,p);
for k = 1:p
for i = k:p
  g(k) = g(k) + 1/i;
end
end
g = g/p;

% next step is to find the proportion of the variance explained.
propvar = eigvale/sum(eigvale);

% Now for the size of the variance.
avgeig = mean(eigvale);
% Find the length of ind:
ind = find(eigvale > avgeig);
length(ind)

% So, using 3, we will reduce the dimensionality.
P = eigvece(:,1:3);
Xp = datac*P;
figure,plot3(Xp(:,1),Xp(:,2),Xp(:,3),'k*')
xlabel('PC 1'),ylabel('PC 2'),zlabel('PC 3')
grid on, axis tight
