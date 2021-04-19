clear; clc; close all;
addpath('all_subsamplings');

%% Time
clc; close all; clear;
x = [50 200 400 600 800 1000]; 
y = [];
y1_all = [];
for i = 1:10
    filename = strcat('Normal',num2str(i));
    load(filename);
    
    y1 = mean(comp_time,2);
    y1 = y1(end:-1:1);
    xi = linspace(min(x), max(x), 950);                  
%     yi = interp1(x, y1, xi, 'spline', 'extrap');
    yi = interp1(x, y1, xi,'pchip');
    y = [y, yi'];
    y1_all = [y1_all,y1];

end
y1_all = y1_all';
labels = {'50';'200';'400';'600';'800';'1000'};

figure(3);
ax = violinplot((y1_all),labels);
title('Runtime','FontSize',16);
xlabel('Number of subsampled neurons','FontSize',14);
ylabel('Time (sec)','FontSize',14);
set(gca,'fontsize',14);
box on
set(gca,'XScale','log','YScale','log');
% xtickangle(30);
ax = gca; ax.XAxis.FontSize = 12;
%% Line and slope

logx = log(x);

logy = log(mean(y1_all));

p = polyfit(logx,logy,1); 

slope = p(1);

hold on

x = 1:6;
p = polyfit(log(x),log(mean(y1_all)), 1);


ypol = x.^p(1).*exp(p(2));

loglog(1:6,ypol,'--','Color',[0.5 0.5 0.5])

text(1.5,7,['slope = ' num2str( sprintf('%.2f',slope))],'FontSize',12);