function [ s2 ] = monteCarlo( s1, model )
        
    e1 = energy(s1, model);
    l = model.l;
    
    while 1
        while 1
            s2 = s1;

            % Choose a random amino-acid
            raa = randi([2 l-1]);

            % Choose a random direction (90d, -90d or forward)
            dirs   = [1 2 3 4];
            opDirs = [2 1 4 3];
            dirs(opDirs(s1(raa - 1))) = [];
            rdir = randi([1 3]);

            % Mute the conformation    
            s2(raa) = dirs(rdir);

            % Check for self-avoidance
            if (checkCollision(s2, model) == 0)
                break;
            end                
        end

        e2 = energy(s2, model);

        % Check for energy change
        if (e2 <= e1)
            return;
        end

        % Check for cooling coeff
        if (rand() < exp((e1 - e2) / model.c_kmc))
            return;
        end
    end
end

