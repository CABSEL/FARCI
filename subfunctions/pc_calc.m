function p = pc_calc(spikes)

spikes(isnan(spikes)) = 0;

idx = find(all(spikes == 0,2));
spikes(idx,:) = [];

spikes = low_pass_f(spikes,5);

sigma = cov(spikes');
phi = inv(sigma);
neurons = size(spikes,1);
p = zeros(neurons);
for i = 1:neurons
    for j = 1:neurons
        p(i,j) = -phi(i,j)/sqrt(phi(i,i)*phi(j,j));
    end
end

for i = 1:length(idx)
    p1 = p(1:idx(i)-1,:);
    p2 = zeros(1,size(p,2));
    p = [p1;p2;p(idx(i):end,:)];

    p3 = p(:,1:idx(i)-1);
    p4 = zeros(size(p,1),1);
    p = [p3,p4,p(:,idx(i):end)];
end

