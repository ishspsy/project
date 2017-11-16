%% generate figures related to three larger-scale scRNA-seq data sets
%% All the loading files can be generated in running_large_scRNA (Fig5).m

addpath(genpath(pwd))
%% Figure 5
rng(100)
method_title={'SC', 'SSC', 'KM','PCA','tSNE','SIMLR', 'PSSC', 'MPSSC'};
dataname = {'Tasic', 'Zeisel', 'Macosko'} 




%% Tasic
addpath(genpath(pwd)) 
load('realdata10_tasic_except.mat')
load('Tasic_MPSSC.mat')
valtot=[valtot, [tot_mpssc2, toc_mpssc2]',[tot_mpssc, toc_mpssc]'];
method_title={'SC', 'SSC', 'KM','PCA','tSNE','SIMLR', 'PSSC', 'MPSSC'};
valtot=[method_title;  num2cell(valtot)]
valtot_set{1}=valtot;


%% Ziesel
load('realdata5_ziesel2_excep_MPSSC2.mat')
load('Ziesel_MPSSC.mat')
valtot=[valtot, [tot_mpssc2, toc_mpssc2]',[tot_mpssc, toc_mpssc]'];
method_title={'SC', 'SSC', 'KM','PCA','tSNE','SIMLR', 'PSSC', 'MPSSC'};
valtot=[method_title;  num2cell(valtot)]
valtot_set{2}=valtot;


%% Macosko
load('realdata5_macosko_excep_MPSSC.mat')
load('Macosko_MPSSC.mat')
valtot=[valtot, [tot_mpssc2, toc_mpssc2]',[tot_mpssc, toc_mpssc]'];
method_title={'SC', 'SSC', 'KM','PCA','tSNE','SIMLR', 'PSSC', 'MPSSC'};
valtot=[method_title;  num2cell(valtot)]
valtot_set{3}=valtot;


clear vars title

clf
for i=1:3
subplot(1,3,i)
val1=cell2mat(valtot_set{i}(2,:));
hold on
ttt1=bar(1:8,val1);  
set(gca,'XTick',1:1:8)
xlim([0 9]);  ylim([min(val1)-0.03 max(val1)+0.03])
ylabel('NMI', 'FontSize', 15)
xticklabels({'SC'    'SSC' 'K-mean'   'PCA'    't-SNE'    'SIMLR'    'PSSC'    'MPSSC'});   xtickangle(45)
htitle=title(sprintf('%s',dataname{i})); htitle.FontSize=16;
if i==1
    htext=text(-0.1,1.07,'A','Units','normalized')
    htext.FontSize=20;
end
set(gca,'FontSize', 14);
end
print -depsc real_large_data_nmi


clf
for i=1:3
subplot(1,3,i)
val1=cell2mat(valtot_set{i}(3,:));
hold on
ttt1=bar(1:8,val1);
set(gca,'XTick',1:1:8)
xlim([0 9]);   ylim([min(val1)-0.03 max(val1)+0.03])
ylabel('Purity', 'FontSize', 15)
xticklabels({'SC'    'SSC' 'K-mean'   'PCA'    't-SNE'    'SIMLR'    'PSSC'    'MPSSC'});   xtickangle(45)
htitle=title(sprintf('%s',dataname{i})); htitle.FontSize=16;
set(gca,'FontSize', 14);
if i==1
    htext=text(-0.1,1.07,'A','Units','normalized')
    htext.FontSize=20;
end
end
print -depsc real_large_data_purity


clf
for i=1:3
subplot(1,3,i)
val1=cell2mat(valtot_set{i}(4,:));
hold on
ttt1=bar(1:8,val1); 
set(gca,'XTick',1:1:8)
xlim([0 9]);  ylim([min(val1)-0.03 max(val1)+0.03])
ylabel('ARI', 'FontSize', 15)
xticklabels({'SC'    'SSC' 'K-mean'   'PCA'    't-SNE'    'SIMLR'    'PSSC'    'MPSSC'});   xtickangle(45)
htitle=title(sprintf('%s',dataname{i})); htitle.FontSize=16;
set(gca,'FontSize', 14);
if i==1
    htext=text(-0.1,1.07,'B','Units','normalized')
    htext.FontSize=20;
end
end
print -depsc real_large_data_ari



clf
for i=1:3
subplot(1,3,i)
val1=cell2mat(valtot_set{i}(5,:))/60;
hold on
ttt1=bar(1:8,val1);  
set(gca,'XTick',1:1:8)
xlim([0 9]);  
ylabel('Time (minutes)', 'FontSize', 12)
xticklabels({'SC'    'SSC' 'K-mean'   'PCA'    't-SNE'    'SIMLR'    'PSSC'    'MPSSC'});   xtickangle(45)
htitile=title(sprintf('%s',dataname{i})); htitile.FontSize=16;
set(gca,'FontSize', 14);
if i==1
    htext=text(-0.1,1.07,'B','Units','normalized')
    htext.FontSize=20;
end
end
print -depsc real_large_data_computation












