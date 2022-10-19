function plot_hist(rad)
    rad = rad(rad~=0&rad<Inf)*0.1^2;
    histogram(rad);
    xlabel('width (mm)');
    ylabel('volume (mm^3)');
    %title('Vessel Width Distibution');
end