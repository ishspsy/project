function Daily_Adjust_Close_Equal=Data_Cleaning_Equal(Daily_Adjust_Close)

% make sure last column is benchmark
Daily_Adjust_Close_Benchmark=Data_Cleaning_Benchmark(Daily_Adjust_Close);

% compute daily return from daily adjusted close
Daily_Return_Benchmark=Return_Computation_Daily(Daily_Adjust_Close_Benchmark);

% compute daily return equal
% for each day take average of asset daily returns excluding benchmark
Daily_Return_Equal=mean(Daily_Return_Benchmark(:,1:end-1),2);

% compute daily adjust close equal with starting value 1
re=Daily_Return_Equal;
e=cumprod(1+re); 
e=[1;e]; 

% replace last column of daily adjust close (benchamrk) 
% with daily adjust close equal with starting value 1 
Daily_Adjust_Close_Equal=[Daily_Adjust_Close(:,1:end-1) e];

end

