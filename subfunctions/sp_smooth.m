function spikes = sp_smooth(spikes)
mode = 5;

if ~iscell(spikes)

    spikes = low_pass_f(spikes,mode);
    
elseif iscell(spikes)
    
    for i = 1:length(spikes)
        
        spikes{1,i} = low_pass_f(spikes{1,i},mode);
        
    end
    
end
        
