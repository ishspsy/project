MPSSC: Using Multiple kernels with pairwise and element-wise sparse spectral clustering  

MPSSC is a novel spectral clustering framework that imposes sparse structures on a target matrix. Specifically,it utilizes a doubly stochastic affinity matrix to construct a normalized graph Laplacian. Then, it imposes a sparse structure on the target matrix followed by shrinking pairwise differences of the rows in the target matrix. This spectral clustering method uses multiple similarity matrices via non-convex optimization framework. The proposed non-convex problem iteratively using the ADMM algorithm.


Code:
SK_normalize.m: Perform SK algorithm to obtain a doubly stochastic matrix (Step 1).
clus_sim_update0_2.m: ADMM algorithm (Step 2).
clus_sim_update2_2.m: An iterative algorithm solving the proposed biconvex problem (Step 2).
clus_sim_update0_3.m: ADMM algorithm (Step 3).
main_working.m: Example


Example:

clear all
addpath(genpath(pwd))
load('Final_Data_Deng.mat')
rho=0.2; lam=0.0001; lam2=lam; eta=1; c=0.1;  
[P2] = clus_fin_update(rho, lam, lam2, eta, c, in_X, true_labs); 

%% calculate the three metrics

% NMI
[nmi, ~,clus_dou,~]=calc2_nmis(CCC, double(P2),true_labs) ;   
nmi
% Purity
purity=purity(CCC, clus_dou, true_labs)
% ARI
ari=RandIndex(clus_dou,true_labs)















Contact the Author 
Author: Seyoung Park and Hongyu Zhao
Email: seyoung.park@yale.edu




Reference 
Spectral clustering based on learning similarity matrix
