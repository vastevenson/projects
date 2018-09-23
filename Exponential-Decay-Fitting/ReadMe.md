Exponential Decay Fitting - Vincent Stevenson

To run this script, clone the repo and run main.m from the correct directory. 
The script fits a custom first order exponential decay curve to the decay regime in dF plots of nanosensor imaging datasets generated from my postdoc's repo: https://github.com/jtdbod/Nanosensor-Brain-Imaging.

I use fminsearch to iterate through fitting parameters until a best fit is determined. To save processing time, only plots with a reasonable peak time (the number of frames between the stimulus frame and the maximum fluorescence intensity) are fitted.

Nonvalid plots are assigned peak times of -1 and are returned with fitting
parameters that are all 0. You can plot individual dF plots by changing i
on line 75, but you will likely need to change the window size. 

An example of the fitted exponential decay with the raw data: 

<img width="390" alt="figure" src="https://user-images.githubusercontent.com/35041906/45930962-71daff80-bf1b-11e8-9d7c-b02208dfbe86.PNG">
