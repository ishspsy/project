%% runs the six clusteirng methods for simulation model2

rng(200)

k_real=10;
p=1000; M=p;
s=50;
n_set=500; N=n_set;
sigmamin=5;
repeat=50;
%% i for n
data_set=cell(1,length(n_set)); true_labs_set=cell(1,length(n_set));
for i=1:length(n_set)
    n=n_set(i);
    for run=1:repeat
        % Generate data
        [Bs,~,~]=svd(random('Normal',0,1,s,s) );
        Bs=Bs(1:k_real,:); % k_real*s
        B=[sigmamin*Bs, zeros(k_real,p-s) ]; %k_real*p
        true_labs=random('unid',k_real,n,1);
        W=random('Normal',0,1,n,p);
        Z=zeros(n,k_real);
        for class=1:k_real
            Z(:,class)= (true_labs==class);
        end
	Y=Z*B+W;
        data_set{i}{run}=Y; true_labs_set{i}{run}=true_labs;
    end
end


sigma_set=1:0.25:2;
k_set=10:2:30;


NNN=50;

performance_set=cell(1,NNN); missing_rate=[];
parfor ddd=1:NNN
%%simulation
true_labs=true_labs_set{1}{ddd};
CCC=max(true_labs);
X=data_set{1}{ddd};
X_true1=X;  X_true2=X;

X=X_true2.*(binornd(1,1-exp(-gamma*X_true2.^2))); sum(sum(abs(X)==0))/(size(X,1)*size(X,2))
in_X=X;[n,p]=size(in_X);
missing_rate=[missing_rate, sum(sum(abs(X)==0))/(size(X,1)*size(X,2))];


%% spectral clustering
tic()
SimGraph= func_simlarity(in_X);
ind_spec= SpectralClustering(SimGraph, CCC, 2);
toc_spec=toc();
nmi_spec=Cal_NMI(ind_spec,true_labs);
pur_spec=purity(CCC, ind_spec, true_labs);
ari_spec=RandIndex(ind_spec,true_labs);
tot_spec=[nmi_spec,pur_spec,ari_spec]


%% tsne
tic()
mappedX = tsne(in_X, true_labs, CCC);
ind_tsne = cal_new_clus(mappedX,CCC);
toc_tsne=toc();
tot_tsne=[Cal_NMI(ind_tsne,true_labs), purity(CCC, ind_tsne, true_labs),RandIndex(ind_tsne,true_labs)]



%% SIMLR
tic()
[ind_SIMLR, ~, ~, ~,~] = SIMLR(in_X,CCC);   
toc_simlr=toc();
tot_simlr=[Cal_NMI(ind_SIMLR,true_labs),purity(CCC, ind_SIMLR, true_labs),RandIndex(ind_SIMLR,true_labs)]

%% MPSSC
rho=0.2; lam=0.0001; lam2=lam; eta=1; c=0.1; 
tic()
[P2] = clus_fin_update(rho, lam, lam2, eta, c, in_X, true_labs); 
toc_mpssc=toc();
[nmi11, nmi22,clus_dou1,clus01]=calc2_nmis(CCC, double(P2),true_labs) ;
pu11=purity(CCC, clus_dou1, true_labs);  pu22=purity(CCC, clus01, true_labs);
tot_mpssc=[nmi11, nmi22;pu11,pu22; RandIndex(clus_dou1,true_labs),RandIndex(clus01,true_labs) ]';

%% MPSSC0
rho=0.2; lam=0.0001; lam2=lam; eta=1; c=0.1; 
tic()
[P20] = clus_fin_update_no_learning(rho, lam, lam2, eta, c, in_X, true_labs);  
toc_mpssc0=toc();
[nmi11, nmi22,clus_dou1,clus01]=calc2_nmis(CCC, double(P20),true_labs) ;
pu11=purity(CCC, clus_dou1, true_labs);  pu22=purity(CCC, clus01, true_labs);
tot_mpssc0=[nmi11, nmi22;pu11,pu22; RandIndex(clus_dou1,true_labs),RandIndex(clus01,true_labs) ]';




%% Sparse Spectral Clustering
tic()
[Ps,~,~,~] = sparsesc(eye(n)-SimGraph, 0.00001,CCC);
[V_tot1, ~, ~]=eig1(Ps, CCC);
ind_sspec=litekmeans(V_tot1,CCC,'Replicates',100);  
toc_sspec=toc();
tot_sspec=[Cal_NMI(ind_sspec,true_labs),purity(CCC, ind_sspec, true_labs),RandIndex(ind_sspec,true_labs)]

valtot=[tot_spec',tot_sspec',tot_tsne',tot_simlr',tot_mpssc(1,:)',tot_mpssc0(1,:)'];
valtot=[valtot; toc_spec,toc_sspec,toc_tsne,toc_simlr,toc_mpssc,toc_mpssc0];
performance_set{ddd}=valtot;
end


avg_perf=0;
for ii=1:50
    avg_perf=avg_perf+performance_set{ii}/50;
end
title={'SC', 'SSC','tSNE','SIMLR', 'MPSSC','MPSSC0'};
[title; num2cell(avg_perf)]
avg_perf