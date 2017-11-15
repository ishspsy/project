%% run the six clustering methods for simulation model 1

clear all
addpath(genpath(pwd))

%% running clustering algorithms for simulation model 1

gamma=0.01;
simulation_model1
%save('main_sim_plot_rng_150_001.mat', 'performance_set', 'missing_rate')

gamma=0.006;
simulation_model1
%save('main_sim_plot_rng_150_0006.mat', 'performance_set', 'missing_rate')

