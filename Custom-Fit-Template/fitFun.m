function P = fitFun(dF,IG)
%FITFUN Summary of this function goes here
%   Detailed explanation goes here
x=dF(1,:);
y=dF(2,:);

    function [ds]=fit(IG)
       a=IG(1); 
       b=IG(2); 
       c=IG(3); 
       d=IG(4);
       
       f=a.*exp(b.*x+c)+d;
       
       ds=(f-y).^2;
       ds=sum(ds);
    end
P=fminsearch(@fit,IG);
end

