%% Run algorithms for the six single-cell data sets.
%% real_data_place runs the 8 clustering methods;  'SC', 'SSC', 'KM(k-means)','PCA','tSNE','SIMLR','PSSC', 'MPSSC'
%% robust_generator performs PSSC and MPSSC by changing \lambda
%% robust_generator_rhos performs PSSC and MPSSC by changing \rho
%% robust_generator_cs performs PSSC and MPSSC by changing c
%% robust_generator_k performs PSSC and MPSSC by changing k


clear all
addpath(genpath(pwd))


%% Ting data

clear all
load('Data_Ting.mat')
real_data_place
save('Ting_results1102.mat','valtot')
robust_generator
save('Ting_robust_lam.mat', 'tot_mpssc_set', 'tot_mpssc0_set')
robust_generator_rhos
save('Ting_robust_rho.mat', 'tot_mpssc_set', 'tot_mpssc0_set')
robust_generator_cs
save('Ting_robust_c.mat', 'tot_mpssc_set', 'tot_mpssc0_set')
robust_generator_k
save('Ting_robust_k.mat', 'tot_mpssc_set', 'tot_mpssc0_set')


%% Treutlin data

clear all
load('Data_Treutlin.mat')
real_data_place
save('Treutlin_results1102.mat','valtot')
robust_generator
save('Treutlin_robust_lam.mat', 'tot_mpssc_set', 'tot_mpssc0_set')
robust_generator_rhos
save('Treutlin_robust_rho.mat', 'tot_mpssc_set', 'tot_mpssc0_set')
robust_generator_cs
save('Treutlin_robust_c.mat', 'tot_mpssc_set', 'tot_mpssc0_set')
robust_generator_k
save('Treutlin_robust_k.mat', 'tot_mpssc_set', 'tot_mpssc0_set')


%% Buettner data

clear all
load('Data_Buettner.mat')
real_data_place
save('Buettner_results1102.mat','valtot')
robust_generator
save('Buettner_robust_lam.mat', 'tot_mpssc_set', 'tot_mpssc0_set')
robust_generator_rhos
save('Buettner_robust_rho.mat', 'tot_mpssc_set', 'tot_mpssc0_set')
robust_generator_cs
save('Buettner_robust_c.mat', 'tot_mpssc_set', 'tot_mpssc0_set')
robust_generator_k
save('Buettner_robust_k.mat', 'tot_mpssc_set', 'tot_mpssc0_set')


%% Pollen data
clear all
load('Data_Pollen.mat')
real_data_place
save('Pollen_results1102.mat','valtot')
robust_generator
save('Pollen_robust_lam.mat', 'tot_mpssc_set', 'tot_mpssc0_set')
robust_generator_rhos
save('Pollen_robust_rho.mat', 'tot_mpssc_set', 'tot_mpssc0_set')
robust_generator_cs
save('Pollen_robust_c.mat', 'tot_mpssc_set', 'tot_mpssc0_set')
robust_generator_k
save('Pollen_robust_k.mat', 'tot_mpssc_set', 'tot_mpssc0_set')


%% Deng data
clear all
load('Data_Deng.mat')
real_data_place
save('Deng_results1102.mat','valtot')
robust_generator
save('Deng_robust_lam.mat', 'tot_mpssc_set', 'tot_mpssc0_set')
robust_generator_rhos
save('Deng_robust_rho.mat', 'tot_mpssc_set', 'tot_mpssc0_set')
robust_generator_cs
save('Deng_robust_c.mat', 'tot_mpssc_set', 'tot_mpssc0_set')
robust_generator_k
save('Deng_robust_k.mat', 'tot_mpssc_set', 'tot_mpssc0_set')



%% Ginhoux data
clear all
load('Data_Ginhoux.mat')
real_data_place
save('Ginhoux_results1102.mat','valtot')
robust_generator
save('Ginhoux_robust_lam.mat', 'tot_mpssc_set', 'tot_mpssc0_set')
robust_generator_rhos
save('Ginhoux_robust_rho.mat', 'tot_mpssc_set', 'tot_mpssc0_set')
robust_generator_cs
save('Ginhoux_robust_c.mat', 'tot_mpssc_set', 'tot_mpssc0_set')
robust_generator_k
save('Ginhoux_robust_k.mat', 'tot_mpssc_set', 'tot_mpssc0_set')

