
function  [rep, P, Q, Gamma]=clus_sim_update0_2(CCC,c, rho, lam0,id, eta, kernel_ini)   % W_euc_nearest_double

%[kernel_ini] = SK_normalize(kernel_ini);

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
%P= (eta*Q-T-lam).*(eta*Q-T>lam) + (eta*Q-T+lam).*(eta*Q-T<-lam);  
P= (Q-T/etai-lam/etai).*(etai*Q-T>lam) + (Q-T/etai+lam/etai).*(etai*Q-T<-lam);  

%[up,dp] = eig(P);  
%dp=ones(size(P,1),1)-0.8*diag(dp);  P=up*diag(1./dp)*up';  
%P=P*CCC/trace(P);
  


%P=0.8*P+0.2*Pi;

%update Q
B=P+Gamma/eta; C=(B+B')*0.5;   [V, D, U]=eig(C); 
[X]=projection(diag(D),CCC);
%D=diag(D);    DD=[D-1, (1:length(D))']; DD=sortrows(abs(DD),-1); ind=DD(1:CCC,2);
%X=zeros(length(D),1); X(ind)=1;

Q=V*diag(X)*V';
%Q=0.8*Q+0.2*Qi;

%update Gamma
Gamma=Gamma+eta*(P-Q); 

err=norm(Pi-P,'fro')+ norm(Qi-Q,'fro') + norm(Gammai-Gamma,'fro'); 
%err=norm(P-Q,'fro');
Pi=P; Gammai=Gamma; Qi=Q;
err;
%obj_fun=[obj_fun, trace((eye(n)-kernel_ini)*P) + lam*sum(sum(abs(P)))]; %+ sum(sum(Gamma.*(P-Q)))+eta*0.5*norm(P-Q,'fro')^2];
end

        
