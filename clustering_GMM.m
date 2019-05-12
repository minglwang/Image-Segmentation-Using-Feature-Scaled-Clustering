clear all
% read the image and view it
img = imread('images/12003.jpg');
figure('Renderer', 'painters', 'Position', [100 100 600 200])
subplot(1,3,1); imagesc(img); axis image;
title("image")
% extract features (stepsize = 7)
[X, L] = getfeatures(img, 7);
XX = [X(1:2,:) ; X(3:4,:)/10]; % downscale the coordinate features (see part (b))
% run kmeans 
[C,Y] = GMM(XX,4,0.8,0.2,0.00001);
% make a segmentation image from the labels
Y=Y(5,:);
segm = labels2segm(Y, L);
subplot(1,3,2); imagesc(segm); axis image;
title("segmentation")
% color the segmentation image
csegm = colorsegm(segm, img);
subplot(1,3,3); imagesc(csegm); axis image
title("colored segmentation")