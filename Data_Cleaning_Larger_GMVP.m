function Daily_Adjust_Close_Larger_GMVP=Data_Cleaning_Larger_GMVP(Daily_Adjust_Close,Daily_Adjust_Close_Larger_Set)

% make sure last column is benchmark
Daily_Adjust_Close_Benchmark=Data_Cleaning_Benchmark(Daily_Adjust_Close_Larger_Set);

% compute daily return from daily adjusted close
Daily_Return_Benchmark=Return_Computation_Daily(Daily_Adjust_Close_Benchmark);

% compute component of GMVP
% first one year component of GMVP = Equal
[n,p]=size(Daily_Return_Benchmark);
GMVP_comp=(1/(p-1))*ones(n,p-1);
for t=12*21:n
    r=Daily_Return_Benchmark(t-12*21+1:t,1:end-1);
    [~,Si]=Mean_Covariance_Matrix_Computation(r);
    temp=(Si\ones(p-1,1))./sum(Si\ones(p-1,1));
    GMVP_comp(t,:)=temp';
end

% compute daily adjust close GMVP with starting value 1
rg=sum(GMVP_comp.*Daily_Return_Benchmark(:,1:end-1),2);
g=cumprod(1+rg); 
g=[1;g]; 

% replace last column of daily adjust close (benchamrk) 
% with daily adjust close GMVP with starting value 1 
Daily_Adjust_Close_Larger_GMVP=[Daily_Adjust_Close(:,1:end-1) g];

end
