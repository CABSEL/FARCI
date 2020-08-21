function graph = graph_w_positions(network)

disp('Would you like to visualize the connectome with actual positions?');
dis = input('(Press 1 for YES and upload the distance/positions matrix, 0 otherwise): ');
if dis == 1
    
    [FileName,PathName] = uigetfile('*.*');
    filename = strcat(PathName, FileName);
    D = importdata(filename); 
    
    if ~diff(size(D)) % true if D is a squre matrix (distance matrix)
        positions = cmdscale(D);
    else
        positions = D;
    end
    
    
    if ~iscell(network)
        neurons = length(network);
        myColorMap = lines(neurons);

        network = triu(network,1);
        [row,col,weights] = find(network);


        figure;
        graph = scatter(positions(:,1),positions(:,2),[],myColorMap,'filled');

        hold on
        for i = 1:length(row)
            p1 = positions(row(i),:);
            p2 = positions(col(i),:);
            plot([ p1(1) p2(1)], [p1(2) p2(2)],'Color',myColorMap(row(i),:),'LineWidth',50*weights(i)); 
        end
        for i = 1:neurons
            text(positions(i,1),positions(i,2)+0.01,num2str(i));
        end
        title('Neuronal Connectome'); xlabel('X'); ylabel('Y');
        
    elseif iscell(network)
        
        for k = 1:length(network)
            
            neurons = length(network{1,k});
            myColorMap = lines(neurons);

            network{1,k} = triu(network{1,k},1);
            [row,col,weights] = find(network{1,k});


            figure;
            graph = scatter(positions(:,1),positions(:,2),[],myColorMap,'filled');

            hold on
            for i = 1:length(row)
                p1 = positions(row(i),:);
                p2 = positions(col(i),:);
                plot([ p1(1) p2(1)], [p1(2) p2(2)],'Color',myColorMap(row(i),:),'LineWidth',50*weights(i)); 
            end
            for i = 1:neurons
                text(positions(i,1),positions(i,2)+0.01,num2str(i));
            end
            title(['Neuronal Connectome (Session ' num2str(k) ')']); xlabel('X'); ylabel('Y');
            
        end
        
    end
    
    
else
    graph = [];
end
clear filename FileName PathName dis p1 p2 i 
