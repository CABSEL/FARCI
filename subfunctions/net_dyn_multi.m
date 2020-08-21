function net_dyn_multi(all_spikes,pc)

%% Sub-networks
alpha = 2;
lambda = 20; % sample size = lambda * neurons
local_networks = [];
color_label = [];
k = 0;
for session = 1:length(all_spikes)
   
    k = k+1;
    all_spikes{1,session}(isnan(all_spikes{1,session})) = 0;

    [neurons,frames] = size(all_spikes{1,session});

    N = floor(frames/neurons/lambda);
    window = floor(frames/N);
    for n = 1:N
        f = (n-1)*window+1:n*window;
        spikes = all_spikes{1,session}(:,f);
        p = pc_calc(spikes);
        x = p;
        x(isnan(x)) = 0;
        x(x==0) = eps;
        x = triu(x,1);  
        idx = x ~= 0;
        x = x(idx);
        mu = mean(x);
        sigma = std(x);
        th = mu + alpha*sigma; % threshold
        x(x<th) = 0;
        local_networks = [local_networks;x'];
        color_label = [color_label k];
    end

end

%% Global Network
clear p;
global_networks = [];
k = 0;
for session = 1:length(all_spikes)

        k = k+1;
        x = pc{1,session};
        x(isnan(x)) = 0;
        x(x==0) = eps;
        x = triu(x,1);  
        idx = x ~= 0;
        x = x(idx);
        mu = mean(x);
        sigma = std(x);
        th = mu + alpha*sigma; % threshold
        x(x<th) = 0;
        global_networks(k,:) = x';

end

%% PCA
networks = [global_networks; local_networks];
networks = networks(:,any(networks)); % removing all the inactive edges (columns)
networks = networks(any(networks,2),:); % removing missing session (rows)

[~,score,~,~,~] = pca(networks);

x = score(:,1); y = score(:,2);

%% Plot
figure;
set(0,'DefaultLegendAutoUpdate','off');

session_color = distinguishable_colors(k);
color = [];
for i = 1:length(color_label)
    
    color(i,:) = session_color(color_label(i),:);
end
plot(x(1:k),y(1:k),'k--'); 
legend('Global Network Dynamics','Location','northwest');
xlabel('PC1'); ylabel('PC2');

title('Network Dynamics'); 

xlim([min(x(:))*1.2 max(x(:))*1.2]); ylim([min(y(:))*1.2 max(y(:))*1.2]);

hold on;
scatter(x(1:k),y(1:k),80,session_color,'filled');
% colorbar; 
caxis([1 k]); grid on;
a = (1:k)'; b = num2str(a); c = cellstr(b);
dx = 0.025; dy = 0.01; dz = 0.01;
text(x(1:k)+dx, y(1:k)+dy, c,'FontSize',12);

for i = 1+k:length(x)
    h2 = plot(x(i),y(i), 'Marker','o','MarkerFaceColor',color(i-k,:),'MarkerEdgeColor',color(i-k,:));
    pause(0.25);
end