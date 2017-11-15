
function  [rep, P, Q, Gamma]=clus_sim_update0_2(CCC,c, lam0,id, eta, kernel_ini)   

%% ADMM algorithm used in Step 2 of MPSSC.

n=size(kernel_ini,1); 

lam=lam0*ones(n,n);  
for ii=1:n
    lam(ii, id(ii,:))=0.01*lam0;
end


[V, temp, evs]=eig1(eye(n)-kernel_ini, CCC, 0); 
LL= V(:,1:CCC) ;  Q=LL*LL'; Gamma=zeros(n,n); 

err=10;  Pi=Q; Qi=Q; Gammai=0;
rep=0; obj_fun=[];

while  (err>0.005) + (rep<500) >1
rep=rep+1;
%update P
T=-kernel_ini+Gamma; etai=eta+2*c;
P= (Q-T/etai-lam/etai).*(etai*Q-T>lam) + (Q-T/etai+lam/etai).*(etai*Q-T<-lam);  


%update Q
B=P+Gamma/eta; C=(B+B')*0.5;   [V, D, U]=eig(C); 
[X]=projection(diag(D),CCC);
Q=V*diag(X)*V';

%update Gamma
Gamma=Gamma+1*eta*(P-Q); 

err=norm(Pi-P,'fro')^2+ norm(Qi-Q,'fro')^2 + norm(Gammai-Gamma,'fro')^2; 
Pi=P; Gammai=Gamma; Qi=Q;
err;
end

        
