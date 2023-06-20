function T = pullcorrectweight(T, type)
    PullMode = unique(T.Mode);
    for i=1:length(PullMode)
        OneMode = T(T.Mode == PullMode(i), :);
        for j = 1:height(T)
            if type == "auto" && T.Mode(j) == PullMode(i) && T.Weight(j) ~= 0 
                    [T.CorrectWeight(j), T.CorrectPhase(j)] = ...
                        w_t_matcad(OneMode.ComplexVibration(1), ...
                        T.ComplexVibration(j), ...
                        T.Weight(j));
            elseif type == "ref" && T.Mode(j) == PullMode(i) && T.Reference(j) ~= -1
                    ref = T.Reference(j);
                    [T.CorrectWeight(j), T.CorrectPhase(j)] = ...
                        m_a_isakovich(OneMode.ComplexVibration(ref), ...
                        T.ComplexVibration(j), ...
                        OneMode.ComplexWeight(ref), ...
                        T.ComplexWeight(j));
            end
        end
    end
end