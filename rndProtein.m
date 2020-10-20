function [ s ] = rndProtein( model )
    l = model.l;
    
    while 1
        s = zeros(1, l - 1);   
        s(1) = randi([1 4]);
        for i = 2:l - 1       
            dirs   = [1 2 3 4];
            opDirs = [2 1 4 3];
            dirs(opDirs(s(i - 1))) = [];
            rdir = randi([1 3]);
            s(i) =  dirs(rdir);
        end

        if (checkCollision(s, model) == 0)
            break;
        end
    end
end

