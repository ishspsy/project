MPSSC: Using Multiple kernels with pairwise and element-wise sparse spectral clustering  

MPSSC is a novel spectral clustering framework that imposes sparse structures on a target matrix. Specifically,it utilizes a doubly stochastic affinity matrix to construct a normalized graph Laplacian. Then, it imposes a sparse structure on the target matrix followed by shrinking pairwise differences of the rows in the target matrix. This spectral clustering method uses multiple similarity matrices via non-convex optimization framework. The proposed non-convex problem iteratively using the ADMM algorithm.


Code:
SK_normalize.m: Perform SK algorithm to obtain a doubly stochastic matrix (Step 1).
clus_sim_update0_2.m: ADMM algorithm (Step 2).
clus_sim_update2_2.m: An iterative algorithm solving the proposed biconvex problem (Step 2).
clus_sim_update0_3.m: ADMM algorithm (Step 3).
main_working.m: Example


Contact the Author 
Author: Seyoung Park and Hongyu Zhao
Email: seyoung.park@yale.edu




Reference 
Spectral clustering based on learning similarity matrix