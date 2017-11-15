function [P2] = clus_fin_update_no_learning_kk(rho, lam, lam2, eta, c, X, true_labs, kk)
%% Performing proposed PSSC (no similarity learning) with kk neighbors in KNN.

%% Input
% rho is the regularization parameter which controls sparsity of kernel weights
% lam is the regularization parameter used in Step 2 which controls entry-wise sparsity of the target matrix P2
% lam2 is the regularization parameter used in Step 3 which shrinks the row-wise difference of P2
% eta is the step-size of the ADMM algorithm
% c is the regularization parameter for a strictly convex algorithm
% X is the n by p sequence data
% kk is the number of neighbors in constructing KNN
% true_labs is the n-dimensional vector containing the true labels for the n cells

%% Output
% P2:  the final target matrix


[Kernels, id]= func_doubly(X,kk); [n,p]=size(X);    
CCC=max(true_labs);
[rep, W, P, Q]=clus_sim_update2_2_no_learning(CCC, c, rho, lam, id, eta, single(Kernels)) ;

[V, temp, evs]=eig1(P, CCC);  
[rep, P2, Q, Gamma]=clus_sim_update0_3(CCC, lam2, eta, V*V');

end
