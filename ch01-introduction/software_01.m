load software
% First transform the data.
X = log(prepsloc);
Y = log(defsloc);
% Plot the transformed data.
plot(X,Y,'.')
xlabel('Log PrepTime/SLOC')
ylabel('Log Defects/SLOC')