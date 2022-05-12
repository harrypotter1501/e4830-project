function fig = show_figs(path)
    data = load(path).res;
    fig(1) = figure;
    labelvolshow(data.label,data.volume,'VolumeThreshold',0.02,'CameraPosition',[-4,-4,2.5],'ScaleFactor',[2,2,2]);
    fig(2) = figure;
    plot_curve(data.intensity_vessel,data.intensity_all);
    fig(3) = figure;
    plot_hist(data.radius);
end