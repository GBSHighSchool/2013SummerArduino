import processing.serial.*;

Serial myPort;
short portIndex = 0;
PFont f;  // Font object declaration
public static final char HEADER = 'H';

// Part 1. LED control
public static int button1 = 0;
public static int button2 = 0;
public static int button3 = 0;
public static int button4 = 0;

public static final char LED_TAG = 'L';
public static int  LED1 = 1;
public static int  LED2 = 2;
public static int  LED3 = 3;
public static int  LED4 = 4;

public static int  ON = 1;
public static int  OFF = 0;

void setup() {
  size (200,225);
  f = createFont("Georgia-Bold", 20, true); // font creating for text

  String portName = Serial.list()[portIndex];
  println(Serial.list());
  myPort = new Serial(this, portName, 9600);
}

void draw() {
  background(255);
 
// Structure Setup
  stroke(0);  // outer line of polygon, 0: black, 255: LED5
  fill(0);
  line(100,0,100,200);
  line(0,100,200,100);
  line(0,200,200,200);
  line(0,225,200,225);
 
// Text Setup 
  textFont(f,16);
  fill(0);
  textAlign(CENTER);

// Part 1. LED control
  text("LED1",50,95);
  text("LED2",150,95);
  text("LED3",50,195);
  text("LED4",150,195);
  text("GBS LED Control",100,220);

// Button Setup

// Part 1. LED control
  if (button1 == ON) {
    fill(255,0,0);   // LED1
    ellipse(50,50,50,50);
  } else {
    fill(125,125,125);
    ellipse(50,50,50,50);
  }
  if (button2 == ON) {
    fill(0,255,0);  // LED2
    ellipse(150,50,50,50);
  } else {
    fill(125,125,125);
    ellipse(150,50,50,50);
  } 
  if (button3 == ON) {
    fill(0,0,255);  // LED3
    ellipse(50,150,50,50);
  } else {
    fill(125,125,125);
    ellipse(50,150,50,50);  
  }
  if (button4 == ON) {
    fill(255,255,255);  // LED4
    ellipse(150,150,50,50);
  } else {
    fill(125,125,125);  // GRAY
    ellipse(150,150,50,50);
  }



}

void mousePressed() 
{

// Part 1. LED control  
  if (mouseX <100 && mouseY <100) {
      println("LED1 Clicked");
      if (button1 == ON) {
        button1 = OFF;
      }
      else if (button1 == OFF) {
        button1 = ON;
      }
      sendMessage(LED_TAG, LED1, button1);
    }
    if (mouseX >100 && mouseX <200 && mouseY <100) {
      println("LED2 Clicked");
      if (button2 == ON) {
        button2 = OFF;
      }
      else if (button2 == OFF) {
        button2 = ON;
      }
      sendMessage(LED_TAG, LED2, button2);
    }
    if (mouseX <100 && mouseY >100 && mouseY <200) {
      println("LED3 Clicked");
      if (button3 == ON) {
        button3 = OFF;
      }
      else if (button3 == OFF) {
        button3 = ON;
      }
      sendMessage(LED_TAG, LED3, button3);
    }
    if (mouseX >100 && mouseX <200 && mouseY >100 && mouseY <200) {
      println("LED4 Clicked");
      if (button4 == ON) {
        button4 = OFF;
      }
      else if (button4 == OFF) {
        button4  = ON;
      }
      sendMessage(LED_TAG, LED4, button4);
    }
}


void sendMessage(char tag, int led, int button)
{
  myPort.write(HEADER);
  myPort.write(tag);
  myPort.write(led);  // lsb 1,2,3,4
  myPort.write(button);  // lsb 0,1
  
  
}

void serialEvent(Serial p)
{
  String message = myPort.readStringUntil(10);  
  if(message != null)
  {
    print("Received: ");
    println(message);
    int []data = int(split(message, ','));
    
    print(data[0]);
    print(",");
    println(data[1]);
    
    if (data[0] == 1) {
      if (data[1] == 1)
        button1 = ON;
      else
        button1 = OFF;
    }
     if (data[0] == 2) {
      if (data[1] == 1)
        button2 = ON;
      else
        button2 = OFF;
    }
     if (data[0] == 3) {
      if (data[1] == 1)
        button3 = ON;
      else
        button3 = OFF;
    }
     if (data[0] == 4) {
      if (data[1] == 1)
        button4 = ON;
      else
        button4 = OFF;
    }
  }
}



