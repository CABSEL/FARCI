clc; clear; close all; load('all_threshold_perf.mat');
%% small
warning('off');
clc; close all; clearvars -except total_AUPRC total_AUROC
n = 6;

x = linspace(0,5,100);
figure(1); subplot(121);
h = stdshade(total_AUROC(:,1:n)',0.15,'b',x);
xlim([0 5]);
h.LineWidth = 3;
title('AUROC','FontSize',16);
xlabel('\alpha','FontSize',14);
ylabel('AUROC','FontSize',14);
set(gca,'fontsize',14);


figure(1);subplot(122);
h = stdshade(total_AUPRC(:,1:n)',0.15,'r',x);
h.LineWidth = 3;
xlim([0 5]);
title('AUPR','FontSize',16);
xlabel('\alpha','FontSize',14);
ylabel('AUPR','FontSize',14);
set(gca,'fontsize',14);
sgt = sgtitle('100 Neurons');
sgt.FontSize = 20;
sgt.FontWeight = 'bold';
%% normal
x = linspace(0,5,100);
figure(2); subplot(121);
h = stdshade(total_AUROC(:,n+1:end)',0.15,'b',x);
xlim([0 5]);
h.LineWidth = 3;
title('AUROC','FontSize',16);
xlabel('\alpha','FontSize',14);
ylabel('AUROC','FontSize',14);
set(gca,'fontsize',14);


figure(2);subplot(122);
h = stdshade(total_AUPRC(:,n+1:end)',0.15,'r',x);
h.LineWidth = 3;
xlim([0 5]);
title('AUPR','FontSize',16);
xlabel('\alpha','FontSize',14);
ylabel('AUPR','FontSize',14);
set(gca,'fontsize',14);
sgt = sgtitle('1000 Neurons');
sgt.FontSize = 20;
sgt.FontWeight = 'bold';
