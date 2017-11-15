
function  [rep, W, P, Q]=clus_sim_update2_2(CCC, c, rho, lam,id, eta, Kernels)  
%% Step 2: Obtain the intermediate target matrix P for MPSSC

%% Input
% CCC is the target clustering number
% c is the regularization parameter for a strictly convex algorithm
% rho is the regularization parameter which controls sparsity of kernel weights
% lam is the regularization parameter used in Step 2 which controls entry-wise sparsity of the target matrix P2
% id includes the k10 number of neighborhood for each subject.
% eta is the step-size of the ADMM algorithm
% Kernels is the set of 55 doubly stochastic similarity matrices.


%% Output
% P: the final target matrix
% W: learning weights for 55 similarity matrices



n=size(Kernels,1); pq=size(Kernels,3);

%initial step
Wi=ones(1,pq)/pq; kernel_ini=mean(Kernels,3);
W=Wi; 
[V, temp, evs]=eig1(eye(n)-kernel_ini, CCC, 0); 
LL= V(:,1:CCC) ;  Q=LL*LL'; Gamma=zeros(n,n); 

err=10;  Pi=Q; Qi=Q; Gammai=0; Wi=W;
rep=0;

while  (err>0.01) + (rep<100) >1
rep=rep+1;

[rep0, P, Q, Gamma]=clus_sim_update0_2(CCC, c, lam, id, eta, kernel_ini);

%update W
W0=zeros(1,pq); W=zeros(1,pq);
for ii=1:pq
    W0(ii)=exp(trace(Kernels(:,:,ii)*P/rho));
end
W=W0/sum(W0);

W(isnan(W))=  1/(sum(isnan(W)));
W=W/sum(W);


kernel_ini=0;  
parfor ii=1:pq;
    kernel_ini=kernel_ini+Kernels(:,:,ii)*W(ii);
end

err=norm(Wi-W,'fro')^2 + norm(Pi-P,'fro')^2+ norm(Qi-Q,'fro')^2 + norm(Gammai-Gamma,'fro')^2; 
Wi=W; Pi=P; Gammai=Gamma; Qi=Q;
err
end






        
