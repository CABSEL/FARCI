clear; clc; close all;

load('subsampling_results (normal1).mat');
%% AUROC
x = sub_size;
y1 = F_AUROC;
figure;
xi = linspace(min(x), max(x), 150);                  
yi = interp1(x, y1, xi, 'spline', 'extrap');
p1 = plot(xi, yi, 'LineWidth',3);
hold on
xticks([200 400 600 800 1000]);

%

y2 = S_AUROC;

xi = linspace(min(x), max(x), 150);                  
yi = interp1(x, y2, xi, 'spline', 'extrap');
p2 = plot(xi, yi,'--', 'LineWidth',3);


hold on
% errorbar(x,y1,F_AUROC_err,'.','Color','k');
% errorbar(x,y2,F_AUROC_err,'.','Color','k');
%

plot(x, y2, 'o','MarkerEdgeColor',p2.Color,'MarkerFaceColor',p2.Color,'MarkerSize',8);
plot(x, y1, 'o','MarkerEdgeColor',p1.Color,'MarkerFaceColor',p1.Color,'MarkerSize',8);

title('AUROC','FontSize',16);
xlabel('Number of subsampled neurons','FontSize',14); 
ylabel('AUROC','FontSize',14);
set(gca,'fontsize',14);
L = legend('FARCI','Sutera et al. (2015)','FontSize',14,'Location','southeast');
set(L,'Box','off');

%% AUPRC
x = sub_size;
y1 = F_AUPRC;
figure;
xi = linspace(min(x), max(x), 150);                  
yi = interp1(x, y1, xi, 'spline', 'extrap');
p1 = plot(xi, yi, 'LineWidth',3);
hold on
xticks([200 400 600 800 1000]);
yticks([0.2 0.3 0.4 0.5]);

%

y2 = S_AUPRC;

xi = linspace(min(x), max(x), 150);                  
yi = interp1(x, y2, xi, 'spline', 'extrap');
p2 = plot(xi, yi,'--', 'LineWidth',3);


hold on
% errorbar(x,y1,F_AUPRC_err,'.','Color','k');
% errorbar(x,y2,F_AUPRC_err,'.','Color','k');
%

plot(x, y2, 'o','MarkerEdgeColor',p2.Color,'MarkerFaceColor',p2.Color,'MarkerSize',8);
plot(x, y1, 'o','MarkerEdgeColor',p1.Color,'MarkerFaceColor',p1.Color,'MarkerSize',8);

title('AUPR','FontSize',16);
xlabel('Number of subsampled neurons','FontSize',14); 
ylabel('AUPR','FontSize',14);
set(gca,'fontsize',14);
L = legend('FARCI','Sutera et al. (2015)','FontSize',14,'Location','southeast');
set(L,'Box','off');

