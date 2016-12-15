function de=Opimization_North(de_prime,al,c_i,mu,Si)
    %% solve North perturbation    
    p=length(mu); % p - number of assets including the benchmark

	cvx_begin quiet;
	variable de(p-1);  % p-1 - number of assets excluding the benchmark 
	minimize(sum(abs(de./de_prime)));    
    subject to;
        sum(de) == 1-al;
        [de' al]*mu >= mu(end)+c_i*abs(mu(end));  
        [de' al]*Si*[de; al] <= Si(end,end);
	cvx_end;
    
end
