function DenoisedImg=NLmeans2(I,ds,Ds,beta,sigma_2)
%I: Noisy image
%ds: Size of the neighbor block
%Ds: Size of the search window
%h: Gaussian smoothing parameter
%DenoisedImg£ºDenoised image
I=double(I);
[m,n]=size(I);
DenoisedImg=zeros(m,n);
PaddedImg = padarray(I,[ds,ds],'symmetric','both');

Ni=(2*ds+1)^2;
h2=2*beta*sigma_2*Ni;

for i=1:m
    for j=1:n
        i1=i+ds;
        j1=j+ds;
        W1=PaddedImg(i1-ds:i1+ds,j1-ds:j1+ds);
%       uNi_mean=mean2(W1);
%       VarNi_mean=sum((W1-mean2(W1)).^2)/length(W1);
        wmax=0;
        average=0;
        sweight=0;
        rmin = max(i1-Ds,ds+1);
        rmax = min(i1+Ds,m+ds);
        smin = max(j1-Ds,ds+1);
        smax = min(j1+Ds,n+ds);
        for r=rmin:rmax
            for s=smin:smax
                if(r==i1&&s==j1)
                continue;
                end
                W2=PaddedImg(r-ds:r+ds,s-ds:s+ds);
%               uNj_mean=mean2(W2);
%               VarNj_mean=sum((W2-mean2(W2)).^2)/length(W2);
%               if (0.99<(uNi_mean/uNj_mean)<(1/0.985))&&(1<(VarNi_mean/VarNj_mean)<(1/0.8))   
                Dist2=sum(sum((W1-W2).*(W1-W2)));
                w=exp(-Dist2/h2);
%               else
%                     w=0
%               end
                if(w>wmax)
                    wmax=w;
                end
                sweight=sweight+w;
                average=average+w*PaddedImg(r,s);
            end
        end
        average=average+wmax*PaddedImg(i1,j1);
        sweight=sweight+wmax;
        DenoisedImg(i,j)=average/sweight;
    end
end