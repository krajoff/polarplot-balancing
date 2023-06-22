function T = pullcorrectweight(varargin)
% Calculate target weight by different algorithms
% T = polarvibration(T)
% T = polarvibration(T, type)
% 'cad'  � mathCAD code and it is bad choice; 
% 'ref'  � algorithm from Isakovich book. It is default algorithm;
% 'all'  � like previous but for all runs in an mode.
    switch length(varargin)
        case 1
            T = varargin{1};
            type = "ref";
        case 2
            T = varargin{1};
            type = varargin{2};
        otherwise
            error('Wrong number of input arguments')
    end
    
    if type == "all" || type == "ref"
        T = validreference(T);
        if type == "all"
            T = addreference(T);
            type = "ref";
        end
    end
    
    modes = unique(T.Mode);
    for i=1:length(modes)
        onemode = T(T.Mode == modes(i), :);
        for j = 1:height(T)
            if type == "cad" && T.Mode(j) == modes(i) && T.Weight(j) ~= 0 
                    [T.CorrectWeight(j), T.CorrectPhase(j)] = ...
                        w_t_mathcad(onemode.ComplexVibration(1), ...
                        T.ComplexVibration(j), ...
                        T.Weight(j));
                    T.ComplexCorrectWeight(j) = getcomplex(T.CorrectWeight(j), ...
                        T.CorrectPhase(j));
            elseif type == "ref" && T.Mode(j) == modes(i) && T.Reference(j) ~= -1
                    ref = T.Reference(j);
                    [T.CorrectWeight(j), ...
                        T.CorrectPhase(j), ...
                        T.ComplexCorrectWeight(j)] = ...
                        w_t_isakovich(onemode.ComplexVibration(ref), ...
                        T.ComplexVibration(j), ...
                        onemode.ComplexWeight(ref), ...
                        T.ComplexWeight(j));
            end
        end
    end
end