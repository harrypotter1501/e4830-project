%% main

clear;

%% read
mats = dir('data/extracted/*.mat');

%% extract
for i = 1:length(mats)
    disp(i);
    ss = split(mats(i).name,'-');
    tic;
    [tub,lab,stats,intv,into,rad] = vascular(append('data/extracted/',mats(i).name),0.1,0.9,5,10,20);
    toc;
    save_data(append(ss{5},'-',ss{6}),tub,lab,stats,intv,into,rad);
end

%% save
figs = dir('figs/*.mat');

%% draw figs
for i = 1:length(figs)
    f = show_figs(append('figs/',figs(i).name));
    ss = split(figs(i).name,'.');
    saveas(f(1),append('res/eval/',ss{1},'-vol.png'));
    saveas(f(2),append('res/eval/',ss{1},'-int.png'));
    saveas(f(3),append('res/eval/',ss{1},'-rad.png'));
    close all;
end

%% stats
stats = [];
for i = 1:length(figs)
    stats = [stats,get_stats(append('figs/',figs(i).name))];
end
stats = struct2table(stats);
writetable(stats,'res/stats.csv');




