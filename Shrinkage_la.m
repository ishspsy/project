function la = Shrinkage_la(rc3)

    [n,p]=size(rc3);
	Si=cov(rc3);
        
	% lambda of Ledoit and Wolf shrinkage 
	% Ledoit and Wolf shrinkage 
	% Si=(1-la)*Si+la*(trace(Si)/p)*eye(p);
	normalized_diagonal_sum=trace(Si)/p;
	b=trace((Si-normalized_diagonal_sum*eye(p))^2)/p;
	a=0;
	for k=1:n
        a=a+trace((rc3(k,:)'*rc3(k,:)-Si)^2);
	end
	a=a/(n^2*p);
	a=min(a,b);
	la=a/b;
        
	% If you want to use sample covariance matrix instead,
    % disactivate all the above code and activate the below line
    %la=0;
        
end
