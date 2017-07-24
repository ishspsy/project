clear all
addpath('Code')
addpath('Data')


load('deng_data.mat')
X=in_X; Y=X;  [n,p]=size(X); N=n;

rho=0.2; lam=0.0001; lam2=lam; eta=1; c=0.1; cases=1;  %cases=1 when sparse kernels are used.
[P2,perf_fin] = clus_fin_update(rho, lam, lam2, eta, c, X, true_labs, cases);


