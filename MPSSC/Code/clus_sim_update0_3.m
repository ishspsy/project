
function  [rep, P, Q, Gamma]=clus_sim_update0_3(CCC, lam2, eta, kernel_ini)  
%clus_sim_update0_3(CCC, lam2, eta, V*V')

n=size(kernel_ini,1); 

Del=cell(1,n-1); Gamma=cell(1,n-1);
parfor ii=1:(n-1)
    Del{ii}=[zeros(n-ii, ii-1), ones(n-ii,1),-eye(n-ii)];     
    Gamma{ii}=zeros(n-ii,n);
end
Gammai=Gamma;

P=kernel_ini;  
Q=cell(1,n-1);  dP=cell(1,n-1);
parfor ii=1:(n-1)
    Q{ii}=Del{ii}*P;  dp_i=[];
    for jj=1:size(Q{ii},1)
        dp_i=[dp_i,  max(eps,norm(Q{ii}(jj,:)))];
    end
    dP{ii}=dp_i';
end
Pi=P; Qi=Q;
DelDel=n*eye(n)-ones(n,n);

rep=0; obj_fun=[]; err=10;  

while  (err>0.005) + (rep<10) >1
rep=rep+1;
%update P or X
int_mid1=0; int_mid2=0;  
parfor ii=1:(n-1); int_mid1=int_mid1+Del{ii}'*Q{ii}; int_mid2=int_mid2+Del{ii}'*Gamma{ii}; end
P= inv(eta*DelDel+2*eye(n)) * (2*kernel_ini+eta*int_mid1- int_mid2);
%P=0.8*P+0.2*Pi;
[V, D, U]=eig((P+P')/2); 
[X]=projection(diag(D),CCC);
P=V*diag(X)*V'; P=(P+P')*0.5;
%[up,dp] = eig(P);  dp=ones(size(P,1),1)-0.8*diag(dp);  P=up*diag(1./dp)*up';  P=P*CCC/trace(P);


%update Q
Q=cell(1,n-1);  err_Q=0;   ;
parfor ii=1:(n-1)
    tjk=Gamma{ii} + eta*  Del{ii}*P; tjk=tjk/lam2;  tjknorm=sqrt(sum(abs(tjk).^2,2));
    Q{ii}=(tjknorm>(1./dP{ii})).*((lam2*(tjknorm-(1./dP{ii}))./(eta* max(tjknorm,eps))).*tjk);    
    err_Q=err_Q+norm(Q{ii}-Qi{ii},'fro')^2;
end

%update Gamma
Gamma=cell(1,n-1); err_Gamma=0;   
parfor ii=1:(n-1)
    Gamma{ii}=Gammai{ii}+ 0.1*eta*(Del{ii}*P-Q{ii});
    err_Gamma=err_Gamma+norm(Gamma{ii}-Gammai{ii},'fro')^2;
end

err=norm(Pi-P,'fro')^2+ err_Gamma+ err_Q;           
Pi=P; Gammai=Gamma; Qi=Q;  
err
end

        
