%%%% making plots for comparisions between doubly stochastic and regular affinity matrices (Fig 1)
%% Refer running_doubly_vs_regular (Fig1).m for generating loading files

addpath(genpath(pwd))


% load the saved file (See running_doubly_vs_regular (Fig1).m for generating this file)
load('doubly_vs_reg_case1_1028.mat')


mean_val=[mean(nnnmi_r)',mean(nnnmi_d)']; std_val=[std(nnnmi_r)',std(nnnmi_d)'];

%% k=14
mean_val1=mean_val(3:11:55,:); std_val1=std_val(3:11:55,:);

clf
ax=axes;
h = bar(mean_val1,'BarWidth',1);
% Properties of the bar graph as required
ax.YGrid = 'on';
ax.GridLineStyle = '-';
xticklabels({'1', '1.25','1.5','1.75','2'});

% X and Y labels
xlabel ('\sigma');
ylabel ('NMI');
title('k=14');

% Creating a legend and placing it outside the bar plot
lg = legend('Regular','Doubly stochastic','AutoUpdate','off');
lg.Location = 'BestOutside';
lg.Orientation = 'Horizontal';
hold on;

% Finding the number of groups and the number of bars in each group
ngroups = size(mean_val1, 1);
nbars = size(mean_val1, 2);

% Calculating the width for each bar group
groupwidth = min(0.8, nbars/(nbars + 1.5));
% Set the position of each error bar in the centre of the main bar
% Based on barweb.m by Bolu Ajiboye from MATLAB File Exchange
for iii=1:(nbars)
    errorbar([(1:ngroups)-groupwidth/2+(2*iii-1)*groupwidth/(2*nbars)], mean_val1(:,iii), std_val1(:,iii), 'k', 'linestyle', 'none', 'linewidth',2);
end
ylim([0.5 max(max(mean_val1))+0.1])
set(gca,'FontSize', 15)
print -depsc bargraph_case1_14


%% k=20
mean_val1=mean_val(6:11:55,:); std_val1=std_val(6:11:55,:);
clf
ax=axes;
h = bar(mean_val1,'BarWidth',1);
% Properties of the bar graph as required
ax.YGrid = 'on';
ax.GridLineStyle = '-';
%xticks(ax,15);
% Naming each of the bar groups
xticklabels({'1', '1.25','1.5','1.75','2'});

% X and Y labels
xlabel ('\sigma');
ylabel ('NMI');
title('k=20');
% Creating a legend and placing it outside the bar plot
lg = legend('Regular','Doubly stochastic','AutoUpdate','off');
lg.Location = 'BestOutside';
lg.Orientation = 'Horizontal';
hold on;
% Finding the number of groups and the number of bars in each group
ngroups = size(mean_val1, 1);
nbars = size(mean_val1, 2);
% Calculating the width for each bar group
groupwidth = min(0.8, nbars/(nbars + 1.5));
% Set the position of each error bar in the centre of the main bar
% Based on barweb.m by Bolu Ajiboye from MATLAB File Exchange
for iii=1:(nbars)
    errorbar([(1:ngroups)-groupwidth/2+(2*iii-1)*groupwidth/(2*nbars)], mean_val1(:,iii), std_val1(:,iii), 'k', 'linestyle', 'none', 'linewidth',2);
end
ylim([0.5 max(max(mean_val1))+0.1])
set(gca,'FontSize', 15)

print -depsc bargraph_case1_20



