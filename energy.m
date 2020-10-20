function [ s, m ] = energy( x, model )
    
    global EVALS;
    if (isempty(EVALS))
        EVALS = 0;
    end
    EVALS = EVALS + 1;
    
    l = model.l;
    m = zeros(2 * l - 1) + 8;
    move = [-1 0;1 0;0 -1;0 1];
    pos = [l l];
    m(pos(1), pos(2)) = model.y(1);
    for i = 1:l - 1
        pos = pos + move(x(i),:);        
        m(pos(1), pos(2)) = model.y(i + 1);
    end
      
    s = 0;
    pos = [l l];
    
    % Check first AA
    if (model.y(1) == 1)
        sides = move;
        sides(x(1),:) = [];
        for j = 1:3
            check = pos + sides(j,:);
            if (m(check(1), check(2)) == 1)
                s = s + 1;
            end
        end       
    end
    pos = pos + move(x(1),:);
    
    % Check middle AAs
    for i = 2:l - 1
        if (model.y(i) == 0)
            pos = pos + move(x(i),:);
            continue;
        end
                  
        sides = move;
        opDirs = [2 1 4 3];
        R = x(i);
        L = opDirs(x(i - 1));
        sides([R L],:) = [];
        for j = 1:2
            check = pos + sides(j,:);
            if (m(check(1), check(2)) == 1)
                s = s + 1;
            end
        end
       
        pos = pos + move(x(i),:);
    end
    
    % Check last AA
    if (model.y(l) == 1)
        sides = move;        
        switch x(l - 1)
            case 1
                sides(2,:) = [];
            case 2
                sides(1,:) = [];
            case 3
                sides(4,:) = [];
            case 4
                sides(3,:) = [];
        end
        for j = 1:3
            check = pos + sides(j,:);
            if (m(check(1), check(2)) == 1)
                s = s + 1;
            end
        end
    end
    
    s = -s / 2;
end

