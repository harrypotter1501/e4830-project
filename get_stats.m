function res = get_stats(path)
    data = load(path).res;
    res = struct();
    ss = split(path,'.');
    res.name = ss{1};
    stats = cell2mat(data.stats);
    res.ves_mean = mean(stats);
    res.ves_std = std(stats);
    res.ves_vol = sum(data.volume>0.1,'all');
    dintv = max(data.intensity_vessel) - min(data.intensity_vessel);
    dinto = max(data.intensity_all) - min(data.intensity_all);
    res.dint = dintv/dinto;
    rad = data.radius;
    rad = rad(rad~=0&rad<Inf)*0.1^2;
    res.rad_mean = mean(rad,'all');
    res.rad_std = std(rad);
end