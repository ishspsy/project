function [Mean,Covariance_Matrix,la]=Mean_Covariance_Matrix_Computation(Daily_Return)

r=Daily_Return;
[~,p]=size(r);

% mean computation
mu=mean(r)';  

% covariance matrix computation
Si=cov(r);
la=Shrinkage_la(r);
Si=(1-la)*Si+la*(trace(Si)/p)*eye(p);

% report output
Mean=mu;
Covariance_Matrix=Si;

end

