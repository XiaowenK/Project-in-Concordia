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

PaddedImg = padarray(I1,[1,1],'symmetric','both'); 
I2 = padarray(I,[1,1],'symmetric','both');

tic
O1=NLmeans(I1,1,5,0.1,sigma_2);
toc

figure;
imshow(rot90(I2),[]);
title('Ground truth');
figure;
imshow(rot90(PaddedImg),[]);
title('Noisy image 9%');
figure;
imshow(rot90(O1),[]);
title('Blockwise NL-means');

rmse=sqrt((sum(sum((I2-O1).^2)))/(181*217));
range=255;
psnrl=20*log10(range/rmse)

