function [ m ] = paintProtein( x, model )
    l = model.l;

    %% Create a canvas
    m = repmat('  ', (4 * l - 1) + 8, (4 * l - 1) + 8);
    sym = ['O' 'X'];
    
    move = [-1 0;1 0;0 -2;0 2];
    pos = [floor(size(m, 1)/2) floor(size(m, 2)/2)];
    m(pos(1), pos(2)) = sym(model.y(1) + 1);
    m(pos(1), pos(2) + 1) = ' ';

    % Paint the canvas
    for i = 1:l - 1
        pos = pos + move(x(i),:); 
        if (x(i) == 3 || x(i) == 4)
            m(pos(1), pos(2)) = '-';
        else
            m(pos(1), pos(2)) = '|';
        end

        pos = pos + move(x(i),:); 
        m(pos(1), pos(2)) = sym(model.y(i+1) + 1);
        m(pos(1), pos(2) + 1) = ' ';
    end

    %% Crop extra space from the canvas
    up = 1;
    down = size(m, 1);

    left = 1;
    right = size(m, 2);

    while isempty(find(m(up,:) > 32, 1))
       up = up + 1;
    end

    while isempty(find(m(down,:) > 32, 1))
       down = down - 1;
    end

    while isempty(find(m(:,left) > 32, 1))
       left = left + 1;
    end

    while isempty(find(m(:,right) > 32, 1))
       right = right - 1;
    end

    m = m(up:down, left-4:right);
end