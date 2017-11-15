# MPSSC: Spectral clustering based on learning similarity matrix



## Overview

*MPSSC* is a novel spectral clustering framework that imposes sparse structures on a target matrix. Specifically, it utilizes a doubly stochastic affinity matrix to construct a normalized graph Laplacian. Then, it imposes a sparse structure on the target matrix followed by shrinking pairwise differences of the rows in the target matrix. This spectral clustering method uses multiple similarity matrices via non-convex optimization framework. The proposed non-convex problem iteratively using the ADMM algorithm.

### Main functions

clus_fin_update.m:   MPSSC algorithm (with similarity learning) consisting of the three steps.

clus_fin_update_no_learning.m:   PSSC algorithm (without similarity learning). 

func_doubly.m:  Contruct multiple doubly stochastic similarity matrices using Gaussian kernels (Step 1).

clus_sim_update2_2.m:  Obtain the intermediae target matrix involving ADMM (Step 2).

clus_sim_update0_3.m:  Obtain the final target matrix involving ADMM (Step 3)


### Example files
run_real_data_results.m: Example (small-scale scRNA-seq data sets)

run_real_data_results_large.m: Example (large-scale scRNA-seq data sets)


**Note** Most of the simulations and scRNA-seq applications were implemented on an Apple MacBook Pro (2.7 GHz, 8 GB of memory) using the MATLAB 2016b. However, certain computational or memory-intensive steps (e.g. larger-scale data sets) were run on the computing cluster (6 CPUs, 800 GB of memory).




```
Example:

clear all
addpath(genpath(pwd))

load('Data_Deng.mat')
% Each data contains in_X and true_labs, where in_X is an n by p gene expression matrix and true_labs is 
the ground truth labels, where n and p are number of cells and genes, respectively.

% We suggest to use the following specification in implementation:
rho=0.2; lam=0.0001; lam2=lam; eta=1; c=0.1;  

%% Run MPSSC and obtain the target matrix P
[P] = clus_fin_update(rho, lam, lam2, eta, c, in_X, true_labs); 

%% Run PSSC and obtain the target matrix P0
[P0] = clus_fin_update_no_learning(rho, lam, lam2, eta, c, in_X, true_labs);

% Obtain clustering labels clus_labs (MPSSC) and clus_labs0 (PSSC), respectively:
[NMI, ~,clus_labs,~]=calc2_nmis(CCC, double(P),true_labs);   
[NMI0, ~,clus_labs0,~]=calc2_nmis(CCC, double(P0),true_labs);   

% Purity
Purity=purity(CCC, clus_labs, true_labs)
Purity0=purity(CCC, clus_labs0, true_labs)

% ARI
ARI=RandIndex(clus_labs,true_labs)
ARI0=RandIndex(clus_labs0,true_labs)

% Performances of MPSSC
[NMI, Purity, ARI]
% Performances of PSSC
[NMI0, Purity0, ARI0]


```

### Codes

All the functions used in the proposed algorithm are located in the directory "Functions".

All the matlab codes related to generating plots shown in the manuscript are located in the directory "Working_m_files".

All the resulting files such as .MAT and .eps types are located in the directory "Results_files".

The nine scRNA-seq data sets used in the manuscript are located in the directory "Data_files".



The remainning directories:

"SIMLR" includes all the files related to *SIMLR*.

"SparseSC"  includes all the files related to Sparse spectral clustering (*SSC*).

"tSNE"  includes all the files related to *t-SNE*.

Specifically, the codes of *SIMLR* refers to https://github.com/BatzoglouLabSU/SIMLR, *SparseSC* refers to https://github.com/canyilu/LibADMM, and *tSNE* refers to https://lvdmaaten.github.io/tsne/.


## Example data sets

The 9 example datasets are provided in the directory *Data_files*. 

Specifically, the dataset of Data_Deng.mat refers to http://science.sciencemag.org/content/343/6167/193.

Data_Ting.mat refers to https://www.ncbi.nlm.nih.gov/pubmed/25242334. 

Data_Treutlin.mat refers to https://www.ncbi.nlm.nih.gov/pubmed/24739965. 

Data_Ginhoux.mat refers to https://www.ncbi.nlm.nih.gov/pubmed/26054720.

Data_Buettner.mat refers to https://www.ncbi.nlm.nih.gov/pubmed/25599176. 

Data_Pollen.mat refers to https://www.nature.com/articles/nbt.2967. 

For the large scale data, Data_Zeisel.mat refers to https://www.ncbi.nlm.nih.gov/pubmed/25700174.

Data_Tasic.mat refers to https://www.ncbi.nlm.nih.gov/pubmed/26727548. 

Data_Macosko.mat refers to https://www.ncbi.nlm.nih.gov/pubmed/26000488.


**DOWNLOAD**

We provide MATLAB implementations of *MPSSC* in the MPSSC branch.


## Authors

* **Seyoung Park** and   **Hongyu Zhao**


## License

This project is licensed under the MIT License.



