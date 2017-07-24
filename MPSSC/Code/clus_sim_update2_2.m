
function  [rep, W, P, Q]=clus_sim_update2_2(CCC, c, rho, lam,id, eta,W_euc_double)   % W_euc_nearest_double
   
n=size(W_euc_double{1},1); [p,q]=size(W_euc_double);

%initial step
kernel_ini=0;   Wi=zeros(p,q);
for ii=1: (p*q) ;
    kernel_ini=kernel_ini+W_euc_double{ii}/(p*q); Wi(ii)=1/(p*q);
end

W=ones(p,q)/(p*q); 
[V, temp, evs]=eig1(eye(n)-kernel_ini, CCC, 0); 
LL= V(:,1:CCC) ;  Q=LL*LL'; Gamma=zeros(n,n); 

err=10;  Pi=Q; Qi=Q; Gammai=0; Wi=W;
rep=0;

while  (err>0.01) + (rep<1000) >1
rep=rep+1;

[rep0, P, Q, Gamma]=clus_sim_update0_2(CCC, c, rho, lam, id, eta, kernel_ini);

%update W
W0=zeros(p,q); W=zeros(p,q);
for ii=1:(p*q)
    W0(ii)=exp(trace(W_euc_double{ii}*P/rho));
end
for ii=1:(p*q)
    W(ii)=W0(ii)/ sum(sum(W0));
end
W(isnan(W))=  1/(sum(sum(isnan(W))));
for ii=1:(p*q)
    W(ii)=W(ii)/ sum(sum(W));
end
%W=0.3*Wi+0.7*W;

kernel_ini=0;  
for ii=1:(p*q);
    kernel_ini=kernel_ini+W_euc_double{ii}*W(ii);
end

err=norm(Wi-W,'fro') + norm(Pi-P,'fro')+ norm(Qi-Q,'fro') + norm(Gammai-Gamma,'fro'); 
Wi=W; Pi=P; Gammai=Gamma; Qi=Q;
err
end

%DelDel=n*eye(n)-ones(n,n);
%P2=inv(lam2*DelDel+eye(n))*P;
%C=(P2+P2')*0.5;   [V, D, U]=eig(C); 
%[X,e]=projection(diag(D),CCC);
%P3=V*diag(X)*V';





        
