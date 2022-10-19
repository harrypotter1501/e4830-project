function [intv,into] = curve(imgs,mask)
    t = size(imgs,4);
    intv = zeros(1,t);
    into = zeros(1,t);
    for i = 1:t
        intv(i) = mean(mask.*imgs(:,:,:,i),'all');
        into(i) = mean((1-mask).*imgs(:,:,:,i),'all');
    end
    intv = intv/sum(intv);
    into = into/sum(into);
end