function spikes = sp_deconv(ops,ca)
if ~iscell(ca)
    disp('Spike deconvolution algorithm is running...');
    [spikes, ~] = OASISpreprocess(ops,ca'); 
    spikes = spikes'; 
    delete(findall(0));
    
elseif iscell(ca)
    spikes = cell(1,length(ca));
    disp('Spike deconvolution algorithm is running...');
    for i = 1:length(ca)
        
        [sp, ~] = OASISpreprocess(ops,ca{i}'); 
        spikes{i} = sp'; 
    end
    
    delete(findall(0));
    
end