
function  [rep, P, Q, Gamma]=clus_sim_update0_3(CCC, lam2, eta, kernel_ini)  
%% Step 3: Obtain the target matrix P


n=size(kernel_ini,1); 

parfor ii=1:(n-1)
    Gamma{ii}=sparse(zeros(n-ii,n));
end
Pi=kernel_ini;  

parfor ii=1:(n-1)
    Qi{ii}=[zeros(n-ii, ii-1), ones(n-ii,1),-eye(n-ii)]*Pi;  dp_i=[];
    for jj=1:size(Qi{ii},1)
        dp_i=[dp_i,  max(eps,norm(Qi{ii}(jj,:)))];
    end
    dP{ii}=dp_i';
end
DelDel=n*eye(n)-ones(n,n);
Gammai=Gamma; Q=Qi;
rep=0; err=10;  

while  (err>0.1) + (rep<10) >1
rep=rep+1;
%% update P
int_mid1=0; int_mid2=0;  
parfor ii=1:(n-1); int_mid1=int_mid1+[zeros(n-ii, ii-1), ones(n-ii,1),-eye(n-ii)]'*Q{ii}; 
    int_mid2=int_mid2+[zeros(n-ii, ii-1), ones(n-ii,1),-eye(n-ii)]'*Gamma{ii}; end

P= inv(eta*DelDel+2*eye(n)) * (2*kernel_ini+eta*int_mid1- int_mid2);
[V, D, U]=eig((P+P')/2); 
[X]=projection(diag(D),CCC);
P=V*diag(X)*V'; P=(P+P')*0.5;


%% update Q
err_Q=0;  
parfor ii=1:(n-1)
    tjk=full(Gamma{ii}) + eta* [zeros(n-ii, ii-1), ones(n-ii,1),-eye(n-ii)]*P; tjk=tjk/lam2;  
    tjknorm=sqrt(sum(abs(tjk).^2,2));
    Q{ii}=(tjknorm>(1./dP{ii})).*((lam2*(tjknorm-(1./dP{ii}))./(eta* max(tjknorm,eps))).*tjk);    
    err_Q=err_Q+norm(Q{ii}-Qi{ii},'fro')^2;
end

%% update Gamma

err_Gamma=0;   
parfor ii=1:(n-1)
    Gamma{ii}=full(Gammai{ii})+ 0.1*eta*([zeros(n-ii, ii-1), ones(n-ii,1),-eye(n-ii)]*P-Q{ii});
    err_Gamma=err_Gamma+norm(Gamma{ii}-full(Gammai{ii}),'fro')^2;
end
err=norm(Pi-P,'fro')^2+ err_Gamma;      
Pi=P; Gammai=Gamma; Qi=Q;  
err
end

        
