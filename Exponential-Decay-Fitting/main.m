%Exponential Decay Fitting - Vincent Stevenson
%This script fits a first order exponential decay curve to the decay regime
%in the dF plots using fminsearch to iterate through custom fitting
%parameters until a good fit is determined. To save processing time, only
%plots with a reasonable peak time (the number of frames between the
%stimulus frame and the maximum fluorescence intensity) are fitted.
%Nonvalid plots are assigned peak times of -1 and are returned with fitting
%parameters that are all 0. You can plot individual dF plots by changing i
%on line 75, but you will likely need to change the window size. 

clc;close all;

load('testData.mat') %test dataset 
sf=200;%stimulus frame, this will be supplied by user in GUI
n=size(currentDataset.measuredValues,2);%number of ROIs in dataset

%load each dF/Fo plot into a matrix size i x 600 (600 frames) 

B=[];%declare a matrix
for i=1:n
    B=[B;currentDataset.measuredValues(i).dF];
end

%iterate through all ROI's dF plots in dataset
roiCount=size(B,1);
frameCount=size(B,2);
frame=1:frameCount;
for i=1:roiCount
    
    dF=B(i,:);%load in the current dF plot
    %determine the index (frame) at which the maximum value occurs 
    [val,index] = max(dF);
    n=index-sf;%n is the peak time
    if(n < 0 || n > frameCount*0.3)
        %if the peak occurs before the stimulus frame, or if the peak does
        %not occur within 30% of the total frame count after the stimulus,
        %return -1 as the peakTime
        A(i) = -1;
        %set fitting parameters for invalid dF plot to all 0
        Afit(i)=0;
        Bfit(i)=0;
        Cfit(i)=0;
        Dfit(i)=0;
    else
        %if peak time is valid, store it for that ROI's dF
        A(i) = n;
        %now fit the first order exponential decay with non-zero baseline
        x1 = frame(index:end);
        y1 = dF(index:end);
        %y = A*exp(B*x + C) + D;
        IG=zeros(1,4);%initial guess seed for the fitting function
        P=fitFun(x1,y1,IG);
%         disp(P)
        %store the nonzero fitting parameters for the valid dF
        Afit(i)=P(1);
        Bfit(i)=P(2);
        Cfit(i)=P(3);
        Dfit(i)=P(4);
        a=P(1);
        b=P(2);
        c=P(3);
        d=P(4);
        yFit=a.*exp(b.*x1+c)+d;
%         plot(x1,y1,x1,yFit);
    end
end

%plot the raw data next to the fitted function, note that the returned
%fitting parameters function is translated to zero, so you need to
%normalize the frame number to 0

%this code is for plotting the dF plot raw data
%i is roi number
i=18;
y=B(i,:);
x=frame;

a=Afit(i);
b=Bfit(i);
c=Cfit(i);
d=Dfit(i);

yFit=a.*exp(b.*x+c)+d;

plot(x,y,x,yFit,'LineWidth',1.5)
xlim([0,600])
ylim([-0.06,0.25])
xlabel('Frame number')
ylabel('Relative Fluorescence Intensity, dF')
title('Exponential Decay Fitting')
legend('Raw data','First order exponential decay with non-zero baseline')