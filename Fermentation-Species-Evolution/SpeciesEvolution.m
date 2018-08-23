close all; clear; clc;

V=9463;%vol of wort, in mL 

%this contains time (s) and the flow rate of CO2 (mL/min) 
load('CO2data.mat')
%use trapz to find the area under the curve, which will tell us the total
%CO2 volume produced 
%bc time [=] s, need to convert to min
t=time./60;%time in mins
%now we find Co2 produced using the formula correlation in lab manual 
Q=78.592.*volt-3.091;%vol flow rate of CO2 mL/min
%now find total volume of CO2 produced 
mLCO2=trapz(t,Q);
LCO2=mLCO2/1000;
molCO2=LCO2/22.4;%22.4L/mol if we assume CO2 is ideal gas, safe assumption 
%because molecules have no interactions with each other and occupy no
%volume. Because the volume is large enough, we can assume gas atoms occupy
%no volume. Because P is low. 
massCO2=molCO2*44.01;%g of CO2 made 

%from the reaction mechanism, we know that for every mole of CO2 made, one
%mole of EtOH is also made, as well as two mole of glucose because a
%glucose is broken down into two mole of pyruvate. 
molEtOH=molCO2;
SG=1.104;%original gravity of wort before fermentation 
%now find g/mL of glc in solution as function of specific gravity

%rearragne eqn1 in PROJ3 lab manual to get Cs as fn of SG 
Cso=10000*(SG-1)/(1327*SG+2488);%intial glc concentration, g/mL
%in 2.5gal, there are 9463mL 
massGlc0=Cso*V;%g glc at t=0
molGlc0=massGlc0/180.156;%total mol of glc present at t=0

flowCO2=Q/1000/22.4;%mol CO2 per min that is produced 

%now we can calculate the mol evolution of the species in solution 
%for every mole of EtOH or CO2 made, 1/2 mole of glc was consumed. 
runTotCO2=cumtrapz(t,flowCO2);%running total of mol of CO2 produced
runTotCO2(runTotCO2<0)=0;%force all negative readings to be 0
runTotGlc=molGlc0-0.5.*runTotCO2;
runTotEtOH=runTotCO2;
runConcGlc = runTotGlc/(3.785*2.5); %changing concentration of glucose

mCO2=runTotCO2.*44.01;%g of CO2 produced, cumulative 
mGlc=runTotGlc.*180.16;%cum g of glc produced
mEtOH=runTotEtOH.*46.07;%cum g of etoh made 
mCells=0.1.*runTotEtOH +40;%cum mass of cells in wort, assume 40g of yeast initially

Cglc=mGlc./9463;%g/mL glc in Beer Lab 


%diff(mCells)./diff(t)
dMcdT=[0;diff(mCO2)./6.67];
cEtOH = mEtOH/(V);
%if you don't do ./ on line 54, you get Ks around what we expect. 
mu=dMcdT./mCells.*3600;%sp. growth rate, 1/hr

%now account for toxicity
cP=0.093;%toxic conc of ethanol, g/mL
% muT=(-cEtOH./cP+1).*mu;%mu with toxicity parameter [=] 1/hr
muT=mu;

Cs=mGlc./V;

save('BeerLabCsMu.mat','Cglc','muT')

% figure 
% plot(t,dMcdT)
% xlabel('time, mins')
% ylabel('dMc/dt, g/hr')

% figure 
% plot(1./Cs,1./muT,'b.','MarkerSize',20)
% title('Ks and mu,max calculation')
% xlabel('1/Cs [=] mL/g')
% ylabel('1/mu (with toxicity) [=] hour')


% figure 
% plot(Cs,muT)
% % ylim([0.01 1.2])
% xlabel('Dextrose concentration, g/mL')
% xlim([0.12 0.26])
% ylabel('mu, specific growth rate with toxicity, per hour')
% title('Yeast Kinetics')
% set(findall(gca, 'Type', 'Line'),'LineWidth',4);

% dCdt = diff(mCells)/6.67; %numerical differentiation
% dcdt = [0; dCdt]; %column vector for the cells, essentially appended
% mu = dcdt./mCells;

figure 
subplot(2,2,3)
plot(t,mGlc,t,mEtOH,t,mCO2,t,mCells)
title('Species Evolution During Fermentation')
set(findall(gca, 'Type', 'Line'),'LineWidth',2);
legend('glucose','ethanol','carbon dioxide','biomass')
xlabel('time, minutes')
ylabel('mass, g')
ylim([-2 2600])
xlim([0 5120])

subplot(2,2,1)
plot(t,Q)
xlim([0 5120])
title('CO_2 Volumetric Flow Rate')
xlabel('time, minutes')
ylabel('mL CO_2/min')

subplot(2,2,2)
plot(t,runTotCO2)
xlim([0 5120])
title('Cumulative CO_2 Produced')
xlabel('time, minutes')
ylabel('mL CO_2')
set(findall(gca, 'Type', 'Line'),'LineWidth',2);
