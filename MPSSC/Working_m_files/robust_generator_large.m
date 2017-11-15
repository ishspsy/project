%% It performs MPSSC by changing \lambda for larger-scale data sets


C = max(true_labs); CCC=C;
[n p]=size(in_X)

y=true_labs; [n,p]=size(in_X);
X=in_X; Y=X; y=true_labs; [n,p]=size(X);


rng(50)

lam_set=[0.000001, 0.00001, 0.00005, 0.0001, 0.0002, 0.0005, 0.001, 0.01];


tot_mpssc_set=cell(1,length(lam_set)); tot_mpssc0_set=cell(1,length(lam_set));

parfor ijk=1:length(lam_set);

%% MPSSC
rho=0.2; lam=lam_set(ijk); lam2=lam; eta=1; c=0.1;
tic()
[P2, P3] = clus_fin_update_two_step2(rho, lam, lam2, eta, c, in_X, true_labs, 30);


toc_mpssc=toc();

[nmi11, nmi22,clus_dou1,clus01]=calc2_nmis(CCC, double(P2),true_labs) ;
pu11=purity(CCC, clus_dou1, true_labs);  pu22=purity(CCC, clus01, true_labs);
tot_mpssc=[nmi11, nmi22;pu11,pu22; RandIndex(clus_dou1,true_labs),RandIndex(clus01,true_labs) ]';
tot_mpssc_set{ijk}=tot_mpssc;
end
