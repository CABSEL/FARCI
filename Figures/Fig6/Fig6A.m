clear; clc; close all;

load('subsampling_results (normal1).mat');
%% Time
x = sub_size;
y1 = F_time;
figure;
xi = linspace(min(x), max(x), 150);                  
yi = interp1(x, y1, xi, 'spline', 'extrap');
p1 = semilogy(xi, yi, 'LineWidth',3);
hold on
xticks([200 400 600 800 1000]);

%

y2 = S_time;

xi = linspace(min(x), max(x), 150);                  
yi = interp1(x, y2, xi, 'spline', 'extrap');
p2 = semilogy(xi, yi,'--', 'LineWidth',3);


hold on
% errorbar(x,y1,F_AUROC_err,'.','Color','k');
% errorbar(x,y2,F_AUROC_err,'.','Color','k');
%

plot(x, y2, 'o','MarkerEdgeColor',p2.Color,'MarkerFaceColor',p2.Color,'MarkerSize',8);
plot(x, y1, 'o','MarkerEdgeColor',p1.Color,'MarkerFaceColor',p1.Color,'MarkerSize',8);

title('Runtime','FontSize',16);
xlabel('Number of subsampled neurons','FontSize',14); 
ylabel('Time (sec)','FontSize',14);
set(gca,'fontsize',14);
L = legend('FARCI','Sutera et al. (2015)','FontSize',14,'Location','northwest');
set(L,'Box','off');
ax = gca; ax.XAxis.FontSize = 12;
% xtickangle(30);