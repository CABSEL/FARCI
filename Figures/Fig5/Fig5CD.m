clear; clc; close all;
addpath('all_subsamplings');
%% AUROC
clc; close all; clear;
x = [50 200 400 600 800 1000];
y = [];
y1_all = [];
z = [];
for i = 1:10
    filename = strcat('Normal',num2str(i));
    load(filename);
    
    y1 = mean(total_AUROC,2);
    y1 = y1(end:-1:1);
    xi = linspace(min(x), max(x), 950);                  
%     yi = interp1(x, y1, xi, 'spline', 'extrap');
    yi = interp1(x, y1, xi,'pchip');
    y = [y, yi'];
    y1_all = [y1_all,y1];
    z = [z, total_AUROC];
end
y1_all = y1_all';
labels = {'50';'200';'400';'600';'800';'1000'};

figure(1);
ax = violinplot(y1_all,labels);
title('AUROC','FontSize',16);
xlabel('Number of subsampled neurons','FontSize',14);
ylabel('AUROC','FontSize',14);
set(gca,'fontsize',14);
box on
%% AUPR
clc; close all; clear;
x = [50 200 400 600 800 1000];
y = [];
y1_all = [];
for i = 1:10
    filename = strcat('Normal',num2str(i));
    load(filename);
    
    y1 = mean(total_AUPRC,2);
    y1 = y1(end:-1:1);
    xi = linspace(min(x), max(x), 950);                  
%     yi = interp1(x, y1, xi, 'spline', 'extrap');
    yi = interp1(x, y1, xi,'pchip');
    y = [y, yi'];
    y1_all = [y1_all,y1];

end
y1_all = y1_all';
labels = {'50';'200';'400';'600';'800';'1000'};

figure(2);
ax = violinplot(y1_all,labels);
title('AUPR','FontSize',16);
xlabel('Number of subsampled neurons','FontSize',14);
ylabel('AUPR','FontSize',14);
set(gca,'fontsize',14);
box on