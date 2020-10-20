function [ r ] = checkCollision( x, model )
    
    l = model.l;
    
    for i = 1:l - 2
        switch x(i)
            case 1
                if (x(i + 1) == 2)
                    r = 1;
                    return;
                end
            case 2
                if (x(i + 1) == 1)
                    r = 1;
                    return;
                end
            case 3
                if (x(i + 1) == 4)
                    r = 1;
                    return;
                end
            case 4
                if (x(i + 1) == 3)
                    r = 1;
                    return;
                end
        end
    end    
    
    m = zeros(2 * l - 1) + 8;
    move = [-1 0;1 0;0 -1;0 1];
    pos = [l l];
    m(pos(1), pos(2)) = model.y(1);
    for i = 1:l - 1
        pos = pos + move(x(i),:); 
        if (m(pos(1), pos(2)) > 2)
            m(pos(1), pos(2)) = model.y(i + 1);
        else
            r = 1;
            return;            
        end
    end

    r = 0;
    return;
end

