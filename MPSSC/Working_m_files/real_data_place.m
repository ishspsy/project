%% runs the 8 clustering methods;  'SC', 'SSC', 'KM','PCA','tSNE','SIMLR','PSSC', 'MPSSC'

rng(50)

[n p]=size(in_X);  C = max(true_labs); CCC=C; 

%% spectral clustering
tic()
SimGraph= func_simlarity(in_X);
ind_spec= SpectralClustering(SimGraph, C, 3);
toc_spec=toc();
nmi_spec=Cal_NMI(ind_spec,true_labs);
pur_spec=purity(CCC, ind_spec, true_labs); 
ari_spec=RandIndex(ind_spec,true_labs);
tot_spec=[nmi_spec,pur_spec,ari_spec]

%% kmeans
tic()
[ind_kmean] = litekmeans(in_X, CCC,'replicates',50);
toc_kmean=toc();

tot_kmean=[Cal_NMI(ind_kmean,true_labs), purity(CCC, ind_kmean, true_labs),RandIndex(ind_kmean,true_labs)]


%% PCA
tic()
[fast_coeff,fast_score,fast_latent] = pca(in_X);
ind_pca = cal_new_clus(fast_score(:,1:CCC),CCC);  
toc_pca=toc();
tot_pca=[Cal_NMI(ind_pca,true_labs), purity(CCC, ind_pca, true_labs),RandIndex(ind_pca,true_labs)]


%% tsne
tic()
mappedX = tsne(in_X, true_labs, CCC);    
ind_tsne = cal_new_clus(mappedX,CCC);
toc_tsne=toc();
tot_tsne=[Cal_NMI(ind_tsne,true_labs), purity(CCC, ind_tsne, true_labs),RandIndex(ind_tsne,true_labs)]


%% SIMLR
tic()
[ind_SIMLR, S_simlr, F_simlr, ydata_simlr,alpha_simlr] = SIMLR(in_X,CCC);   
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
tot_mpssc



%% PSSC
rho=0.2; lam=0.0001; lam2=lam; eta=1; c=0.1;  
tic()
[P20] = clus_fin_update_no_learning(rho, lam, lam2, eta, c, in_X, true_labs); 
toc_mpssc0=toc();
[nmi11, nmi22,clus_dou1,clus01]=calc2_nmis(CCC, double(P20),true_labs) ;
pu11=purity(CCC, clus_dou1, true_labs);  pu22=purity(CCC, clus01, true_labs);
tot_mpssc0=[nmi11, nmi22;pu11,pu22; RandIndex(clus_dou1,true_labs),RandIndex(clus01,true_labs) ]';



%% Sparse Spectral Clustering
tic()
[Ps,objs,errs,iters] = sparsesc(eye(n)-SimGraph, 0.00001,CCC);
[V_tot1, temp, evs]=eig1(Ps, CCC); 
ind_sspec=litekmeans(V_tot1,CCC,'Replicates',100); 
toc_sspec=toc();
tot_sspec=[Cal_NMI(ind_sspec,true_labs),purity(CCC, ind_sspec, true_labs),RandIndex(ind_sspec,true_labs)]

title={'SC', 'SSC', 'KM','PCA','tSNE','SIMLR','PSSC', 'MPSSC'};
valtot=[tot_spec',tot_sspec',tot_kmean',tot_pca',tot_tsne',tot_simlr',tot_mpssc0(1,:)',tot_mpssc(1,:)'];
valtot=[valtot; toc_spec,toc_sspec,toc_kmean,toc_pca,toc_tsne,toc_simlr,toc_mpssc0,toc_mpssc];
valtot=[title; num2cell(valtot)]

%% valtot is a 3 by 8 matrix such that the first, second, and the third rows record NMI, Purity and ARI of the
%% eight clustering methods.



