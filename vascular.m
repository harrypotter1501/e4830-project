function [img_tu_re,img_tu_cl,stats_cl,intv,into,rad] = vascular(data_path,fiber,log,branch,connect,volume)
    % fiber=0.1,log=0.9,branch=5,connect=10,volume=20
    % load data
    data = load(data_path).da;
    imgs = data.data;
    % mip
    img_mip = mip(imgs,4);
    % tubular
    img_ce = mat2gray(img_mip-imgs(:,:,:,1));
    img_tu = fibermetric(img_ce,1:5,'StructureSensitivity',fiber);
    img_tu = imadjustn(img_tu,[],[],log);
    % binarize
    img_tu_bw = imbinarize(img_tu,graythresh(img_tu));
    img_tu_sk = bwskel(img_tu_bw,'MinBranchLength',branch);
    img_tu_sk = bwmorph3(img_tu_sk,'fill');
    % tree
    cc_tr = bwconncomp(close_sk(img_tu_sk));
    img_tu_la = label_cc(cc_tr,branch);
    cc_tr_re = bwconncomp(imreconstruct(imdilate(img_tu,strel('sphere',branch)),img_tu_la));
    img_tu_con = label_cc(cc_tr_re,branch);
    img_tu_con = connect_cc(img_tu_con,connect);
    % reconstruct
    [img_tu_cl,stats_cl] = clean_labels(img_tu_con,volume);
    img_tu_re = imreconstruct(img_tu_cl,img_tu,6);
    % evaluate
    [intv,into] = curve(imgs,img_tu_re);
    dist = bwdist(img_tu_re>=0.1);
    rad = double(dist).*double(img_tu_cl);
end