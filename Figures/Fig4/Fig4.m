clear; clc; close all;

load('all_perf_eval.mat');
%%
AUROC_100 = [F_AUROC(1:6,:),S_AUROC(1:6,:)];
AUROC_1000 = [F_AUROC(7:end,:),S_AUROC(7:end,:)];

AUPRC_100 = [F_AUPRC(1:6,:),S_AUPRC(1:6,:)];
AUPRC_1000 = [F_AUPRC(7:end,:),S_AUPRC(7:end,:)];
%%
close all;
color = ['b' 'r'];
figure(1);
subplot(1,2,1);
b = boxplot(AUROC_100,'whisker',1000,'Symbol','','Labels',{'FARCI','Sutera et al.'}); ylim([0.7 1]); yticks([0.7 0.8 0.9 1]); box off; 
title('100 Neurons','FontSize',14);
uistack(b,'top');
set(gca,'fontsize',14);

h = findobj(gca,'Tag','Box'); 
for j=1:size(h,1) 
patch(get(h(j),'XData'),get(h(j),'YData'),color(j),'FaceAlpha',.5);
uistack(h(j),'top');
end 


hAx=gca;                                   % retrieve the axes handle
xtk=hAx.XTick; 
hold on
for i = 1:6
    
    a = plot(xtk,AUROC_100(i,:),'--','Color',[0.75 0.75 0.75]);
    
end

uistack(b,'top');
subplot(1,2,2);
b = boxplot(AUROC_1000,'whisker',1000,'Symbol','','Labels',{'FARCI','Sutera et al.'}); ylim([0.7 1]); box off; set(gca,'ytick',[]); 
title('1000 Neurons','FontSize',14);
set(gca,'fontsize',14);

h = findobj(gca,'Tag','Box'); 
for j=1:size(h,1) 
patch(get(h(j),'XData'),get(h(j),'YData'),color(j),'FaceAlpha',.5);
end 

hAx=gca;                                   % retrieve the axes handle
xtk=hAx.XTick; 
hold on
for i = 1:10
    
    a = plot(xtk,AUROC_1000(i,:),'--','Color',[0.75 0.75 0.75]);
%     uistack(a,'bottom');
end

ha=get(gcf,'Children');

set(ha(1),'position',[0.5 0.1 0.4 0.8]);
set(ha(2),'position',[0.1 0.1 0.4 0.8]);
uistack(ha(1),'top');
sgtitle('AUROC');
%%

figure(2);
subplot(1,2,1);
boxplot(AUPRC_100,'whisker',1000,'Symbol','','Labels',{'FARCI','Sutera et al.'}); ylim([0.2 1]); box off; 
title('100 Neurons','FontSize',16);
set(gca,'fontsize',14);

h = findobj(gca,'Tag','Box'); 
for j=1:size(h,1) 
patch(get(h(j),'XData'),get(h(j),'YData'),color(j),'FaceAlpha',.5);
end 

hAx=gca;                                   % retrieve the axes handle
xtk=hAx.XTick; 
hold on
for i = 1:6
    
    plot(xtk,AUPRC_100(i,:),'--','Color',[0.75 0.75 0.75]);
    
end

subplot(1,2,2);
boxplot(AUPRC_1000,'whisker',1000,'Symbol','','Labels',{'FARCI','Sutera et al.'}); ylim([0.2 1]); box off; set(gca,'ytick',[]); 
title('1000 Neurons','FontSize',16);
set(gca,'fontsize',14);

h = findobj(gca,'Tag','Box'); 
for j=1:size(h,1) 
patch(get(h(j),'XData'),get(h(j),'YData'),color(j),'FaceAlpha',.5);
end 

hAx=gca;                                   % retrieve the axes handle
xtk=hAx.XTick; 
hold on
for i = 1:10
    
    plot(xtk,AUPRC_1000(i,:),'--','Color',[0.75 0.75 0.75]);
    
end

ha=get(gcf,'Children');
set(ha(1),'position',[0.5 0.1 0.4 0.8]);
set(ha(2),'position',[0.1 0.1 0.4 0.8]);

sgtitle('AUPR');