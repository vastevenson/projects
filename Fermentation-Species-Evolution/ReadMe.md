The following MATLAB functions take raw data from the CO2 mass flow meter and convert the voltages to volumetric flow rates for all time points recorded, following the relationship defined in the CBE 154 lab manual. The volumetric flow rate of CO2 is then integrated using the cumtrapz function of MATLAB to determine a running total of CO2 produced over time. 

We assume CO2 is an ideal gas as the temperature and pressure in carboy are sufficiently high and low, respectively. This allows us to determine the number of moles present. We assume that ethanol fermentation is the only source of CO2 production in the carboy, and that all glucose consumed is used for ethanol fermentation exclusively. 

Knowing the initial specific gravity (aka original gravity) of the solution, we can plot how glucose mass in the carboy evolves over time. Per an assumption made in the Fogler text, we can extrapolate the biomass and ethanol mass as a function of the glucose consumed. 

Key figures in the data analysis:

<img width="810" alt="screenshot" src="https://user-images.githubusercontent.com/35041906/44507187-6a93ae00-a65e-11e8-95ed-465b42d98c6e.PNG">

We see the expected trends, the initial lag phase, growth phase, and a tapering off of cell growth and CO2 production once the ethanol levels become toxic and the finite glucose levels drop low enough that the driving force for mass transfer into the cells falls significantly. 
