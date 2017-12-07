function [r,g,b]=Intercorr(red,green,blue,n)
global nFrames
for i=1:15
 temp=red{1,i};
 D = LMMSE(temp,5,3,n);
 r{1,i}=D;
end
for i=1:15
 temp1=green{1,i};
 D1 = LMMSE(temp1,5,3,n);
 g{1,i}=D1;
end
for i=1:15
 temp1=blue{1,i};
 D2 = LMMSE(temp1,5,3,n);
 b{1,i}=D2;
end