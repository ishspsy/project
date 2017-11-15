%% generating plots for the simulation model 2
%% Refer running_simulation2 (Fig3).m and running_simulation2 (Fig3).m for generating loading files


% loading file; See running_simulation2 (Fig3).m for generating this file
load('main_sim_plot_rng_200_3_missing1_1.mat')
ind_method=1:6;  
avg_perf=0;  sqr_perf=0;
for ii=1:50
    avg_perf=avg_perf+performance_set{ii}/50;
    sqr_perf=sqr_perf+(performance_set{ii}.^2)/50;
end
vars=sqr_perf-avg_perf.^2;  stds=sqrt(vars);

mat_perf=zeros(6,50); 
for ii=1:50
    mat_perf(:,ii)=performance_set{ii}(1,ind_method)';
end
pp_set=[];
for ii=1:6
[hh, pp]= ttest(mat_perf(ii,:),mat_perf(6,:)); pp_set=[pp_set,pp];
end
avg_perf(1,ind_method)


title={'SC', 'SSC', 'tSNE','SIMLR', 'PSSC', 'MPSSC'};

mean_val1= avg_perf(1,ind_method);
std_val1=stds(1,ind_method);

ylim1=min(mean_val1)-0.1; ylim2=max(mean_val1)+0.1;
clf
subplot(1,2,1)
%figure
hold on
ttt1=bar(1:6,mean_val1); 
ttt2=errorbar(1:6,mean_val1,std_val1,'.'); ttt2.Color='k'
set(gca,'XTick',1:1:6)
ttt=xlabel('Method'); ttt.FontSize=15;
xlim([0 7]); 
ylabel('NMI', 'FontSize', 15)
alpha 0.5
xticklabels({'SC'    'SSC'     'tSNE'    'SIMLR'    'PSSC'  'MPSSC'});   xtickangle(45)
htext=text(-0.06,1.06,'C','Units','normalized')
htext.FontSize=20;
set(gca,'FontSize', 14);



% loading file; See running_simulation2 (Fig3).m for generating this file
load('main_sim_plot_rng_200_3_missing2_1.mat')
avg_perf=0;  sqr_perf=0;
for ii=1:50
    avg_perf=avg_perf+performance_set{ii}/50;
    sqr_perf=sqr_perf+(performance_set{ii}.^2)/50;
end
vars=sqr_perf-avg_perf.^2;  stds=sqrt(vars);

mat_perf=zeros(6,50); 
for ii=1:50
    mat_perf(:,ii)=performance_set{ii}(1,ind_method)';
end
pp_set=[];
for ii=1:6
[hh, pp]= ttest(mat_perf(ii,:),mat_perf(6,:)); pp_set=[pp_set,pp];
end
avg_perf(1,ind_method)


title={'SC', 'SSC', 'tSNE','SIMLR', 'PSSC', 'MPSSC'};


mean_val1= avg_perf(1,ind_method);
std_val1=stds(1,ind_method);

ylim1=min(mean_val1)-0.1; ylim2=max(mean_val1)+0.1;

subplot(1,2,2)
hold on
ttt1=bar(1:6,mean_val1);  %ttt1.FaceColor='k'
ttt2=errorbar(1:6,mean_val1,std_val1,'.'); ttt2.Color='k'
set(gca,'XTick',1:1:6)
ttt=xlabel('Method'); ttt.FontSize=15;
xlim([0 7]); %ylim([0.45 0.9])
ylabel('NMI', 'FontSize', 15)
alpha 0.5
xticklabels({'SC'    'SSC'       'tSNE'    'SIMLR'     'PSSC' 'MPSSC'});   xtickangle(45)
htext=text(-0.06,1.06,'D','Units','normalized')
htext.FontSize=20;
set(gca,'FontSize', 14);


fig = gcf;
fgP = fig.Position;
fgP(4) = fgP(4)/2.5;

set(gcf,'PaperPositionMode','auto');
print -depsc simulation_mixture_plot_miss2

