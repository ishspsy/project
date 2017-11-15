%% running MPSSC and PSSC for Larger-scale data sets


CCC=max(true_labs);
X=in_X; Y=X;  [n,p]=size(X); N=n;


rho=0.2; lam=0.0001; lam2=lam; eta=1; c=0.1;
tic()
[P2, P3] = clus_fin_update_two_step2(rho, lam, lam2, eta, c, in_X, true_labs, 30);
toc_mpssc=toc();

[nmi11, nmi22,clus_dou1,clus01]=calc2_nmis(CCC, double(P2),true_labs) ;
pu11=purity(CCC, clus_dou1, true_labs);  pu22=purity(CCC, clus01, true_labs);
tot_mpssc=[nmi11, nmi22;pu11,pu22; RandIndex(clus_dou1,true_labs),RandIndex(clus01,true_labs) ]';
tot_mpssc

tic()
[P3, P5] = clus_fin_update_two_step2_no_learning(rho, lam, lam2, eta, c, in_X, true_labs, 30);
toc_mpssc2=toc();


[nmi11, nmi22,clus_dou1,clus01]=calc2_nmis(CCC, double(P3),true_labs) ;
pu11=purity(CCC, clus_dou1, true_labs);  pu22=purity(CCC, clus01, true_labs);
tot_mpssc2=[nmi11, nmi22;pu11,pu22; RandIndex(clus_dou1,true_labs),RandIndex(clus01,true_labs) ]';
tot_mpssc2

tot_mpssc
tot_mpssc2
toc_mpssc
toc_mpssc2

