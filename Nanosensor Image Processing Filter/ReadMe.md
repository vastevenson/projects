#ReadMe Nano Image Processing Filter
The purpose of these MATLAB functions is to improve efficiency and objectivity of my team's data analysis by iterating through fluorescence profiles of regions of interest (ROI) from IR footage of ex vivo mice brains response to stimuli. 
These functions were added to my post doc's repo: https://github.com/jtdbod/Nanosensor-Brain-Imaging
The ROI returned by MATLABs image processing toolbox contained many nonsense plots, which previously needed to be manually screened and deleted. 
filterROI takes in the stimulus frame (sf) and extracts the dF plots for each ROI from currentDataset struct, then calls sigResp with the dF array and sf. 
sigResp returns a bool array for each ROI based on if there is a significant response around the sf. 
linBases returns a bool array for each ROI based on if there is an initial, linear baseline (which I have defined to be from frame 0 to 80% of the stimulus time), and a linear terminal baseline (which I have defined to be the last 30% of frames).
filterROI then adds validMeasuredValues, validMask, and validLmatrix based on the ROIs that have passed both sigResp and linBases. 
I did my best to make the GUI easy to use, so I defined a new variable in the base workspace called isLoaded, which is initially 0 and only set to 1 after loadbutton executes successfully. I have the filterButton callback make sure  that the data is loaded and a stimulus frame (sf) has been specified before it calls filterROI.m. 
I have static text fields next to the fitler button that will display why it won’t execute if a user is using it. 
I encourage people who use this to play around with linBases and sigResp as needed, the tuning parameters make a big difference in the ROIs that pass the tests. 

Raw dF plot (left in blue), the smoothed function (red), and the slope of the smoothed function (blue plot to the right) that sigResp and linBases use for the filter: 

<img width="587" alt="filter1" src="https://user-images.githubusercontent.com/35041906/44312897-27aead80-a3b4-11e8-9938-4ed890e5dc92.png">

Updated mask after ROIs that have not passed the filter have been removed: 
<img width="583" alt="filter2" src="https://user-images.githubusercontent.com/35041906/44312922-87a55400-a3b4-11e8-9d4b-08ae84f1c494.png">

GUI interface with notifications when not all inputs are specified: 
<img width="587" alt="filter3" src="https://user-images.githubusercontent.com/35041906/44312960-0a2e1380-a3b5-11e8-86e8-4e506548112b.png">

Moving forward, we can include more inputs for the filter, such as the initial and terminal baseline length, and the reponse limit for sigResp. 
