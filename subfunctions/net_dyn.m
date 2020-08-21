function net_dyn(all_spikes,pc)
disp('Would you like to visualize the network dynamics?');
in = input('(Press 1 for YES, 0 otherwise): ');

if in == 1 && ~iscell(all_spikes)
alpha = 2;
lambda = 20; % sample size = lambda * neurons

[neurons,frames] = size(all_spikes);

N = floor(frames/neurons/lambda);
window = floor(frames/N);
all_networks = zeros(N,neurons*(neurons-1)/2);
for n = 1:N
    f = (n-1)*window+1:n*window;
    spikes = all_spikes(:,f);
    
    spikes = low_pass_f(spikes,5);
    
    p = zeros(neurons);

    sigma = cov(spikes');
    phi = inv(sigma);

    for i = 1:neurons
        for j = 1:neurons
            p(i,j) = -phi(i,j)/sqrt(phi(i,i)*phi(j,j));   
        end
    end
    
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
    all_networks(n,:) = x';
end

% Overal Network

spikes = low_pass_f(all_spikes,5);
    
p = zeros(neurons);

sigma = cov(spikes');
phi = inv(sigma);

for i = 1:neurons
    for j = 1:neurons
        p(i,j) = -phi(i,j)/sqrt(phi(i,i)*phi(j,j));   
    end
end

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
all_networks = [x'; all_networks];
    
%    

[~,score,~,~,~] = pca(all_networks);

x = score(:,1); y = score(:,2);

% Local and Global Network
k = 1;
figure; xlim([1.2*min(x) 1.2*max(x)]); ylim([1.2*min(y) 1.2*max(y)]);
xlabel('PC1'); ylabel('PC2');
title('Network Dynamics'); 
grid on;
color = parula(length(x)-k);
hold on;
plot(x(1:k),y(1:k),'rx','MarkerSize',20);
colorbar; caxis([1 length(x)-k]); 

hold on
for i = k+1:length(x)
    points = animatedline('Color','w','Marker','o','MarkerFaceColor',color(i-k,:),'MarkerEdgeColor',color(i-k,:));  
    addpoints(points,x(i),y(i));
    legend('Global Network');
    drawnow limitrate
    pause(0.1);
%     if i<length(x)-10 
%         clearpoints(points);
%     end
end

elseif in == 1 && iscell(all_spikes)
    
    net_dyn_multi(all_spikes,pc);

end
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% THE END %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
