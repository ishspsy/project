%% Run algorithms for the three large-scale single-cell data sets.
%% real_data_place_large runs the 8 clustering methods;  'SC', 'SSC', 'KM(k-means)','PCA','tSNE','SIMLR','PSSC', 'MPSSC'
%% robust_generator_large performs PSSC and MPSSC by changing \lambda
%% robust_generator_large_rhos performs PSSC and MPSSC by changing \rho
%% robust_generator_large_cs performs PSSC and MPSSC by changing c
%% robust_generator_large_k performs PSSC and MPSSC by changing k


%% NOTE: These are computational and memory-intensive parts, which were run on the computing cluster (6 CPUs, 800 GB of memory).



%% Tasic
clear all
load('Data_Tasic.mat')
in_X=double(in_X);  % the data of Tasic is single-type (due to size issue), thus need to be transferred to double type.

% run the other 6 clustering methods: each row of 'valtot' stands for NMI, Purity, and ARI, respectively.
real_data_place_large
save('realdata10_tasic_except.mat','valtot')

% run MPSSC and PSSC: 
% tot_mpssc and toc_mppsc are three performance measures and computation time (seconds) of MPSSC, respectively,
% tot_mpssc2 and toc_mppsc2 are three performance measures and computation time (seconds) of PSSC, respectively,
Larger_MPSSC
save('Tasic_MPSSC.mat', 'tot_mpssc','tot_mpssc2','toc_mpssc','toc_mpssc2')


% Note: each robustness check part takes about 30 minutes as it considers various regularization parameters cases.
% run MPSSC with various \lambda values from the set [0.00001, 0.00005, 0.0001, 0.0002, 0.0005, 0.001, 0.01, 0.1] for
% robustness check
robust_generator_large
save('Tasic_robust_lam.mat', 'tot_mpssc_set')

% run MPSSC with various \rho values from the set [0.001,0.01, 0.1, 0.2, 0.5, 1, 2, 5,10]for robustness check.
robust_generator_large_rhos
save('Tasic_robust_rho.mat', 'tot_mpssc_set')

% run MPSSC with various c values from the set [0.0001, 0.001,0.01, 0.1, 0.2, 0.5, 1] for robustness check.
robust_generator_large_cs
save('Tasic_robust_c.mat', 'tot_mpssc_set')

% run MPSSC with various k values from the set [5, 10, ..., 35, 40] for robustness check.
robust_generator_large_k
save('Tasic_robust_k.mat', 'tot_mpssc_set')



%% Zeisel
clear all
load('Data_Zeisel.mat')

real_data_place_large
save('realdata5_ziesel2_excep_MPSSC.mat','valtot')
Larger_MPSSC
save('Ziesel_MPSSC.mat', 'tot_mpssc','tot_mpssc2','toc_mpssc','toc_mpssc2')
robust_generator_large
save('Zeisel_robust_lam.mat', 'tot_mpssc_set')
robust_generator_large_rhos
save('Zeisel_robust_rho.mat', 'tot_mpssc_set')
robust_generator_large_cs
save('Zeisel_robust_c.mat', 'tot_mpssc_set')
robust_generator_large_k
save('Zeisel_robust_k.mat', 'tot_mpssc_set')



%% Macosko
clear all
load('Data_Macosko.mat')

real_data_place_large
save('realdata5_macosko_excep_MPSSC.mat','valtot')
Larger_MPSSC
save('Macosko_MPSSC.mat', 'tot_mpssc','tot_mpssc2','toc_mpssc','toc_mpssc2')
robust_generator_large
save('Macosko_robust_lam.mat', 'tot_mpssc_set')
robust_generator_large_rhos
save('Macosko_robust_rho.mat', 'tot_mpssc_set')
robust_generator_large_cs
save('Macosko_robust_c.mat', 'tot_mpssc_set')
robust_generator_large_k
save('Macosko_robust_k.mat', 'tot_mpssc_set')

