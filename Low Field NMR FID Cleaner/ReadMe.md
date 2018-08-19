Objective:
Cancel known noise signals recorded during low field NMR experiments. 

Background:
Low field NMR refers to performing NMR spectroscopy at low magnetic fields. NMR is a tool used to study chemical structures, kinetics, and reaction mechanisms. Current NMR technology requires powerful magnets to detect signals (differences in the absorption of particular frequencies due to the unique Larmor frequency of certain atoms in particular environments). If we can discover better methods and demonstrate the efficacy of NMR at low magnetic fields, NMR machines will become much cheaper and the spectra obtained may be better. 

Raw data is obtained from a magnetometer, a detector that records a voltage every millisecond along a particular plane in a magnetically insulated apparatus. This raw data is contaminated with the wall outlet frequency (120Hz), as well as other frequencies (60 and 180Hz). The raw data exists in the time domain and will appear as sharp noise signals in the obtained NMR spectra if not corrected. The time domain data is shown in ProcessPlots.png file. 

The time domain data needs to have the noise signal frequencies removed before taking the Fourier Transform. The Denoise.m and fitFun.m matlab files accomplish this, and the quality of the noise correction is illustrated in FinalCancelQuality.png. 

To run the code, copy Denoise.m, fitFun.m, and timeVoltage.mat into the same MATLAB directory, and run Denoise.m. You should see two figures, both with multiple plots. 

Methods:

A polynomial fit first linearizes the raw voltage and time data so that the appropriate sine functions can be fit: 

<img width="843" alt="noise removal" src="https://user-images.githubusercontent.com/35041906/44313152-e3bda780-a3b7-11e8-8def-21e1be8fb978.PNG">

A 60Hz, 120Hz, and 180Hz sine wave is then fit to the data (the known noise signals from the wall power outlet) and removed, which helps us recognize the analyte signals before taking Fourier Transform: 

<img width="476" alt="signalcleanup" src="https://user-images.githubusercontent.com/35041906/44313161-19629080-a3b8-11e8-9720-dfd5ae2ae91e.PNG">


We can more closely view the noise cancellation quality by checking the Fourier transform:

<img width="484" alt="finalcancelquality" src="https://user-images.githubusercontent.com/35041906/44313167-339c6e80-a3b8-11e8-9dba-f9f9ff233cc0.PNG">


