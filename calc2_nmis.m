function  [nmi1, nmi2,clus_dou,clus0]=calc2_nmis(CCC, P2,true_labs)   % W_euc_nearest_double

[V, temp, evs]=eig1(P2, CCC);    V=V./ repmat(sqrt(sum(V.^2,2)),1,CCC);   
[clus0,center] = litekmeans(V, CCC,'replicates',20);
[~,center] = min(dist2(center,V),[],2);
clus_dou = litekmeans(V,CCC,'Start',center);
nmi1=Cal_NMI(clus_dou,true_labs);
nmi2=Cal_NMI(clus0,true_labs);