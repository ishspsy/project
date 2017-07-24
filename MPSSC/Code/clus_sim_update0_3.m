
function  [rep, P, Q, Gamma]=clus_sim_update0_3(CCC, lam2, eta, kernel_ini)   % W_euc_nearest_double

%nn_s=[];
%for ii=1:181
%nn_s=[nn_s,norm(Q{1}(ii,setdiff(1:182, [1,ii+1])))];
%end

%[kernel_ini] = SK_normalize(kernel_ini);
n=size(kernel_ini,1); 

Del=cell(1,n-1); Gamma=cell(1,n-1);
parfor ii=1:(n-1)
    Del{ii}=[zeros(n-ii, ii-1), ones(n-ii,1),-eye(n-ii)];      %iith row block
    Gamma{ii}=zeros(n-ii,n);
end
Gammai=Gamma;

P=kernel_ini;  
Q=cell(1,n-1);  dP=cell(1,n-1);
parfor ii=1:(n-1)
    Q{ii}=Del{ii}*P;  dp_i=[];
    for jj=1:size(Q{ii},1)
        %dp_i=[dp_i, norm(Q{ii}(jj,setdiff(1:size(Q{ii},2), [ii,ii+jj])))];
        dp_i=[dp_i,  max(eps,norm(Q{ii}(jj,:)))];
    end
    dP{ii}=dp_i';
    %Qi=Qi+Del{ii+1}'*Pi((ii*n-ii*(ii+1)*0.5+1):((ii+1)*n-(ii+1)*(ii+2)*0.5),:);     %iith row block
end
Pi=P; Qi=Q;
DelDel=n*eye(n)-ones(n,n);

rep=0; obj_fun=[]; err=10;  

while  (err>0.005) + (rep<10) >1
rep=rep+1;
%update P or X
int_mid1=0; int_mid2=0;   %repmat(dP{ii},1,size(Q{ii},2))
parfor ii=1:(n-1); int_mid1=int_mid1+Del{ii}'*Q{ii}; int_mid2=int_mid2+Del{ii}'*Gamma{ii}; end
P= inv(eta*DelDel+2*eye(n)) * (2*kernel_ini+eta*int_mid1- int_mid2);
%P=0.8*P+0.2*Pi;
[V, D, U]=eig((P+P')/2); 
[X]=projection(diag(D),CCC);
P=V*diag(X)*V'; P=(P+P')*0.5;
%[up,dp] = eig(P);  dp=ones(size(P,1),1)-0.8*diag(dp);  P=up*diag(1./dp)*up';  P=P*CCC/trace(P);


%update Q
Q=cell(1,n-1);  err_Q=0;    %cell(1,n-1);
parfor ii=1:(n-1)
    tjk=Gamma{ii} + eta*  Del{ii}*P; tjk=tjk/lam2;  tjknorm=sqrt(sum(abs(tjk).^2,2));
    %Q{ii}=repmat(tjknorm>1,1,n).*((lam2*(tjknorm-1)./(eta* max(tjknorm,eps))).*tjk);
    Q{ii}=(tjknorm>(1./dP{ii})).*((lam2*(tjknorm-(1./dP{ii}))./(eta* max(tjknorm,eps))).*tjk);    
    err_Q=err_Q+norm(Q{ii}-Qi{ii},'fro')^2;
end

%update Gamma
Gamma=cell(1,n-1); err_Gamma=0;   %cell(1,n-1);
parfor ii=1:(n-1)
    Gamma{ii}=Gammai{ii}+ 0.1*eta*(Del{ii}*P-Q{ii});
    err_Gamma=err_Gamma+norm(Gamma{ii}-Gammai{ii},'fro')^2;
end

err=norm(Pi-P,'fro')^2+ err_Gamma+ err_Q;             %norm(Qi-Q,'fro') + norm(Gammai-Gamma,'fro'); 
%err=norm(P-Q,'fro');
Pi=P; Gammai=Gamma; Qi=Q;  %eta=min(1.1*eta, 1.5);
err
%obj_fun=[obj_fun, trace((eye(n)-kernel_ini)*P) + lam*sum(sum(abs(P)))]; %+ sum(sum(Gamma.*(P-Q)))+eta*0.5*norm(P-Q,'fro')^2];
end

        
