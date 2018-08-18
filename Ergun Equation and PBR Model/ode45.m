%This project models the molar flow rates of seven chemical species undergoing four  %reversible reactions in a membrane packed bed reactor (PBR) with a pressure drop.  
%Only species C can diffuse out of the membrane, and the pressure drop is derived from %the Ergun equation.  
 
%This function must be called from Matlab's ode45() from PBRscript.m to work  
%ode_sys.m function to solve coupled ODEs to calculate molar flow  
%rates through the membrane packed bed reactor given inlet conditions 
 function diffeqs=ode_sys(W,var) 
Po=101325*25;%Pa, initial P 
%inlet conditions 
Fao=105.6;%mol/s, 
Fbo=0; 
Fco=0; 
Fdo=0; 
Feo=0; 
Ffo=16.45; 
Fio=15.08; 
Fto=Fao+Fbo+Fco+Fdo+Feo+Ffo+Fio;%total molar inlet flow, constant! 
 
%Ergun Eqn Parameters vo=.45;%inlet vol flow, m3/s, const! 
Po=25*101325;%Pa, needs to be SI for the ergun eqn Po = 25atm 
T=1000;%K, rxr temp is const bc its isotherm 
To=1000;%K, inlet temp 
R=8.314; %J/molK = Pa*m3/molK 
%var is a vector containing the initial conditions 
Fa=var(1); 
Fb=var(2); 
Fc=var(3); 
Fd=var(4); 
Fe=var(5); 
Ff=var(6); 
Fi=var(7); 
 
%total mol flow rates (from initial conditions given) 
Ft=var(1)+var(2)+var(3)+var(4)+var(5)+var(6)+var(7);%sum var i, from 1 to 7, Fa thru Fi x=[Fa/Ft Fb/Ft Fc/Ft Fd/Ft Fe/Ft Ff/Ft Fi/Ft];%initial mol ratios of each comp  
%calculate the average molecular weight of inlet stream into PBR %given molecular weights 
MWa=.016;%kg/mol 
MWb=.028; 
MWc=.002; 
MWd=.078; 
MWe=.128; 
MWf=.030; 
MWi=.0387;%avg mol wt of the inerts 
M=[MWa MWb MWc MWd MWe MWf MWi];%create a vector of the MW's 
MWiFi=Fa*MWa +Fb*MWb+Fb*MWc+Fd*MWd+Fe*MWe+Ff*MWf+Fi*MWi;%sum of mol flow rates and their mol wts 
 
P=var(8); %Pressure, Pa rho=P*MWiFi/(R*T*Ft);%gas density as a function of W, P and Fi for all i are dep on W! 
 
%calc the averaged Molecular Weight at a given accumulated cat mass  
MW=sum(M.*x);%kg/mol, wt'd avg of the MW of inlet species, this changes as the molar flow rates change! rho_o=Ft*MW/vo;%gas density %kg/m3, also changing as molar flow rates changes as function of W 
gc=9.8;%gravity const, m/s2 
D=.5;%m, diam of packed bed 
Ac=pi*(D/2)^2;%cross sect area of packed bed, m2 u=vo/Ac*Po/P*Ft/Fto; 
G=u*rho; %superficial mass velocity fie=0.4;%void fraction rho_b=560;%kg/m3, bulk density of cat, const! Dp=0.01;%diam cat particle in m, 1cm mu=2e-5;%visc of feed stream, in Pa*s 
 
% beta=G*(1-fie)/(rho_o*gc*Dp*fie^3)*(150*(1-fie)*mu/Dp + 1.75*G); %param for ergun eqn, can't use bc C is MW is changing! 
% alpha = 2*beta/(Ac*rho_c*(1-fie)*Po);%param for ergun eqn, can't use bc C is MW is changing! 
 
%ergun equation 
%var(8) is P, p = P/Po for ergun eqn p=var(8)./Po; 
 
%total mol flow rates 
Ft=var(1)+var(2)+var(3)+var(4)+var(5)+var(6)+var(7);%sum var i, from 1 to  7, Fa thru Fi 
%already defined Fto and vo above 
v=vo*Ft/137.115*1/p; %vol flow as function of pressure drop and conversion  
(implicit in Ft) ca=var(1)/v;%Fa/v cb=var(2)/v;%Fb/v cc=var(3)/v;%Fc/v cd=var(4)/v;%Fd/v ce=var(5)/v;%Fe/v cf=var(6)/v;%Ff/v ci=var(7)/v;%Fi/v 
 
%rate constants and eqm constants k1=8.7e-6; %kg cat/mol *m3 k2=0.092; k3=.056; k4=12.5e-5; K1=7.4; %eqm const 
K2=11.7; 
K3=.98; 
K4=3.6; 
%calculate r1,2,3,4 for diff eqns (rates for each rxn) r1=k1*(ca^2-(cb*cc^2) / K1); r2=k2*cb/(1+K2*(cb+cc+cd)); r3=k3*cb*cd/(1+K3*(cb+cc+cd+ce)^2); r4=k4*(cf-cb*cc/K4); 
 
%rate species C diffuses out of membrane calc a=4/D;%surface area to volume ratio of PBR 
kc1=5.6e-3;%kc', units of m/s, diffusion const for H2 out of membrane PBR  kc=kc1*a; 
Rc=kc*cc;%cc defined above, conc of C, Rc is the rate C (H2) diffuses out of the membrane   
%W is cat mass, var is a vector containing the Fa...Fi, and P(pressure) 
%define the rates in their differential forms diffeqs(1,1)= -2*r1; 
diffeqs(2,1)= r1+r4 -3*r2 -2*r3; 
diffeqs(3,1)= 2*r1+3*r2+3*r3+r4 - Rc; %Rc is the rate C diffuses out of the membrane rxr diffeqs(4,1)= r2 - r3; diffeqs(5,1)= r3; diffeqs(6,1)= -r4; diffeqs(7,1)= 0;%the inerts do not react, the flow rate dFI/dW is a const. 
%ergun equation in its differential form  
diffeqs(8,1)= -u/(rho_b*Dp*Ac*gc)*(1-fie)/(fie^3)*(150*(1-fie)*mu/Dp + 1.75*(rho*u));%dP/dW  end  
%can't use alpha and beta in ergun equation because you have H2 leaving the system, need to %calc new avg mol mass!!  
