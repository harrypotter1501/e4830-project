%% dev.m
% Development interface
clear;

%% load data
data = load('data/extracted/171/QIN-Breast-DCE-MRI-BC06-V1.mat').da;
imgs = data.data;

%% MIP
% mip 
img_mip = mip(imgs,4);
img_dce = mip(imgs,3);

%%
%img_ce = mat2gray(img_mip-squeeze(mean(imgs,4)));
img_ce = mat2gray(img_mip-imgs(:,:,:,1));
sliceViewer(img_ce);

%% save gif
vol2gif(mat2gray(img_dce),size(img_dce,3),'res/dce.gif');

%% tubular (Frangi)
% %% hessian
% H = hesseig(hessian3d(img_ce,3));
% sliceViewer(H);
% vol2gif(H,size(H,3),'res/hessian.gif');
% 
% %% tubular
% img_tu = mat2gray(tubular(H,0.5,0.5,50));
% %sliceViewer(img_tu);
% volshow(img_tu);

img_tu = fibermetric(img_ce,1:5,'StructureSensitivity',0.1);
img_tu = imadjustn(img_tu,[],[],0.9);
volshow(img_tu);

%% tumor ROI
% nii = niftiread('data/extracted/170/QIN-Breast-DCE-MRI-BC06_V1_roi.nii');
% sliceViewer(nii);

%% binarize
img_tu_bw = imbinarize(img_tu,graythresh(img_tu));
img_tu_sk = bwskel(img_tu_bw,'MinBranchLength',5);
img_tu_sk = bwmorph3(img_tu_sk,'fill');
labelvolshow(double(img_tu_sk),img_tu,'VolumeThreshold',0.02);

%% tree
%endpts = bwmorph3(img_tu_sk,'endpoints');
%branchpts = bwmorph3(img_tu_sk,'branchpoints');
cc_tr = bwconncomp(close_sk(img_tu_sk));
%stats_tr = regionprops3(cc_tr,'Volume');
%D = bwdistgeodesic(img_tu_sk,find(branchpts),'quasi-euclidean');
img_tu_la = label_cc(cc_tr,5);
%cc_tr_con = connect_cc(img_tu_la,cc_tr,5);
labelvolshow(img_tu_la,img_tu,'VolumeThreshold',0.02);

%% connect
cc_tr_re = bwconncomp(imreconstruct(imdilate(img_tu,strel('sphere',5)),img_tu_la));
img_tu_con = label_cc(cc_tr_re,5);
img_tu_con = connect_cc(img_tu_con,10);
stats_con = regionprops3(img_tu_con,'volume');
labelvolshow(img_tu_con,img_tu,'VolumeThreshold',0.02);

%% reconstruction
[img_tu_cl,stats_cl] = clean_labels(img_tu_con,20);
img_tu_re = imreconstruct(img_tu_cl,img_tu,6);
labelvolshow(img_tu_cl,img_tu_re,'VolumeThreshold',0.02);

%% evaluation
[intv,into] = curve(imgs,img_tu_re);
plot_curve(intv,into);

%% integrate
%data_path = 'data/extracted/169/QIN-Breast-DCE-MRI-BC06-V2.mat';
data_path = 'data/extracted/171/QIN-Breast-DCE-MRI-BC06-V1.mat';
[tub,lab,stats,intv,into,rad] = vascular(data_path,0.1,0.9,5,10,20);
res = struct();
res.label = lab;
res.volume = tub;
res.stats = stats;
res.intensity_vessel = intv;
res.intensity_all = into;
res.radius = rad;
save('figs/BC06-V1.mat','res');

