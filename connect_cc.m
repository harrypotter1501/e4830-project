function label = connect_cc(label,thresh)
    endpts = find(bwmorph3(logical(label),'endpoints'));
    branchpts = find(bwmorph3(logical(label),'branchpoints'));
    epix = {};
    [epix{1},epix{2},epix{3}] = ind2sub(size(label),[endpts;branchpts]);
    epix = cell2mat(epix);
    dist = tril(pdist2(epix,epix));
    pts = {};
    [pts{1},pts{2}] = find(dist<=thresh&dist~=0);
    pts = cell2mat(pts);
    for i = 1:size(pts,1)
        pix = epix(pts(i,:),:);
        label(label==label(pix(1,1),pix(1,2),pix(1,3))) = label(pix(2,1),pix(2,2),pix(2,3));
    end
end