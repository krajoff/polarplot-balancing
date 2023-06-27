function data = imdata(csvfile)
    % Setup the Import Options and import the data
    opts = delimitedTextImportOptions("NumVariables", 5);

    % Specify range and delimiter
    opts.DataLines = [2, Inf];
    opts.Delimiter = ";";

    % Specify column names and types
    opts.VariableNames = ["mode", ...
        "mP2P", "tP2P", ...
        "mWeight", "tWeight", ...
        "ref", "use", "zWeightReal", ...
        "zP2P", ...
        "zWeight", ...
        "mSen", "tSen", ...
        "mWeightTarget", "tWeightTarget", "zWeightTarget", ...
        "by"];
    opts.VariableTypes = ["categorical", ...
        repelem("double", 5), ...
        repelem("int16", 2), ...
        repelem("double", 8)];
    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";
    
    % Specify variable properties
    opts = setvaropts(opts, "mode", "EmptyFieldRule", "auto");
    opts = setvaropts(opts, ["mP2P", "tP2P", ...
        "mWeight", "tWeight"], "DecimalSeparator", ",");
    
    % Import the data
    data = readtable(fullfile(csvfile), opts); 
    data = movevars(data, 'zWeightReal', 'After', 'tWeight');
    data = movevars(data, 'zP2P', 'After', 'tP2P');
    data = movevars(data, 'zWeight', 'After', 'tWeight');
    
    % Add complex values of vibration and weight
    data.zP2P = getcomplex(data.mP2P, data.tP2P);
    data.zWeight = getcomplex(data.mWeight, data.tWeight);
end