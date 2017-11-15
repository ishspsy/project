function [P2] = clus_fin_update_two_step(rho, lam, lam2, eta, c, X, true_labs)
%% Proposed method without third step (for larger-scale data sets)

[Kernels, id]= func_doubly(X); [n,p]=size(X);   
CCC=max(true_labs);
[rep, W, P2, Q]=clus_sim_update2_2(CCC, c, rho, lam, id, eta, single(Kernels)) ;

end