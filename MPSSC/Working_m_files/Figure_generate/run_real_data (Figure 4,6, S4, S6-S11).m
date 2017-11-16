%% generating figures related to six small-scale scRNA-seq data sets
%% All the loading files can be generated in running_small_scRNA (Fig4,6).m


clear all
addpath(genpath(pwd))



%% Deng plots (Fig 6.B)
clear all
load('Data_Deng.mat')

%Running clustering methods
real_data_place

rng(150)

%Visualization
ydata = tsne_p_bo(P2);  

%save('Visual_Deng.mat', 'P2', 'ydata')
load('Visual_Deng.mat')

clf
gscatter(ydata(:,1), ydata(:,2), true_labs,'brgmk','.xo>+^<',7,'off')  
hlegend=legend('early-2cell','mid-2cell','late-2cell','4cell','8cell','16cell','zygoto')
hlegend.FontSize=16
xlabel('x')
ylabel('y')
set(gca, 'fontsize', 15)
htext=text(0.01,1.03,'B (Deng)','Units','normalized')
htext.FontSize=20;
print -depsc visu_deng



%% Ginhoux plots (Fig 6.A)

clear all
load('Data_Ginhoux.mat')

%Running clustering methods
real_data_place
rng(150)

%Visualization
ydata = tsne_p_bo(P2); 
clf
gscatter(ydata(:,1), ydata(:,2), true_labs,'brgmk','.xo>+^<',7,'off')  
hlegend=legend('CDP','PreDC','MDP')
hlegend.FontSize=16
xlabel('x')
ylabel('y')
set(gca, 'fontsize', 15)
htext=text(0.01,1.03,'A (Ginhoux)','Units','normalized')
htext.FontSize=20;
print -depsc visu_Ginhoux





%% Drawing figures

method_title={'SC', 'SSC', 'KM','PCA','tSNE','SIMLR', 'PSSC', 'MPSSC'};
dataname = {'Ting', 'Treutlein', 'Deng', 'Ginhoux', 'Pollen','Buettner'}     


%load('Ting_results1102.mat')
%load('Treutlin_results1102.mat')  
%load('Deng_results1102.mat')
%load('Ginhoux_results1102.mat')
%load('Pollen_results1102.mat')
%load('Buettner_results1102.mat')



%% Figure 4(A)
clear vars title
clf
for i=1:6
load([dataname{i} '_results1102']);    
val1=cell2mat(valtot(2,:));    
subplot(3,2,i)
hold on
ttt1=bar(1:8,val1);  
set(gca,'XTick',1:1:8)
xlim([0 9]);  ylim([min(val1)-0.2  min(1,max(val1)+0.1)])     %ylim([0.3 1])
ylabel('NMI', 'FontSize', 15)
xticklabels({'SC'    'SSC' 'K-mean'   'PCA'    't-SNE'    'SIMLR'    'PSSC'    'MPSSC'});   xtickangle(45)
title(sprintf('%s',dataname{i}));
if i==1
    htext=text(-0.2,1.2,'A','Units','normalized')
    htext.FontSize=20;
end
set(gca,'FontSize', 14);
end
print -depsc real_data_nmi  



%% Figure 4(B)
clf
for i=1:6
load([dataname{i} '_results1102']);    
val1=cell2mat(valtot(5,:));
subplot(3,2,i)
hold on
ttt1=bar(1:8,val1);  
set(gca,'XTick',1:1:8)
xlim([0 9]); 
ylabel('Time (seconds)', 'FontSize', 12)
xticklabels({'SC'    'SSC' 'K-mean'   'PCA'    't-SNE'    'SIMLR'    'PSSC'    'MPSSC'});   xtickangle(45)
if i==1
    htext=text(-0.2,1.2,'B','Units','normalized')
    htext.FontSize=20;
end
title(sprintf('%s',dataname{i}));
set(gca,'FontSize', 14);
end

print -depsc real_data_computation 


%% Figure S4
clf
for i=1:6
load([dataname{i} '_results1102']);    
val1=cell2mat(valtot(4,:));
subplot(3,2,i)
hold on
ttt1=bar(1:8,val1); 
set(gca,'XTick',1:1:8)
xlim([0 9]);   
ylabel('ARI', 'FontSize', 15)
xticklabels({'SC'    'SSC' 'K-mean'   'PCA'    't-SNE'    'SIMLR'    'PSSC'    'MPSSC'});   xtickangle(45)
if i==1
    htext=text(-0.2,1.2,'B','Units','normalized')
    htext.FontSize=20;
end
title(sprintf('%s',dataname{i}));
set(gca,'FontSize', 14);
end

print -depsc real_data_ari


clf
for i=1:6
load([dataname{i} '_results1102']);    
val1=cell2mat(valtot(3,:));
subplot(3,2,i)
hold on
ttt1=bar(1:8,val1); 
set(gca,'XTick',1:1:8)
xlim([0 9]);  ylim([min(val1)-0.2  min(1,max(val1)+0.1)])  
ylabel('Purity', 'FontSize', 15)
xticklabels({'SC'    'SSC' 'K-mean'   'PCA'    't-SNE'    'SIMLR'    'PSSC'    'MPSSC'});   xtickangle(45)
if i==1
    htext=text(-0.2,1.2,'A','Units','normalized')
    htext.FontSize=20;
