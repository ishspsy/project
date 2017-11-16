%% generating Figure S1
%% Refer simulation_robust2 (Fig S1).m and simulation_robust1 (Fig S1).m

addpath(genpath(pwd))

% loading files (See simulation_robust2 (Fig S1).m  for generating this file)
load('robust_mcase2.mat')
perf_summary=zeros(4,4,5); perf_std=zeros(4,4,5);
    for ii=1:4
        for jj=1:4
            for kk=1:5
                perf_set=zeros(1,50);
                parfor nn=1:50
                    perf=performance_set{nn}(ii,jj,kk); perf=perf{1}'; 
                    perf_set(nn)=perf(1);
                end
                perf_summary(ii,jj,kk)=mean(perf_set); perf_std(ii,jj,kk)=std(perf_set);
            end
        end
    end


c_set=[0.01, 0.05,0.1,1];  c_text={'0.01','0.05','0.1','1'}; fig_text={'A','B','C','D','E','F'};
lam1_set=[0.00001,0.0001, 0.001, 0.01]; 
lam2_set=[0.00001,0.0001, 0.001, 0.05, 0.01];
colors = {'b*-','r+-','kv-','gs-'};

clf
for ii=1:4;
c_val=c_text{ii}; fig_lab=fig_text{ii};
subplot(3,2,ii)
for jj=1:4
tt1=squeeze(perf_summary(ii,jj,1:4));
plot(1:4, tt1', colors{jj}); hold on
end
set(gca,'XTick',1:4);
xticklabels({'10^{-5}', '10^{-4}','10^{-3}','10^{-2}'});  %,'10^{-1}'})  %,'Interpreter','latex');
xlabel('\mu','FontSize',14)
ylabel(sprintf('NMI (c=%s)', c_val), 'FontSize',14)
hlegend=legend({'$$\lambda=10^{-5}$$', '$$\lambda=10^{-4}$$', '$$\lambda=10^{-3}$$', '$$\lambda=10^{-2}$$'}, 'Interpreter','latex')
hlegend.FontSize=12; hlegend.Location='southwest';
legend boxoff
htext=text(0.01,1.1, sprintf('%s',fig_lab),'Units','normalized')
htext.FontSize=20;
end


c_set=[0.01, 0.05,0.1,1];
lam=0.0001; lam2=0.0001;
kn_set=5:5:80;
rho_set=[0.01, 0.02, 0.04, 0.1, 0.2, 0.4, 1, 2, 4]; 


% loading files (See simulation_robust1 (Fig S1).m  for generating this file)
load('robust_E_mcase2.mat')

perf_summary=zeros(length(c_set),length(kn_set)); perf_std=perf_summary;
    for ii=1:length(c_set)
        for jj=1:length(kn_set)
            kk=5;
                perf_set=zeros(1,50);
                parfor nn=1:50
                    perf=performance_set{nn}(ii,jj,kk); perf=perf{1}'; 
                    perf_set(nn)=perf(1);
                end
                perf_summary(ii,jj)=mean(perf_set); perf_std(ii,jj)=std(perf_set);
            end
        end
    
ii=5;
subplot(3,2,ii)
for jj=1:4
tt1=squeeze(perf_summary(jj,:));
plot(wrev(kn_set), tt1, colors{jj}); hold on
end
hlegend=legend('c=0.01', 'c=0.05', 'c=0.1', 'c=1', 'Location','northeast')
hlegend.FontSize=12;
legend boxoff
xlim([5, 80]); %ylim([0.3, 0.9])
txlab=xlabel('$\tilde{k}$', 'Interpreter','latex');
txlab.FontSize=14   %'FontSize',14)
ylabel('NMI','FontSize',14)
htext=text(0.01,1.1,'E','Units','normalized')
htext.FontSize=20;


perf_summary=zeros(length(c_set),length(rho_set)); perf_std=perf_summary;
    for ii=1:length(c_set)
        for jj=1:length(rho_set)
            kk=2;
                perf_set=zeros(1,50);
                parfor nn=1:50
                    perf=performance_set{nn}(ii,kk,jj); perf=perf{1}'; 
                    perf_set(nn)=perf(1);
                end
                perf_summary(ii,jj)=mean(perf_set); perf_std(ii,jj)=std(perf_set);
            end
        end


ii=6;
subplot(3,2,ii)
for jj=1:4
tt1=squeeze(perf_summary(jj,:));
plot(rho_set, tt1, colors{jj}); hold on
end
hlegend=legend('c=0.01', 'c=0.05', 'c=0.1', 'c=1', 'Location','northeast')
hlegend.FontSize=12;
legend boxoff
xlim([0, 4]); %ylim([0.3, 0.9])
txlab=xlabel('$\rho$', 'Interpreter','latex');
txlab.FontSize=14   %'FontSize',14)
ylabel('NMI','FontSize',14)
htext=text(0.01,1.1,'F','Units','normalized')
htext.FontSize=20;


print -depsc  figure_robust_c_lam_mu2_miss2_recent

