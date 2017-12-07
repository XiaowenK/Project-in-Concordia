clear all;
close all;
clc;

input_video='CUJul_sif.avi';
video=VideoReader(input_video);
I=read(video);
N_frames=size(I,4);
% I_denoised(:,:,:,1)=I(:,:,:,1);

tic
G=fspecial('average',3);
for t=2:N_frames
    I_noisy(:,:,:,t)=imnoise(I(:,:,:,t),'gaussian',0,0.05);
    subplot(1,2,1),imshow(I_noisy(:,:,:,t));
    title('Noisy video');
    drawnow
    I_denoised=I;
    D(:,:,:,t)=uint8(abs(double(I(:,:,:,t))-double(I_denoised(:,:,:,t-1))));
    D(:,:,:,t)=imfilter(D(:,:,:,t),G);
    K(:,:,:,t)=0.1+0.9.*(double(D(:,:,:,t))./31);
    I_denoised(:,:,:,t)=uint8(K(:,:,:,t).*double(I(:,:,:,t))+(1-K(:,:,:,t)).*double(I_denoised(:,:,:,t-1)));
    subplot(1,2,2),imshow(I_denoised(:,:,:,t));
    title('Denoised video');
    drawnow
end
toc

% Calculate the psnr and psnr gain
for t=1:N_frames
    PSNR(t)=psnr(I(:,:,:,t),I_denoised(:,:,:,t));
    PSNR1(t)=psnr(I(:,:,:,t),I_noisy(:,:,:,t));
    PSNR_gain(t)=PSNR(t)-PSNR1(t);
end

figure(2)
plot(PSNR,'green');
hold on
plot(PSNR_gain,'blue');
legend('PSNR','PSNR gain');
title('PSNR and PSNR gain');
xlabel('Frame numner'),ylabel('dB');
toc

