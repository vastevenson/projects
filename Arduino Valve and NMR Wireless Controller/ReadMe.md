This project used an Arduino to control valves and a falling edge trigger for NMR spectra acquisitions via a graphical user interface. To run it, upload ArduinoVCandNMR.ino to an Arduino, then run the VCandNMRgui.pde from Processing. 

I added wireless connectivity to the Arduino via an HC-06 RF bluetooth (BT) transceiver. It runs on the 5V supplied by the Arduino and consumes very little power relative the wifi modules and is more secure as there are no servers we need to connect to.

<img width="167" alt="bluetoothmod" src="https://user-images.githubusercontent.com/35041906/44313086-ea97ea80-a3b6-11e8-93cc-96f472be4bf2.png">

 
Use the following map to connect the BT module to Arduino:
Bluetooth-Module	Arduino
RXD	TX
TXD	RX
VCC	5V
GND	GND

Turn on bluetooth on a Windows laptop and connect to the device called: HC-06. It will prompt for a pin, the pin is: 1234. In settings on the Windows machine, view More Bluetooth Options, and click on the tab for COM Ports. 

<img width="312" alt="bthookup" src="https://user-images.githubusercontent.com/35041906/44313093-fe435100-a3b6-11e8-9a9b-bf90ab04f980.png">
 
Determine the COM port number associated for Outgoing Communications to HC-06; on my laptop, it’s COM7 (but you need to check). In the future, we can use Arduino to send data to the computer using the Incoming port and have it displayed in the graphical user interface (GUI). 

The name of the Arduino code is ArduinoVCandNMR, make sure it has been uploaded to the Arduino. The Arduino controls valves and the NMR spectra acquisition by raising and lowering the voltage on pins via the following table: 

Arduino Pin Number	Item Controlled
7	NMR Spectra Trigger
8	Valve 1
9	Valve 2
10	Valve 3
11	Valve 4

Run the Processing code: VCandNMRgui 
You may need to change the COM port to be correct, in the COM port declaration of the Processing code: 

<img width="312" alt="processingport" src="https://user-images.githubusercontent.com/35041906/44313097-0a2f1300-a3b7-11e8-8738-975cdf5c4dc0.png">


When the code runs successfully, you will see the following window appear: 

<img width="172" alt="gui" src="https://user-images.githubusercontent.com/35041906/44313101-23d05a80-a3b7-11e8-95a3-614939697387.png">
 
OPEN/CLOSE will toggle open or close a specific valve. 
VALVE CHECK will open and close all valves individually for troubleshooting
NMR TRIGGER sends a falling edge signal to DIGI2 pin, causing a spectra acquisition
CLOSE ALL closes all valves
CUSTOM is a callback that will let you define custom presets (ie: open valve 1 for 3 seconds, close valve 1 and open valve 2 for 2 seconds, etc) so you can automate repetitive tasks. 

In future versions, we can use the analog inputs of Arduino to respond to pressure or temperature changes. The Arduino would act as a PID controller (proportional-integral-derivative) and respond automatically to input perturbations. 

Here is a mapping of the serial inputs that Arduino receives to what it does in response: 

Serial Input	Response
‘1'	Open valve 1, set pin8 to HIGH
‘5'	Close valve 1, set pin 8 to LOW
‘2'	Open valve 2
‘6'	Close valve 2
‘3'	Open valve 3
‘7'	Close v3
‘4'	open v4
‘8'	close v4
‘a'	ground digi 2 pin
‘b'	unground (open) the digi 2 pin





