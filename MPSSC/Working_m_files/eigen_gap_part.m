%% estimate the number of clusters

[n p]=size(in_X);
CCC=max(true_labs);
[P2] = clus_fin_update_number(in_X, true_labs);
[~, ~, evs]=eig1(P2); 







