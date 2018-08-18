import controlP5.*; //import ControlP5 library
import processing.serial.*;

Serial port;

ControlP5 cp5; //create ControlP5 object
PFont font;

void setup(){ //same as arduino program

  size(450, 450);    //window size, (width, height)
  
  printArray(Serial.list());   //prints all available serial ports
  
  port = new Serial(this, "COM7", 9600);  //You may need to change COM7 to COMX, where X is the correct port for Arduino!
  //lets add buton to empty window
  
  
  
  cp5 = new ControlP5(this);
  font = createFont("calibri light bold", 16);    // custom fonts for buttons and title
  cp5.setFont(font);
  
  // create a toggle and change the default look to a (on/off) switch look
  cp5.addButton("toggle1")
     .setPosition(100,120)
     .setSize(110,50)
     .setCaptionLabel("Open/Close")//sets the default state when turned on, also follow up with sending close commands to all valves (write a function!) 
     ;
    cp5.addButton("toggle2")
     .setPosition(100,120+70)
     .setSize(110,50)
     .setCaptionLabel("Open/Close")//sets the default state when turned on, also follow up with sending close commands to all valves (write a function!) 
     ;
    cp5.addButton("toggle3")
     .setPosition(100,120+140)
     .setSize(110,50)
     .setCaptionLabel("Open/Close") 
     ;
    cp5.addButton("toggle4")
     .setPosition(100,120+210)
     .setSize(110,50)
     .setCaptionLabel("Open/Close") 
     ;
   int x1=5;
   cp5.addButton("ValveCheck")     //"red" is the name of button
    .setPosition(280+x1, 110)  //x and y coordinates of upper left corner of button
    .setSize(120, 50)      //(width, height)
    .setCaptionLabel("Valve Check");
  ;     
   cp5.addButton("NMR")     //"red" is the name of button
    .setPosition(280+x1, 110+70)  //x and y coordinates of upper left corner of button
    .setSize(120, 50)      //(width, height)
    .setCaptionLabel("NMR Trigger");
  ;   
   cp5.addButton("CloseAll")     //"red" is the name of button
    .setPosition(280+x1, 110+140)  //x and y coordinates of upper left corner of button
    .setSize(120, 50)      //(width, height)
    .setCaptionLabel("Close All");
  ;    
     cp5.addButton("Custom")     //"red" is the name of button
    .setPosition(280+x1, 110+210)  //x and y coordinates of upper left corner of button
    .setSize(120, 50)      //(width, height)
    .setCaptionLabel("Custom");
  ;    
  
}

//all valves are closed initially, so set their bool appropriately
boolean isOpen1=false;
boolean isOpen2=false;
boolean isOpen3=false;
boolean isOpen4=false;

void draw(){  //same as loop in arduino

  background(255,255,255); // background color of window (r, g, b) or (0 to 255)
  line(30,180,200,180);//x1,y1,x2,y2
  line(30,180+70,200,180+70);//x1,y1,x2,y2
  line(30,180+140,200,180+140);//x1,y1,x2,y2
  line(30,180+210,200,180+210);//x1,y1,x2,y2
  line(220,100,220,180+210);
  //lets give title to our window
  fill(0, 0, 0);               //text color (r, g, b)
  textFont(font);
  int x = 30;
  int y= 150;
  text("All valves are closed by default at startup.",x,40);
  text("Make sure the COM port is correct in the declaration!",x,65);
  text("Click OPEN/CLOSE to toggle open or close a valve:",x,65+25);
  text("Valve 1", x, y);  // ("text", x coordinate, y coordinat)
  text("Valve 2", x, y+70);
  text("Valve 3", x, y+140);
  text("Valve 4", x, y+210);
}

//define functions that will send signal to Arduino to operate valves
//the signals are sent to serial on Arduino, which bases its output on the port's written value
//When '1' is received, Arduino opens valve 1, when '5' is received, it closes valve 1
void OV1(){
  port.write('1');//open valve 1
}
void CV1(){
  port.write('5');//close valve 1
}
void OV2(){
  port.write('2');//open valve 2
}
void CV2(){
  port.write('6');//close valve 2
}
void OV3(){
  port.write('3');//open valve 3
}
void CV3(){
  port.write('7');//close valve 3
}
void OV4(){
  port.write('4');//open valve 4
}
void CV4(){
  port.write('8');//close valve 4
}


//define the callback functions for the buttons in GUI
//toggle1 is for button1 
boolean toggle1(){
if(isOpen1){
  //if valve 1 is open, close it, update isOpen1 to false
  port.write('5');
  isOpen1=false;
  }else{
   port.write('1');
   isOpen1=true;
  }
  println("Valve 1 signal sent to Arduino");
  return isOpen1;
}

boolean toggle2(){
if(isOpen2){
  port.write('6');
  isOpen2=false;
  }else{
   port.write('2');
   isOpen2=true;
  }
  println("Valve 2 signal sent to Arduino");
  return isOpen2;
}

boolean toggle3(){
if(isOpen3){
  port.write('7');
  isOpen3=false;
  }else{
   port.write('3');
   isOpen3=true;
  }
  println("Valve 3 signal sent to Arduino");
  return isOpen3;
}

boolean toggle4(){
if(isOpen4){
  port.write('8');
  isOpen4=false;
  }else{
   port.write('4');
   isOpen4=true;
  }
  println("Valve 4 signal sent to Arduino");
  return isOpen4;
}

void ValveCheck(){
//cycle through the four valves  
  int t=500;//delay time in ms
  for (int i=0; i<3; i+=1){
    OV1();//open valve 1
    delay(t);//wait 1 second (t ms)
    CV1();//close valve 1
    OV2();//open valve 2
    delay(t);//wait 1 second
    CV2();//close valve 2
    OV3();//open valve 3
    delay(t);//wait
    CV3();//close valve 3
    OV4();//open valve 4
    delay(t);//wait
    CV4();  //close valve 4
  }
}

void NMR(){
   println("NMR trigger");
   //fill(0);
   port.write('a');//gnd DIGI2 pin for 1 second
   delay(2000);
   port.write('b');//ungnd DIGI2 pin 
   delay(100);
   println("Falling edge trigger sent to DIGI2 pin of NMR machine for spectra acquisition.");
}
void CloseAll(){
  //close all valves
CV1();
CV2();
CV3();
CV4();
println("All valves closed.");
}

void Custom(){
    OV1();
    delay(1000);
    CV1();
    OV2();
    delay(2000);
    CV2();
    OV3();
    delay(3000);
    CV3();
    OV4();
    delay(4000);
    CV4();
}
