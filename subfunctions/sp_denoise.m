function spikes = sp_denoise(spikes)

if ~iscell(spikes)

    [~,frames] = size(spikes);

    th = mean(spikes,2) + 2 * std(spikes,[],2); %threshold
    th = repmat(th,1,frames);
    spikes(spikes<th) = 0;
    
elseif  iscell(spikes)
    
    for i = 1:length(spikes)
        
        [~,frames] = size(spikes{1,i});

        th = mean(spikes{1,i},2) + 2 * std(spikes{1,i},[],2); %threshold
        th = repmat(th,1,frames);
        spikes{1,i}(spikes{1,i}<th) = 0;
        
    end
end