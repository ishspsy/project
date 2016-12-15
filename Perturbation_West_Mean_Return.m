function [al,de,monthly_return_perturbed_portfolio,monthly_return_benchmark]=Perturbation_West_Sharpe_Ratio(Daily_Return,Monthly_Return,al_list,c_i_list)

%% Print start time

Time_Start=datestr(clock);
fprintf('Start time  %s\n',Time_Start)

%% Common parameter - number of assets including the benchmark and number of days

r=Daily_Return;
r1=Monthly_Return;
% n - number of days
% p - number of assets including benchmark
[n,p]=size(r);
n=n+1;

%% Common parameter - First day of each month of interest
% using last one year daily returns data we compute mean and covariance matrix and we form a portfolio 
% run this portfolio for a month and record its performance
% First days of each month of interest are days that we form a portfolio to measure its performance
% It includes the initial burning period

time_points=21*12+1+21*(0:n); 
time_points=time_points(time_points<n-20); % time points of interest
T=length(time_points);

%% Common parameter - mesh size and basic fold for 10 fold cross validation
% using last one year daily returns data we compute mean and covariance matrix and we form a portfolio
% before forming this portfolio we have to set certain parameters - al and c_i
% to set these parameters we do the 10 fold cross validation using last one year daily returns data
% we split last one year into 10 buckets
% using 9 buckets we estimate mean and covariance matrix
% using this we form a perturbed portfolio with various choice of parameters
% and measure their performances on remaining bucket
% we do this for 10 different choice of buckets
% Choose the parameters with the best cross validation score

mesh_size=floor((21*12)/10);
basic_fold=1:mesh_size;

%% West sharpe ratio perturbation  
% push benchmark to west
% parameters are chosen using 10-fold cross validation with mean return as performance measure

% read daily return and monthly return
r_temp=r;
r1_temp=r1;

% initialization of output
al=zeros(T,1);
de=zeros(p-1,T);
monthly_return_perturbed_portfolio=zeros(T,1);
monthly_return_benchmark=Monthly_Return(13:end,end);  

for t=time_points(1:T)
    
    % set time index - 1, 2, 3, ..., T
    time_index=(t-(21*12+1))/21+1;
    
    % read previous one year daily returns
    r2=r_temp(1:21*12,:);
    %r2=r2(randperm(21*12),:); % random shuffle of days 
    
    % set de_prime, de at the privious time period
	if time_index==1
        % initially we set de_prime equal
        de_prime=ones(p-1,1);    
    else
        % later we set de_prime as de at the privious time period
        % if de at the privious time period equals to 0, we set de_prime as 1e-6 
        de_prime=max(de(:,time_index-1),1e-6);
	end
    
    % choose al and c_i using the 10-fold cross validation
    % initialization of cross validation score for each choice of al and c_i
    CV_Score=zeros(length(al_list),length(c_i_list),10);
    parfor tt=1:10; % 10-fold cross validation
        % split last one year data into training and test 
        fold=(tt-1)*mesh_size+basic_fold;
        days_training=setdiff(1:21*12,fold);
        days_test=setdiff(1:21*12,days_training);
        r2_temp=r2;
        r_training=r2_temp(days_training,:); % training
        r_test=r2_temp(days_test,:); % test
        % compute mean and covariance matrix of training data
        [mu_training,Si_training]=Mean_Covariance_Matrix_Computation(r_training); 
        % measure performace of perturbed portfolio over test set for each choice of al and c_i  
        score0=zeros(length(al_list),length(c_i_list));
        for i=1:length(al_list)
            for j=1:length(c_i_list)
                % determine perturbed portfolio for each choice of al and c_i 
                c_i_temp=c_i_list(j);
                al_temp=al_list(i);
                de1=Optimization_West(de_prime,al_temp,c_i_temp,mu_training,Si_training); 
                % while sum(isnan(de1))>0
                while sum(isnan(de1)) + (sum(de1)+al_temp > 1.001) + (sum(de1)+al_temp < 0.999) >0.5 
                    c_i_temp=c_i_temp+0.03;
                    de1=Optimization_West(de_prime,al_temp,c_i_temp,mu_training,Si_training); 
                end
                % measure performace of perturbed portfolio over test set for each choice of al and c_i  
                w=[de1;al_list(i)]; 
                if sum(isnan(de1)) + (sum(de1)+al_temp > 1.001) + (sum(de1)+al_temp < 0.999) > 0.5
                    score0(i,j)=-500;                           
                else
                    score0(i,j)= mean(r_test*w); % Performance measure: Mean return
                end 
            end
        end
        CV_Score(:,:,tt)=score0; 
    end
    % take sum of CV_Score over 10 fold and use it as CV_Score
    CV_Score=sum(CV_Score,3);
    % choose al and c_i using the 10-fold cross validation
    max1_CV_Score=max(CV_Score);
    max2_CV_Score=max(max1_CV_Score);  
    J=find(max1_CV_Score==max2_CV_Score,1,'first'); % choose smallest c, which is more restricted 
    I=find(CV_Score(:,J)==max2_CV_Score,1,'last');
    al(time_index)=al_list(I);
    c_i_temp=c_i_list(J);
    al_temp=al_list(I);
    
    % report the performace of perturbed portfolio over the next month 
	[mu,Si,la]=Mean_Covariance_Matrix_Computation(r2); 
     de1=Optimization_West(de_prime,al_temp,c_i_temp,mu,Si); 
	%while sum(isnan(de1))>0
	while sum(isnan(de1)) + (sum(de1)+al_temp > 1.001) + (sum(de1)+al_temp < 0.999) >0.5 
        c_i_temp=c_i_temp+0.05;
        de1=Optimization_West(de_prime,al(time_index),c_i_temp,mu,Si);
	end
    % make sure al+sum(de)=1
    % activate either first line or third line below exclusively
    %de1=((1-al(time_index))/sum(de1))*de1;
    de(:,time_index)=de1;
    al(time_index)=1-sum(de(:,time_index));
    monthly_return_perturbed_portfolio(time_index)=r1_temp(13,:)*[de(:,time_index);al(time_index)];
    
    % cut the first month and paste it to the end of data
    r_temp=Shift_Long(r_temp);
    r1_temp=Shift_Short(r1_temp);
    
    % print out the iteration number and Shrinkage lambda 
    Iteration_Number=(t-(21*12+1))/21+1;
    fprintf('Iteration number ... %g\n',Iteration_Number)
    fprintf('Shrinkage lambda ... %g\n',la)
    
end

% exclude initial burning period
al=al(13:end);
de=de(:,13:end);
monthly_return_perturbed_portfolio=monthly_return_perturbed_portfolio(13:end,1);
monthly_return_benchmark=monthly_return_benchmark(13:end,1);

%% draw daily adjusted close of benchmark and perturbed portfolio starting their value 1

%% Print end time

Time_End=datestr(clock);
fprintf('End time  %s\n',Time_End)

end

