function plot_curve(intv,into)
    subplot(1,2,1);
    plot(intv,'LineWidth',2);
    ylim([0.01,0.04]);
    xlabel('series');
    ylabel('intensity');
    title('vascular');
    axis('square');
    grid on;
    subplot(1,2,2);
    plot(into,'LineWidth',2);
    ylim([0.01,0.04]);
    xlabel('series');
    ylabel('intensity');
    title('all');
    axis('square');
    grid on;
end