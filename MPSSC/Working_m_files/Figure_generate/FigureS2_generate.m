%%%% Genereating Figure S2.

clear all
addpath(genpath(pwd))


clf;
%% Pollen   % similar when 15   goodt
clear all
load('Data_Pollen.mat')
eigen_gap_part

subplot(3,2,1)  
plot(1:15, evs(1:15), 'k-o')
xlabel('Index','FontSize',14)
ylabel('Eigenvalue','FontSize',14)
htext=text(0.01,1.05,'A','Units','normalized')
htext.FontSize=18;
xlim([1 15]); ylim([0 1.2])
vtt=vline(11, 'k--', 'C=11'); vtt.MarkerSize=15;

%% Deng data   7  not bad  goodt
load('Data_Deng.mat')
eigen_gap_part
subplot(3,2,2)  
plot(1:15, evs(1:15), 'k-o')
xlabel('Index','FontSize',14)
ylabel('Eigenvalue','FontSize',14)
htext=text(0.01,1.05,'B','Units','normalized')
htext.FontSize=18;
xlim([1 15]); ylim([0 1.2])
vtt=vline(7, 'k--', 'C=7'); vtt.MarkerSize=15;


%% Ginhoux data  3   goodt
load('Data_Ginhoux.mat')
eigen_gap_part
subplot(3,2,3)  
plot(1:15, evs(1:15), 'k-o')
xlabel('Index','FontSize',14)
ylabel('Eigenvalue','FontSize',14)
htext=text(0.01,1.05,'C','Units','normalized')
htext.FontSize=18;
xlim([1 15]); ylim([0 1.2])
vtt=vline(3, 'k--', 'C=3'); vtt.MarkerSize=15;


%% Ting data  5  okay 15   goodt
load('Data_Ting.mat')
eigen_gap_part
subplot(3,2,4)  
plot(1:15, evs(1:15), 'k-o')
xlabel('Index','FontSize',14)
ylabel('Eigenvalue','FontSize',14)
htext=text(0.01,1.05,'D','Units','normalized')
htext.FontSize=18;
xlim([1 15]); ylim([0 1.2])
vtt=vline(5, 'k--', 'C=5'); vtt.MarkerSize=15;


%% Treutlin data 5  okay 15   goodt
load('Data_Treutlin.mat')
eigen_gap_part
subplot(3,2,5)  
plot(1:15, evs(1:15), 'k-o')
xlabel('Index','FontSize',14)
ylabel('Eigenvalue','FontSize',14)
htext=text(0.01,1.05,'E','Units','normalized')
htext.FontSize=18;
xlim([1 15]); ylim([0 1.2])
vtt=vline(5, 'k--', 'C=5'); vtt.MarkerSize=15;


%% Buettner data 3    goodt
load('Data_Buettner.mat') 
eigen_gap_part
subplot(3,2,6)  
plot(1:15, evs(1:15), 'k-o')
xlabel('Index','FontSize',14)
ylabel('Eigenvalue','FontSize',14)
htext=text(0.01,1.05,'F','Units','normalized')
htext.FontSize=18;
xlim([1 15]); ylim([0 1.2])
vtt=vline(3, 'k--', 'C=3'); vtt.MarkerSize=15;

print -depsc est_clus_number








