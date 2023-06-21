function D = addreference(T)
    modes = unique(T.Mode);
    D = T(T.Mode == modes(1), :);
    D = D(1, :);
    for i=1:length(modes)
        mode = T(T.Mode == modes(i), :);
        D = [D; mode(1:2, :)];
        if height(mode) > 2
            for j = 3:height(mode) 
                D = [D; repelem(mode(j,:), j-1, 1)];                
            end
        end
    end
    D(1, :) = [];
end