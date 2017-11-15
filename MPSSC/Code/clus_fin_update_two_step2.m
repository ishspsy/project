function [P2,P3] = clus_fin_update_two_step2(rho, lam, lam2, eta, c, X, true_labs,k10)
%% Proposed method without third step (for larger-scale data sets) with the k10 number of neighboors in KNN

[Kernels, id]= func_doubly(X, k10); [n,p]=size(X);  
CCC=max(true_labs);
[rep, W, P2, Q,P3]=clus_sim_update2_2_two(CCC, c, rho, lam, id, eta, single(Kernels)) ;
end
