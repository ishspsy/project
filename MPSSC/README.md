# MPSSC: Spectral clustering based on learning similarity matrix



## Overview

*MPSSC* is a novel spectral clustering framework that imposes sparse structures on a target matrix. Specifically, it utilizes multiple doubly stochastic affinity matrices to construct a normalized graph Laplacian (Step 1). Then, it imposes a sparse structure on the target matrix (Step 2) followed by shrinking pairwise differences of the rows in the target matrix (Step 3). This spectral clustering method uses multiple similarity matrices via non-convex optimization framework. *MPSSC* solves the proposed non-convex problem iteratively with the embedded ADMM algorithm.

### Main functions

clus_fin_update.m:   Main *MPSSC* algorithm (with similarity learning) consisting of the three steps.

clus_fin_update_no_learning.m:  Main *PSSC* algorithm (without similarity learning). 

func_doubly.m:  Contruct multiple doubly stochastic similarity matrices using Gaussian kernels (Step 1).

clus_sim_update2_2.m:  Obtain the intermediae target matrix involving ADMM (Step 2).

clus_sim_update0_3.m:  Obtain the final target matrix involving ADMM (Step 3)


### Example files
Working_m_files/running_small_scRNA (Fig4,6).m: Generate all the results related to the six small-scale scRNA-seq data sets

Working_m_files/running_large_scRNA (Fig5).m: Generate all the results related to the three large-scale scRNA-seq data sets.
These were run on the computing cluster (6 CPUs, 800 GB of memory).


**Note** Most of the simulations and scRNA-seq applications were implemented on an Apple MacBook Pro (2.7 GHz, 8 GB of memory) using the MATLAB 2016b. However, certain computational or memory-intensive steps (e.g. larger-scale data sets) were run on the computing cluster (6 CPUs, 800 GB of memory).




```
%Example using Deng data set:

clear all
addpath(genpath(pwd))


%% load data sets ('in_X' and 'true_labs')
load('Data_Deng.mat')

% Note: one can use any data set that consists of in_X and true_labs, where in_X is an n by p gene 
%expression matrix and true_labs is the ground truth labels. Here n and p are number of cells and 
%genes, respectively.


%% Penalty parameters. We suggest to use the following specification:
rho=0.2; lam=0.0001; lam2=lam; eta=1; c=0.1;  


%% Run MPSSC and obtain the target matrix P
[P] = clus_fin_update(rho, lam, lam2, eta, c, in_X, true_labs); 

%% Obtain clustering labels clus_labs and compute NMI measure:
[NMI, ~,clus_labs,~]=calc2_nmis(max(true_labs), double(P),true_labs);   

%% Compute performance measures
% Compute Purity
Purity=purity(max(true_labs), clus_labs, true_labs)

% Compute ARI
ARI=RandIndex(clus_labs,true_labs)

%%% Final output: Performances (three measures) of MPSSC
[NMI, Purity, ARI]


```

### Other examples

Please follow the links to briefly walk you through the applications of *MPSSC* to real scRNA-seq data sets

-  [small-scale scRNA-seq data sets](https://github.com/ishspsy/project/blob/master/MPSSC/Working_m_files/running_small_scRNA%20(Fig4%2C6).m)

-  [large-scale scRNA-seq data sets](https://github.com/ishspsy/project/blob/master/MPSSC/Working_m_files/running_large_scRNA%20(Fig5).m)




### Directory

All the functions used in the proposed algorithm are located in the directory "**Code**".

All the other important matlab functions are located in the directory "**Working_m_files**".

**All the codes generating figures and results shown in the manuscript are located in the directory "Working_m_files/Figure_generate"**

All the resulting files (e.g. .MAT and .eps) are located in the directory "**Results_files**".

The nine scRNA-seq data sets used in the manuscript are located in the directory "**Data**".



The other directories:

"SIMLR" includes all the files related to *SIMLR*.

"SparseSC"  includes all the files related to Sparse spectral clustering (*SSC*).

"tSNE"  includes all the files related to *t-SNE*.

"KPCA.1" includes the files related to kernel construction.

Specifically, the codes of *SIMLR* refers to https://github.com/BatzoglouLabSU/SIMLR, *SparseSC* refers to https://github.com/canyilu/LibADMM, *tSNE* refers to https://lvdmaaten.github.io/tsne/, and *KPCA.1* refers to
https://arxiv.org/abs/1207.3538.



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


## DOWNLOAD

We provide MATLAB implementations of *MPSSC* in the MPSSC branch.


## Authors

* **Seyoung Park** and   **Hongyu Zhao**

Department of Biostatistics, School of Public Health, Yale University


## License

This project is licensed under the MIT License.



