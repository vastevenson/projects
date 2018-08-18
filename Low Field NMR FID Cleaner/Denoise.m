%This script removes noise from raw FID data. First, a polynomial is fit
%then subtracted to elimate macro trends and obtain a new FID. The new FID
%has a 60Hz sin function removed to make a new new FID. The new new FID
%then has a 120Hz sin function removed, and so on. 

clear; clc; close all;

load('timeVoltage')%test real data set obtained from magnetometer 

%calculate best fit polynimal of degree 3
x=polyfit(t,fid,3);%x has the coefficients of the 3rd degree poly fit
y=polyval(x,t);

%obtain new fid
new_fid=fid-y;

%now we fit a 60Hz sin function to new fid to cancel out 60Hz noise
nu=60;
%the initial guesses were found previously and are entered as an initial
%guess (IG) to reduce computation time 
IG=[0.035964592991793,-0.027961440955868,-0.005289045581153];
fid_60=fitFun(IG,nu,new_fid,t);%this is the new new fid 

%now we cancel out the 120Hz based on the previous fid 
nu=120;
%the follow IG (initial guess) was predetermined, and is close to actual
IG=[0.003587815408855,-0.032537780325238,-0.007991978609549];
fid_120=fitFun(IG,nu,fid_60,t);

%now cancel the 180Hz 
nu=180;
%the follow IG (initial guess) was predetermined, and is close to actual
IG=[-0.012355230859627,0.285813185890216,-0.054050139282495];
fid_180=fitFun(IG,nu,fid_120,t);

figure
subplot(2,2,1)       % add first plot in 2 x 2 grid
plot(t,new_fid)          
title('FID after polyfit')

subplot(2,2,2)       % add second plot in 2 x 2 grid
plot(t,fid_60)         
title('FID after polyfit and 60Hz Removed')

subplot(2,2,3)       % add third plot in 2 x 2 grid
plot(t,fid_120)          
title('FID after polyfit, 60, and 120Hz Removed')

subplot(2,2,4)       % add fourth plot in 2 x 2 grid
plot(t,fid_180)         
title('FID after polyfit, 60, 120, and 180Hz Removed')

rawSpectra=fftshift(fft(fid));%fft returns complex elements 
cSpectra=fftshift(fft(fid_180));%denoised Spectra

%need to determine x axis values (frequency)
samplingRate=(t(2)-t(1))^-1;%has units of Hz (per second)
numPoints = size(fid,1);
freqAxis = linspace(-samplingRate/2,samplingRate/2,numPoints);

figure
subplot(2,2,1)       % add first plot in 2 x 2 grid
plot(freqAxis,imag(rawSpectra),freqAxis,imag(cSpectra))
title('60Hz signal cancellation quality')
legend('Raw','Clean')
xlabel('Frequency, Hz')
axis([59 61 -100 +100])%set window

subplot(2,2,2)       % add second plot in 2 x 2 grid
plot(freqAxis,imag(rawSpectra),freqAxis,imag(cSpectra))
title('120Hz signal cancellation quality')
legend('Raw','Clean')
xlabel('Frequency, Hz')
axis([119 121 -10 +10])%set window

subplot(2,2,3)       % add third plot in 2 x 2 grid
plot(freqAxis,imag(rawSpectra),freqAxis,imag(cSpectra))
title('180Hz signal cancellation quality')
legend('Raw','Clean')
xlabel('Frequency, Hz')
axis([179 181 -10 +10])%set window