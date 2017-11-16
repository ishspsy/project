%% generating plots about robustness of MPSSC for the larger-scale data sets.
%% All the loading files can be generated in running_large_scRNA (Fig5).m

clear all
addpath(genpath(pwd))


%% Figure S11-S13

dataset = {'Tasic', 'Zeisel', 'Macosko'}   %% Three large-scale data sets                  

colors = {'b*-','r+-','kv-','gs-'};
lam_set=[0.000001, 0.00001, 0.00005, 0.0001, 0.0002, 0.0005, 0.001, 0.01];
lam_set2=[0.00005, 0.0001, 0.0002, 0.0005, 0.001];


for i=1:3

load([dataset{i} '_robust_lam' ]);

if i <= 2 
 tot_val=[];
 for ii=1:length(lam_set)
 tot_val=[tot_val;tot_mpssc_set{ii}(1,:)];
end
else
 tot_val=[];
 for ii=1:length(lam_set2)
 tot_val=[tot_val;tot_mpssc_set{ii}(1,:)];
 end
end

    
clf
subplot(2,2,1)

if i <= 2 
for ii=1:3
pplo=plot(1:5,tot_val(3:7,ii),colors{ii}); pplo.LineWidth=1.5;  hold on
end
else
for ii=1:3
pplo=plot(1:5,tot_val(:,ii),colors{ii}); pplo.LineWidth=1.5;  hold on
end
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









