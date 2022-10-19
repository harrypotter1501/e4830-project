function save_data(name,tub,lab,stats,intv,into,rad)
    res = struct();
    res.label = lab;
    res.volume = tub;
    res.stats = stats;
    res.intensity_vessel = intv;
    res.intensity_all = into;
    res.radius = rad;
    save(sprintf('figs/%s',name),'res');
end