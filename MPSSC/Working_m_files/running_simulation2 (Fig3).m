%% run the six clustering methods for simulation model 2


addpath(genpath(pwd))
clear all

% gamma controls missing rate
gamma=1
% run the six clustering methods for simulation model 2
simulation_model2
save('main_sim_plot_rng_200_3_missing1_1.mat','p', 's', 'n_set','sigmamin', 'k_real', 'performance_set', 'missing_rate')


% gamma controls missing rate
gamma=0.6
% run the six clustering methods for simulation model 2
simulation_model2
save('main_sim_plot_rng_200_3_missing2_1.mat','p', 's', 'n_set','sigmamin', 'k_real', 'performance_set', 'missing_rate')
