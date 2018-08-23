%script to call ODE45 and generate Fi's (mol flow rates) and P based on cat %mass, W and generate plots of the molar flow rates as a function of W 
cat=[0:500];%accumulated cat mass, kg 
%defining initial conditions 
vo=.45;%inlet vol flow, m3/s 
Po=25*101325;%Pa, needs to be SI for the ergun eqn Po = 25atm 
To=1000;%K, inlet temp 
R=8.314; %J/molK = Pa*m3/molK 
Fto=Po*vo/(R*To);%total molar inlet flow rate 
%inlet molar ratios 
xao=.77; 
xfo=.12; 
xio=.11; 
%inlet molar flow rates 
Fao=xao*Fto;%mol/s 
Fbo=0; 
Fco=0; 
Fdo=0; 
Feo=0; 
Ffo=xfo*Fto; 
Fio=xio*Fto; 
%defining initial condition vector to send to ode45 
ICs=[Fao, Fbo, Fco, Fdo, Feo, Ffo, Fio, Po]; %Fao, Fbo,... Po (initial pressure) 
%call ode45 to solve 8 coupled DEs at each point along PBR with ICs 
[wsol, varsol]=ode45(@ode_sys,cat,ICs); 
%plotting the flow rates as function of catalst mass 
figure 
plot(wsol,varsol(:,1),wsol,varsol(:,2),wsol,varsol(:,3),wsol,varsol(:,4),w 
sol,varsol(:,5),wsol,varsol(:,6),wsol,varsol(:,7)) 
title('1B: Molar Flow Rates as a function of Catalyst Mass') 
xlabel('Catalyst Mass, kg') 
ylabel('Molar Flow Rates (mol/s)') 
legend('Fa','Fb','Fc','Fd','Fe','Ff','Fi') 
figure 
plot(wsol,varsol(:,8)) 
title('1B: Pressure as a function of Catalyst Mass') 
xlabel('Catalyst Mass, kg') 
ylabel('Pressure, Pa') 
legend('P') 
%calculate Rc, molar flux of H2 out of membrane reactor 
%total mol flow rate 
Ft=varsol(:,1)+varsol(:,2)+varsol(:,3)+varsol(:,4)+varsol(:,5)+varsol(:,6) 
+varsol(:,7);%calculating Ft 
vo=.45;%inlet vol flow, m3/s 
Po=25*101325;%Pa, needs to be SI for the ergun eqn Po = 25atm 
To=1000;%K, inlet temp 
R=8.314; %J/molK = Pa*m3/molK 
Fto=Po*vo/(R*To);%total molar inlet flow rate 
%already defined Fto and vo above 
v=vo*Ft/Fto*Po./varsol(:,8); %vol flow as function of pressure drop and 
%conversion, varsol(:,8) is P at a given W 
cc=varsol(:,3)./v;%Fc/v to get cc 
D=0.5;%m, diam of packed bed 
%rate species C diffuses out of membrane 
a=4/D;%surface area to volume ratio of PBR 
kc1=5.6e-3;%kc', units of m/s, diffusion const for H2 
kc=kc1*a; 
Rc=kc.*cc;%cc defined above, conc of C 
%now, plot Rc as function of W, the rate at which H2 diffuses out of membrane as fn of W 
figure 
plot(wsol,Rc) 
title('1B: H2 into Sweep Stream as function of Catalyst Mass') 
xlabel('Catalyst Mass, kg') 
ylabel('Mol Flow of H2 Out, mol/s') 
%We need the total Mol flow of H2 diffusing out, so sum Rc 
sweepH2flow=sum(Rc);%mol/s, total mol flow of H2 in sweep stream
