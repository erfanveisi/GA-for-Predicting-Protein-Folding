function [ s3, err ] = crossover( s1, s2, model )
    
    l = model.l;
    s3 = zeros(1, l - 1);
    allCollide = 1;
    
    % Choose a random amino-acid
    raa = randi([2 l-1]);
    
    % Choose a random direction (90d, -90d or forward)
    dirs   = [1 2 3 4];
    opDirs = [2 1 4 3];
    dirs(opDirs(s1(raa - 1))) = [];
    rdir = randperm(3);
    dirs = dirs(rdir);
    
    % Apply crossover
    for i = 1:3
        s3(1:raa - 1)   = s1(1:raa - 1);
        s3(raa)         = dirs(i);
        if (raa < l-1)
           s3(raa + 1:end) = s2(raa + 1:end);
        end
    
        if (checkCollision(s3, model) == 0)
            allCollide = 0;
            break;
        end        
    end
    
    if (allCollide == 1)
        err = 1;
    else
        err = 0;
    end
        
end

