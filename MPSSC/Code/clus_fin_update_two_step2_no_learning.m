function [P2,P3] = clus_fin_update_two_step2_no_learning(rho, lam, lam2, eta, c, X, true_labs,k10)
%% running PSSC for large-scale scRNA-seq data sets without learning similarity matrix

[Kernels, id]= func_doubly(X, k10); [n,p]=size(X);   
CCC=max(true_labs);
[rep, W, P2, Q,P3]=clus_sim_update2_2_two_no_learning(CCC, c, rho, lam, id, eta, single(Kernels)) ;
end

