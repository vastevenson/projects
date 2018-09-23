function P = fitFun(x,y,IG)
%FITFUN this function determines the best fitting parameters for a first
%order exponential decay with a non-zero baseline. 
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