function label = label_cc(CC,thresh)
    %stats_tr = regionprops3(CC,'Volume');
    label = zeros(CC.ImageSize);
    for i = 1:CC.NumObjects
        pix_id = CC.PixelIdxList{i};
        if length(pix_id)>=thresh
            label(pix_id) = i;
        end
    end
    %label = uint8(label);
end