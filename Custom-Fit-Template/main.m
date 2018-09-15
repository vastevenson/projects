%generate plots of slightly noisy curve a.*exp(b.*x+c)+d;
clear; clc; close all;
x=1:0.1:3;
A = 1;
B = -2;
C = 3;
D = 4;
y1=(A.*exp(x.*B + C) + D);
e = (1+rand(size(y1,2),1)./20)';
y = y1.*e;
% plot(x,y);
dF=[x;y]; %sample exponential decay region

IG=ones(1,4);
P=fitFun(dF,IG);
a=P(1);
b=P(2);
c=P(3);
d=P(4);

yFit=a.*exp(b.*x+c)+d;

plot(x,y,x,yFit)
