import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

#load in the data
#make sure the txt file is in the same directory
data = pd.read_fwf('test.txt', header=None)
time=data.iloc[:,0]#need iloc because panda doesn't look for row index
volt=data.iloc[:,1]

#need to truncate first 40 data points as garbage in time and volt
t=time[40:]
v=volt[40:]

#fit curve to raw data
p=np.polyfit(t,v,5)#fit 5th deg polynomial to raw data
c=np.polyval(p,t)#c is the list of the poly fit function

'''
#plot raw data
plt.plot(t,v,t,c)
plt.xlabel('time')
plt.ylabel('voltage')
plt.legend(['Raw voltage','Correcting Function'])
plt.title('Raw Data and Correcting Function')
plt.show()
'''

cFID=v-c
plt.plot(t,cFID)
plt.show()
