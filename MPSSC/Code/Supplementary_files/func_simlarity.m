function [W_euc]= func_simlarity(X);
%% compute similarity matrix using single kernel

[n,p]=size(X);
sigma_set=1.5;  k_set=15;
W_euc_orig=pdist(X); W_euc0=squareform(W_euc_orig);

        sigma=sigma_set; cln=k_set;     
        [IDX DDist] = knnsearch(X,X,'k',cln); muij=mean(DDist(:,2:end),2); 
        muij=repmat(muij,[1,length(muij)])+repmat(muij',[length(muij),1]);  muij=muij*0.5; 
        W_euc=exp(-(W_euc0.^2)./(2*(muij*sigma).^2 )); 
end