end
title(sprintf('%s',dataname{i}));
set(gca,'FontSize', 14);
end

print -depsc real_data_purity



%% Figure S6-S11

dataset = {'Pollen', 'Buettner', 'Ginhoux', 'Deng', 'Ting','Treutlin'}            
%load([dataset{i} '_robust_lam' ]);
%load([dataset{i} '_robust_rho' ]);
%load([dataset{i} '_robust_c' ]);

for i=1:6
colors = {'b*-','r+-','kv-','gs-'};
lam_set=[0.00001, 0.00005, 0.0001, 0.0002, 0.0005, 0.001, 0.01, 0.1];
load([dataset{i} '_robust_lam' ]);
tot_val=[];
for ii=1:length(lam_set)
tot_val=[tot_val;tot_mpssc_set{ii}(1,:)];
end

    
clf
subplot(2,2,1)
for ii=1:3
pplo=plot(1:5,tot_val(2:6,ii),colors{ii}); pplo.LineWidth=1.5;  hold on
end
xlim([1 5])
set(gca,'XTick',1:5);
xticklabels({'0.00005', '0.0001', '0.0002', '0.0005', '0.001'}); 
hlegend=legend('NMI', 'Purity', 'ARI')
hlegend.FontSize=12; hlegend.Location='east';
htext=text(0.01,1.04, 'A','Units','normalized')
htext.FontSize=20;
xlabel('$\lambda$', 'Interpreter','latex');
htitle=title(sprintf( '%s',dataset{i}))
set(gca, 'FontSize',15)


load([dataset{i} '_robust_rho' ]);
colors = {'b*-','r+-','kv-','gs-'};
rho_set=[0.001,0.01, 0.1, 0.2, 0.5, 1, 2, 5,10];
tot_val=[];
for ii=1:length(rho_set)
tot_val=[tot_val;tot_mpssc_set{ii}(1,:)];
end

    
subplot(2,2,2)
for ii=1:3
pplo=plot(1:9,tot_val(:,ii),colors{ii});pplo.LineWidth=1.5; hold on
end
xlim([1 9])
set(gca,'XTick',1:9);
xticklabels({'0.001','0.01', '0.1', '0.2', '0.5', '1', '2', '5','10'}); 
hlegend=legend('NMI', 'Purity', 'ARI')
hlegend.FontSize=12; hlegend.Location='east';
htext=text(0.01,1.04, 'B','Units','normalized')
htext.FontSize=20;
xlabel('$\rho$', 'Interpreter','latex');
htitle=title(sprintf( '%s',dataset{i}))
set(gca, 'FontSize',15)




c_set=[0.0001, 0.001,0.01, 0.1, 0.2, 0.5, 1];
load([dataset{i} '_robust_c' ]);
colors = {'b*-','r+-','kv-','gs-'};
tot_val=[];
for ii=1:length(c_set)
tot_val=[tot_val;tot_mpssc_set{ii}(1,:)];
end


subplot(2,2,3)
for ii=1:3
pplo=plot(1:7,tot_val(:,ii),colors{ii});pplo.LineWidth=1.5; hold on
end
set(gca,'XTick',1:7);
xlim([1 7])
xticklabels({'0.0001', '0.001','0.01', '0.1', '0.2', '0.5', '1'}); 
hlegend=legend('NMI', 'Purity', 'ARI')
hlegend.FontSize=12; hlegend.Location='east';
htext=text(0.01,1.04, 'C','Units','normalized')
htext.FontSize=20;
xlabel('$c$', 'Interpreter','latex');
htitle=title(sprintf( '%s',dataset{i}))
set(gca, 'FontSize',15)



k_set=5:5:40;
load([dataset{i} '_robust_k' ]);
colors = {'b*-','r+-','kv-','gs-'};
tot_val=[];
for ii=1:length(k_set)
tot_val=[tot_val;tot_mpssc_set{ii}(1,:)];
end



subplot(2,2,4)
for ii=1:3
pplo=plot(1:8,tot_val(:,ii),colors{ii});pplo.LineWidth=1.5; hold on
end
xlim([1 8])
set(gca,'XTick',1:8);
xticklabels({'5'  '10'    '15'    '20'    '25'    '30'    '35'    '40'}); 
hlegend=legend('NMI', 'Purity', 'ARI')
hlegend.FontSize=12; hlegend.Location='east';
htext=text(0.01,1.04, 'D','Units','normalized')
htext.FontSize=20;
xlabel('$k$', 'Interpreter','latex');
htitle=title(sprintf( '%s',dataset{i}))
set(gca, 'FontSize',15)

print([sprintf( 'Real_Robust_sets_%s',dataset{i})],'-depsc')

end


















