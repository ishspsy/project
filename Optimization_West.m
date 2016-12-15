function de=Opimization_West(de_prime,al,c_i,mu,Si)
    %% solve West perturbation    
    p=length(mu); % p - number of assets including the benchmark

	cvx_begin quiet;
	variable de(p-1); % p-1 - number of assets excluding the benchmark 
	minimize(sum(abs(de./de_prime)));    
    subject to;
        sum(de) == 1-al; 
        [de' al]*Si*[de; al] <= c_i*Si(end,end);
	cvx_end;
    
end
