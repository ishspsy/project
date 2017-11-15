function  [nmi1, nmi2,clus_dou,clus0]=calc2_nmis(CCC, P2,true_labs)
%% Compute nmi and clustering results based on obtained target matrix.


[V, temp, evs]=eig1(P2, CCC);
V=V./ repmat(sqrt(sum(V.^2,2)),1,CCC);
[clus0,center] = litekmeans(V, CCC,'replicates',100);
[~,center] = min(dist2(center,V),[],2);
clus_dou = litekmeans(V,CCC,'Start',center);

%% no replicates when computing k-means
nmi1=Cal_NMI(clus_dou,true_labs);

%% replicates when computing k-means
nmi2=Cal_NMI(clus0,true_labs);