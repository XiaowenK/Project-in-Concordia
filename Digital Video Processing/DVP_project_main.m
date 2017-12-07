% ELEC6631, Digital Video Processing
% Matlab code for final project
% Xiaowen Ke on 15.04.2017 
close all;
clear all;
clc;

%% Load the video
input_video='stefan_cif.avi';
video=VideoReader(input_video);
I=read(video);
I=I(:,:,:,1:15); %
N_frames=size(I,4);
% N_frames=5;

%% Add the noise
for t=1:N_frames
    I_noised(:,:,:,t)=imnoise(I(:,:,:,t),'gaussian',0,0.005); 
end

%% Format transformation
for k=1:N_frames
I_noisy{k}=I_noised(:,:,:,k);
save('I_noisy.mat');
end

%% Each frame into RGB
load I_noisy
global nFrames
for i=1:N_frames
    temp=I_noisy{1,i};
    temp=im2double(temp);
    r=temp(:,:,1);
    g=temp(:,:,2);
    b=temp(:,:,3);
    figure(1),set(gcf, 'Name','Separated Color Channels','numbertitle','off');
    subplot(1,3,1),imshow(r);title('Red Channel');drawnow
    subplot(1,3,2),imshow(g);title('Green Channel');drawnow
    subplot(1,3,3),imshow(b);title('Blue Channel');drawnow
    red{1,i}=r;
    green{1,i}=g;
    blue{1,i}=b;
end

%% LMMSE Denoising
n=0.15;
[r,g,b]=Intercorr(red,green,blue,n);
for i=1:N_frames
    temp=r{1,i};
    temp1=g{1,i};
    temp2=b{1,i};
    I_denoised(:,:,1)=r{1,i};
    I_D(:,:,1,i)=I_denoised(:,:,1);
    I_denoised(:,:,2)=g{1,i};
    I_D(:,:,2,i)=I_denoised(:,:,2);
    I_denoised(:,:,3)=b{1,i};
    I_D(:,:,3,i)=I_denoised(:,:,3);
    figure(2),set(gcf, 'Name','Denoised color channel');
    subplot(1,3,1),imshow(temp);title('Red Channel');drawnow
    subplot(1,3,2),imshow(temp1);title('Green Channel');drawnow
    subplot(1,3,3),imshow(temp2);title('Blue Channel');drawnow
end

%% Plots
for t=1:N_frames
    temp3=I(:,:,:,t);
    temp4=I_noised(:,:,:,t);
    temp5=I_D(:,:,:,t);
    figure(3);
    subplot(1,3,1),imshow(temp3),title('Original video');drawnow
    subplot(1,3,2),imshow(temp4),title('Noisy video');drawnow
    subplot(1,3,3),imshow(temp5),title('Denoised video');drawnow
end

%% Calculate the cPSNR
for i=1:N_frames
    temp6=double(I(:,:,:,i));
    temp7=double(I_D(:,:,:,i));
    N=prod(size(temp6));
    t1=sum((temp6(:)-temp7(:)).^2);
    MSE=(t1/N)*0.2/100;
    cPSNR(i)=10*log10(255*255/MSE);
end 
figure(4)
plot(cPSNR);
title('coastguard');
xlabel('Frame number'),ylabel('cPSNR');

% %% Compare the honogeneous area and textured area
% temp8=double(I(:,:,:,15));
% temp9=temp8(223:238,1:16);
% temp10=double(I_D(:,:,:,15));
% temp11=temp10(223:238,1:16);
% N=prod(size(temp9));
% t1=sum((temp9(:)-temp11(:)).^2);
% MSE=(t1/N)*0.2/100;
% cPSNr=10*log10(255*255/MSE);

