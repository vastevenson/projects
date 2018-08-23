//This code is to be uploaded to Arduino before running the Processing Code
//to allow manual operation of the valves via a GUI run though Processing 

char val; // Data received from serial port for Processing's GUI
//each valve is connected to a relay that's connected to a pin on Arduino 
int valve1 = 8; // Define the pin corresponding to each valve
int valve2 = 9; 
int valve3 =10;
int valve4 =11;
int NMR=7;
int LEDpin=13;

void setup() {
pinMode(valve1, OUTPUT); // Set pins as OUTPUT 
pinMode(valve2, OUTPUT);
pinMode(valve3, OUTPUT); 
pinMode(valve4, OUTPUT);
pinMode(NMR,OUTPUT);//declare NMR pin as the trigger for the machine 
pinMode(LEDpin,OUTPUT);

Serial.begin(9600); // Start listening for serial communication at 9600 bps
}

void loop() {

if (Serial.available()){ // If data is available to read, 
val = Serial.read(); // read it and store in val
}
//depending on the value of val, the voltage sent to each pin will change
//A change in the voltage sent to the 5V side of the relay will open or close
//the 24V side of the relay, which opens or closes the valve
if (val == '1'){
digitalWrite(valve1,HIGH);//setting valve1 HIGH opens valve 1
}
else if(val=='5'){
digitalWrite(valve1,LOW);//setting valve1 LOW closes valve 1
}
else if(val=='2'){
digitalWrite(valve2,HIGH);
}
else if(val=='6'){
digitalWrite(valve2,LOW);
}
else if(val=='3'){
digitalWrite(valve3,HIGH);
}
else if(val=='7'){
digitalWrite(valve3,LOW);
}
else if(val=='4'){
digitalWrite(valve4,HIGH);
}
else if(val=='8'){
digitalWrite(valve4,LOW);
}
else if(val=='a'){//gnd the DIGI2 pin 
digitalWrite(NMR,HIGH);
}
else if(val=='b'){//ungnd (open) the DIGI2 pin 
digitalWrite(NMR,LOW);
}
else if(val=='O'){
digitalWrite(LEDpin,HIGH);
}
else if(val=='F'){
digitalWrite(LEDpin,LOW);
}
}


