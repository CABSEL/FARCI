function f = low_pass_f(x,mode)

neurons = size(x,1);
frames = size(x,2);

f = zeros(neurons,frames);

if mode ==1 
    for i = 1:neurons
        for j = 2:frames-1
            f(i,j) = x(i,j-1)+x(i,j)+x(i,j+1);
        end
    end
    f = f(:,2:end-1);
    
elseif mode == 2
    for i = 1:neurons
        for j = 4:frames
            f(i,j) = 0.4*x(i,j-3)+0.6*x(i,j-2)+0.8*x(i,j-1)+x(i,j);
        end
    end
    f = f(:,4:end);
    
elseif mode == 3
    for i = 1:neurons
        for j = 2:frames-2
            f(i,j) = x(i,j-1)+x(i,j)+x(i,j+1)+x(i,j+2);
        end
    end
    f = f(:,2:end-2);
    
elseif mode == 4
    for i = 1:neurons
        for j = 1:frames-3
            f(i,j) =x(i,j)+x(i,j+1)+x(i,j+2)+x(i,j+3);
        end
    end
    f = f(:,1:end-3);
    
elseif mode == 5
    for i = 1:neurons
        for j = 3:frames-2
            f(i,j) = 0.33*x(i,j-2)+0.67*x(i,j-1)+x(i,j)+0.67*x(i,j+1)+0.33*x(i,j+2);
        end
    end
    f = f(:,3:end-2);
    
elseif mode == 6
    for i = 1:neurons
        for j = 4:frames-3
            f(i,j) = 0.3*x(i,j-3)+0.6*x(i,j-2)+0.9*x(i,j-1)+x(i,j)+0.9*x(i,j+1)+0.6*x(i,j+2)+0.3*x(i,j+3);
        end
    end
    f = f(:,3:end-2);      
end

