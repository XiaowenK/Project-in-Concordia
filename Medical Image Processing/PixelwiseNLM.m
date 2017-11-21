close all;
clear all;
clc

load t2_1mm_noise0_RF0
I=vol(:,:,100);
I=double(I);
I=I-min(I(:));
I=I/max(I(:));

level=0.09;
sigma_2=level*max(I(:));
I1=imnoise(I,'gaussian',sigma_2);

tic
O1=NLmeans2(I,1,5,0.3,sigma_2);
toc

figure;
imshow(rot90(I),[]);
title('Ground truth');
figure;
imshow(rot90(I1),[]);
title('Noisy image 9%');
figure;
imshow(rot90(O1),[]);
title('Optimized Pixelwise NL-means');

rmse=sqrt((sum(sum((I-O1).^2)))/(181*217));
range=255;
psnrl=20*log10(range/rmse)


