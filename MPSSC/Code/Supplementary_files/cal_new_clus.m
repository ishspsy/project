function Clus = cal_new_clus(FF,k);
%% Computing clustering labels using k-means from the n by kk matrix FF.

[~,center] = litekmeans(FF, k,'replicates',20);
[~,center] = min(dist2(center,FF),[],2);
Clus = litekmeans(FF,k,'Start',center);