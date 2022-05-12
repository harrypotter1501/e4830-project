function [label,st] = clean_labels(label,thresh)
    stats = regionprops3(label,'volume');
    cnt = 0;
    st = {};
    for i = 1:length(stats.Volume)
        v = stats(i,'Volume').Volume;
        if v<thresh || v>20*thresh
            label(label==i) = 0;
        else
            cnt = cnt+1;
            label(label==i) = cnt;
            st{cnt} = v;
        end
    end
end