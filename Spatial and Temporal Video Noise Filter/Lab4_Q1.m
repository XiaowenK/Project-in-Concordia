close all;
clear all;
clc;

tic
% Load the video
input_video='stefan_cif.avi';
video=VideoReader(input_video);
I=read(video);
N_frames=size(I,4);
% Add the noise
for t=1:N_frames  
    I_noised(:,:,:,t)=imnoise(I(:,:,:,t),'gaussian',0,0.05);
    subplot(1,2,1),imshow(I_noised(:,:,:,t));
    title('Noisy video');
    drawnow
end
% Denoising
for t=1:N_frames       
    G=fspecial('gaussian',5,0.5);
    I_denoised(:,:,:,t)=imfilter(I_noised(:,:,:,t),G);
    subplot(1,2,2),imshow(I_denoised(:,:,:,t));
    title('Denoised video');
    drawnow
end
% Calculate the psnr and psnr gain
for t=1:N_frames
    PSNR(t)=psnr(I(:,:,:,t),I_denoised(:,:,:,t));
    PSNR1(t)=psnr(I(:,:,:,t),I_noised(:,:,:,t));
    PSNR_gain(t)=PSNR(t)-PSNR1(t);
end

figure(2)
plot(PSNR,'green');
hold on
plot(PSNR_gain,'blue');
legend('PSNR','PSNR gain');
title('PSNR and PSNR gain');
xlabel('Frame numner'),ylabel('PSNR gain');
toc
