function circular_graph = circ_graph(network)

if ~iscell(network)
    figure;
    myColorMap = lines(length(network));
    circular_graph = circularGraph(network,'Colormap',myColorMap);
    
elseif iscell(network)
    
    for i = 1:length(network)
        figure;
        myColorMap = lines(length(network{1,i}));
        circular_graph = circularGraph(network{1,i},'Colormap',myColorMap);
        title(['Circular Graph (Session ' num2str(i) ')']);
    end
end