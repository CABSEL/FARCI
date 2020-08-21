function [net,edges] = connectome_inf(p)

disp(['To set a threshold, please enter a value for '  (char(945)) ': '])
alpha = input([ '(Note that, the threshold is defined as: Threshold = ' (char(956)) ' + ' (char(945)) ' * ' (char(963)) '): ' ]);

if ~iscell(p)
    net = p;
    net = triu(net,1);
    idx = net ~= 0;
    th = mean(net(idx)) + alpha*std(net(idx));
    net(net<th) = 0;
    [row,col,weights] = find(net);
    edges = [row,col,weights];
    net = net+net';

    figure;
    imagesc(net); colormap('hot'); colorbar; xlabel('Neurons'); ylabel('Neurons'); title('Heatmap of Neuronal Connectome');
    
elseif iscell(p)
    
    for i = 1:length(p)
        x = p{1,i};
        x = triu(x,1);
        idx = x ~= 0;
        th = mean(x(idx)) + alpha*std(x(idx));
        x(x<th) = 0;
        [row,col,weights] = find(x);
        edges = [row,col,weights];
        net{1,i} = x+x';

        figure;
        imagesc(net{1,i}); colormap('hot'); colorbar; xlabel('Neurons'); ylabel('Neurons'); title(['Heatmap of Neuronal Connectome (Session ' num2str(i) ')']);
    end
end