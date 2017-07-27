function [P2,perf_fin] = clus_fin_update(rho, lam, lam2, eta, c, X, true_labs, cases)
%clus_fin_update(rho, lam, lam2, eta, c, X, true_labs, cases)

[W_euc_double, id]= func_doubly(X, cases); [n,p]=size(X);
CCC=max(true_labs);

[rep, W, P, Q]=clus_sim_update2_2(CCC, c, rho, lam, id, eta, W_euc_double) ;
[V, temp, evs]=eig1(P, CCC);  
[rep, P2, Q, Gamma]=clus_sim_update0_3(CCC, lam2, eta, V*V');

[nmi11, nmi22,clus_dou1,clus01]=calc2_nmis(CCC, P2,true_labs) ;    
pu11=purity(CCC, clus_dou1, true_labs);  pu22=purity(CCC, clus01, true_labs); 
perf_fin=[nmi11, nmi22;pu11,pu22; RandIndex(clus_dou1,true_labs),RandIndex(clus01,true_labs) ]';


function [W_euc_double, id]= func_doubly(X, cases);
[n,p]=size(X);
sigma_set=1:0.25:2;  k_set=10:2:30; 
W_euc_orig=pdist(X); W_euc0=squareform(W_euc_orig);
W_euc_set=cell(length(sigma_set), length(k_set));  W_euc_nearest_set=cell(length(sigma_set), length(k_set));
W_euc_set_n=cell(length(sigma_set), length(k_set));  W_euc_nearest_set_n=cell(length(sigma_set), length(k_set));

for tts=1:length(sigma_set) 
    for ttk=1:length(k_set)
        sigma=sigma_set(tts); cln=k_set(ttk);     
        [IDX DDist] = knnsearch(X,X,'k',round(cln)); muij=mean(DDist(:,2:end),2);  logn=round(cln);
        muij=repmat(muij,[1,length(muij)])+repmat(muij',[length(muij),1]);  muij=muij*0.5; 
        W_euc=exp(-(W_euc0.^2)./(2*(muij*sigma).^2 ))./ (muij*sigma*sqrt(2*pi))  ;  
        W_ind=zeros(n,n);
        for ii=1:n
         W_ind(ii,find(W_euc(ii,:)>quantile(W_euc(ii,:),(n-logn)/n)))=1;
        end
         W_ind=(W_ind+W_ind')*0.5; W_ind(W_ind>0)=1;
         W_euc_nearest=W_euc.*W_ind;    
         W_euc_set{tts,ttk}=W_euc;  W_euc_nearest_set{tts,ttk}=W_euc_nearest;
         WW1= W_euc_set{tts,ttk}; DWW1= (max(sum(WW1),eps)).^(-0.5); WW1=  diag(DWW1)*WW1*diag(DWW1);
         W_euc_set_n{tts,ttk}=W_euc;
         WW2= W_euc_nearest_set{tts,ttk}; DWW2= (max(sum(WW2),eps)).^(-0.5); WW2=  diag(DWW2)*WW2*diag(DWW2);
         W_euc_nearest_set_n{tts,ttk}=WW2;
    end
end

W_euc_double=cell(length(sigma_set), length(k_set));  W_euc_nearest_double=cell(length(sigma_set), length(k_set));
for tts=1:length(sigma_set) 
    for ttk=1:length(k_set)
         WW1= W_euc_set{tts,ttk}; 
         DWW1= (max(sum(WW1),eps)).^(-0.5); 
         WW1=  diag(DWW1)*WW1*diag(DWW1);
         WW2= W_euc_nearest_set{tts,ttk}; 
         DWW2= (max(sum(WW2),eps)).^(-0.5); 
         WW2=  diag(DWW2)*WW2*diag(DWW2);
         W_euc_double{tts,ttk}=SK_normalize(WW1);  W_euc_nearest_double{tts,ttk}=SK_normalize(WW2);
    end
end

if cases==1
    W_euc_double=W_euc_nearest_double;
end
    


distX=0;
for ii=1:(length(sigma_set)*length(k_set))
    distX=distX+ W_euc_double{ii}/(length(sigma_set)*length(k_set));
end
[distX1, idx] = sort(distX,2,'descend');
id = idx(:,2:11);

end



end