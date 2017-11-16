%% generating Figure 2

addpath(genpath(pwd))

clear all

%% obtain the target matrices
pn_structure_place
%% save('pn_structure.mat', 'Vi1','Vi2','Vn','V2n')
load('pn_structure.mat')

%% Figure 2
clf;
subplot(2,2,1); colormap((hot)); imagesc(abs(Vi1)); colorbar;
htext=text(-0.2,0.96,'A','Units','normalized')
htext.FontSize=20;  caxis([0 0.08]);
subplot(2,2,2); colormap((hot)); imagesc(abs(Vi2)); colorbar;
htext=text(-0.2,0.96,'B','Units','normalized')
htext.FontSize=20; caxis([0 0.08]);
subplot(2,2,3); colormap((hot)); imagesc(abs(Vn)); colorbar;
htext=text(-0.2,0.96,'C','Units','normalized')
htext.FontSize=20; caxis([0 0.08]);
subplot(2,2,4); colormap((hot)); imagesc(abs(V2n)); colorbar;
htext=text(-0.2,0.96,'D','Units','normalized')
htext.FontSize=20; caxis([0 0.08]);

print -depsc pn_structure0_recent





    
