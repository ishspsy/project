function [P2, W] = clus_fin_update(rho, lam, lam2, eta, c, X, true_labs)

%% Proposed clustering method (MPSSC)

%% Input
% rho is the regularization parameter which controls sparsity of kernel weights
% lam is the regularization parameter used in Step 2 which controls entry-wise sparsity of the target matrix P2
% lam2 is the regularization parameter used in Step 3 which shrinks the row-wise difference of P2
% eta is the step-size of the ADMM algorithm
% c is the regularization parameter for a strictly convex algorithm
% X is the n by p sequence data
% true_labs is the n-dimensional vector containing the true labels for the n cells

%% Output
% P2:  the final target matrix
% W: learned weight of 55 Gaussian kernels

[n,p]=size(X);  CCC=max(true_labs);

%% Step 1: contruct multiple doubly stochastic similarity matrices using Gaussian kernels.
[Kernels, id]= func_doubly(X);

%% Step 2: Obtain the intermediae target matrix
[~, W, P, ~]=clus_sim_update2_2(CCC, c, rho, lam, id, eta, single(Kernels)) ;

%% Step 3: Obtain the final target matrix
[V, temp, evs]=eig1(P, CCC);
[~, P2, ~, ~]=clus_sim_update0_3(CCC, lam2, eta, V*V');

end





