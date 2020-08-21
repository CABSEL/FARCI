function p = partial_corr(spikes)

if ~iscell(spikes)
    

    [neurons,~] = size(spikes);

    p = zeros(neurons);

    sigma = cov(spikes');
    phi = inv(sigma);

    for i = 1:neurons
        for j = 1:neurons
            p(i,j) = -phi(i,j)/sqrt(phi(i,i)*phi(j,j));   
        end
    end
    histogram(p - diag(diag(p)));
    
elseif iscell(spikes)
    pp = [];
    for k = 1:length(spikes)
        
        [neurons,~] = size(spikes{1,k});

        p{1,k} = zeros(neurons);

        sigma = cov(spikes{1,k}');
        phi = inv(sigma);

        for i = 1:neurons
            for j = 1:neurons
                p{1,k}(i,j) = -phi(i,j)/sqrt(phi(i,i)*phi(j,j));   
            end
        end
        
        pp = [pp; p{1,k}-diag(diag(p{1,k}))];
    
    end
    
    histogram(pp);
    
end


title('Distribution of Partial Correlation Coefficients');
xlabel('Partial Correlation');
ylabel('Counts');