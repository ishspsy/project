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

real_data_place_large
save('realdata10_tasic_except.mat','valtot')
Larger_MPSSC
save('Tasic_MPSSC.mat', 'tot_mpssc','tot_mpssc2','toc_mpssc','toc_mpssc2')
robust_generator_large
save('Tasic_robust_lam.mat', 'tot_mpssc_set')
robust_generator_large_rhos
save('Tasic_robust_rho.mat', 'tot_mpssc_set')
robust_generator_large_cs
save('Tasic_robust_c.mat', 'tot_mpssc_set')
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

