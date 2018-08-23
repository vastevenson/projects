function A=fitFun(IG,nu,fid,t)
%This function returns a corrected FID given an initial guess (IG),
%frequency signal to cancel (nu), initial FID (fid) and time (t)

%It works by finding coefficients b,d,c of the funciton b*sin(2*pi*(nu+d)*t+c)
%in order to generate a correcting function that cancels out a signal given
%an initial guess, frequency to cancel, fid (voltage), and time 

%In order to call fminsearch for the custom fitting function, I am using
%nested functions 

function [ds]=fit(IG)
b=IG(1);%b1 is the coef for the sin fn that cancels out 120Hz noise
c=IG(2);%phi
d=IG(3);%offset

f=b.*sin(2*pi*(nu+d)*t+c);

ds=(f-fid).^2;%find absolute value of the difference between guess and true values

ds=sum(ds);%sum the differences so we can find the minimum in our best fit
end

%fminsearch tries several different coefficients and returns the ones that
%best match the data in vector C 
C = fminsearch(@fit,IG);

b1=C(1);
c1=C(2);
d1=C(3);

y=b1.*sin(2*pi*(nu+d1)*t+c1);%function to cancel nu signal 

A=fid-y;
end