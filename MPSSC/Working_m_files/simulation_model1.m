%% runs the six clustering methods for simulation model1


rng(150)

sigma_set=1:0.25:2;
k_set=10:2:30;

NNN=50;

performance_set=cell(1,NNN); missing_rate=[];
parfor ddd=1:NNN
%%simulation
B=2; CCC=10; N=250; cent=cell(1,CCC); M=500; C=CCC; sss=50;

for tt=1:CCC
    cent{tt}=10+10*[cos(tt*2*pi/CCC), sin(tt*2*pi/CCC)];
end

nnum=50:50:N; nnum=[50, 100, 150, 220,250];

gg_set=2*ones(1,CCC);   gg_set=[1*ones(1,CCC-4), 3*ones(1,4)];

Z=[];
for ii=1:nnum(1);
    Z=[Z; cent{1}+[gg_set(1)*normrnd(0,1), gg_set(1)*normrnd(0,1)]];
end;

for kk=2:length(nnum)
    for ii=nnum(kk-1)+1:nnum(kk)
            Z=[Z;cent{kk}+[gg_set(kk)*normrnd(0,1), gg_set(kk)*normrnd(0,1)]];
    end
end

true_labs=ones(nnum(1),1);
for kk=2:length(nnum)
    true_labs=[true_labs;kk*ones(nnum(kk)-nnum(kk-1),1)];
end


PP=1*rand(B,M);   var_noise=0.1;  var_noise=1;  PP(:,(sss+1):end)=0;
X=1*Z*PP; X_true1=X; X=X+normrnd(0,var_noise,[N M]); X_true2=X;

X=X_true2;

X=X_true2.*(binornd(1,1-exp(-gamma*X_true2.^2)));  sum(sum(abs(X)==0))/(size(X,1)*size(X,2))

Y=X; y=true_labs; [n,p]=size(X); kkk=max(true_labs); r=kkk; C=max(y); CCC=C;
in_X=X;
missing_rate=[missing_rate, sum(sum(abs(X)==0))/(size(X,1)*size(X,2))];

C = max(true_labs); CCC=C; X=in_X; Y=X; [n p]=size(X); N=n;
[n p]=size(Y); X=Y; N=n;


%% spectral clustering
tic()
SimGraph= func_simlarity(in_X);
ind_spec= SpectralClustering(SimGraph, C, 2);
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
[Ps,~,~,~] = sparsesc(eye(size(SimGraph,1))-SimGraph, 0.00001,CCC);
[V_tot1, temp, evs]=eig1(Ps, CCC);
ind_sspec=litekmeans(V_tot1,CCC,'Replicates',100);  %% run k-means on embeddings to get cell populations
toc_sspec=toc();
tot_sspec=[Cal_NMI(ind_sspec,true_labs),purity(CCC, ind_sspec, true_labs),RandIndex(ind_sspec,true_labs)]

%title={'SC', 'SSC', 'KM','PCA','KPCA','tSNE','SIMLR', 'PSSC', 'MPSSC'};
valtot=[tot_spec',tot_sspec',tot_tsne',tot_simlr',tot_mpssc0(1,:)',tot_mpssc(1,:)'];
valtot=[valtot; toc_spec,toc_sspec,toc_tsne,toc_simlr,toc_mpssc0,toc_mpssc];
performance_set{ddd}=valtot;
end


avg_perf=0;
for ii=1:50
    avg_perf=avg_perf+performance_set{ii}/50;
end
title={'SC', 'SSC','tSNE','SIMLR', 'PSSC','MPSSC'};
[title; num2cell(avg_perf)]
avg_perf
