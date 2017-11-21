function DenoisedImg_P=NLmeans(I,ds,Ds,beta,sigma_sq)

%I: Noisy image
%ds: Size of the neighbor block
%Ds: Size of the search window
%h: Gaussian smoothing parameter
%DenoisedImg£ºDenoised image

I=double(I);
[m,n]=size(I);
DenoisedImg=zeros(m,n);
DenoisedImg_P=zeros(m+2,n+2);
PaddedImg = padarray(I,[ds,ds],'symmetric','both'); 

Ni=(2*ds+1)^2;
h2=2*beta*sigma_sq*Ni;

for i=1:ceil(m/2)
    for j=1:ceil(n/2)
        i1=2*i;
        j1=2*j; 
        W1=PaddedImg(i1-ds:i1+ds,j1-ds:j1+ds); 
%         uNi_mean=mean2(W1);
%         VarNi_mean=sum((W1-mean2(W1)).^2)/length(W1);
        wmax=0;
        average=zeros(3,3);
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
%                 uNj_mean=mean2(W2);
%                 VarNj_mean=sum((W2-mean2(W2)).^2)/length(W2);
%                 if (0.99<(uNi_mean/uNj_mean)<(1/0.99))&&(0.9<(VarNi_mean/VarNj_mean)<(1/0.95))  
                Dist2=sum(sum((W1-W2).*(W1-W2)));
                w=exp(-Dist2/h2);
%                 else
%                     w=0;
%                 end                   
                if(w>wmax)
                    wmax=w;  
                end
                sweight=sweight+w;    
                average=average+w*W2; 
            end
        end
        average=average+wmax*W1;  
        sweight=sweight+wmax;   
        Overlap=[4,2,4;2,1,2;4,2,4];
        DenoisedImg_P(i1-ds:i1+ds,j1-ds:j1+ds)=DenoisedImg_P(i1-ds:i1+ds,j1-ds:j1+ds)+(average/sweight)./Overlap;
    end
end

