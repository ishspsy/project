function  [rep, W, P, Q,P3]=clus_sim_update2_2_two(CCC, c, rho, lam,id, eta, Kernels)
%% Step 2: Obtain the intermediate target matrix P. Another output (P3) by l2 regularization is obtained for comparisons.



n=size(Kernels,1); pq=55;

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

lam2=0.01;
DelDel=n*eye(n)-ones(n,n);
P2=inv(lam2*DelDel+eye(n))*P;
C=(P2+P2')*0.5;   [V, D, U]=eig(C);
[X]=projection(diag(D),CCC);
P3=V*diag(X)*V';

