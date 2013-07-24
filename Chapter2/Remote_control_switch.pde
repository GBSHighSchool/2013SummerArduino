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
public static int  RED = 1;
public static int  GREEN = 2;
public static int  BLUE = 3;
public static int  WHITE = 4;

public static int  ON = 1;
public static int  OFF = 0;

void setup() {
  size (200,225);
  f = createFont("Georgia-Bold", 20, true); // font creating for text

  String portName = Serial.list()[portIndex];
  myPort = new Serial(this, portName, 9600);
}

void draw() {
  background(255);
 
// Structure Setup
  stroke(0);  // outer line of polygon, 0: black, 255: white
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
  text("Red",50,95);
  text("Green",150,95);
  text("Blue",50,195);
  text("White",150,195);
  text("LED Control",100,220);

// Button Setup

// Part 1. LED control
  if (button1 == ON) {
    fill(255,0,0);   // Red
    ellipse(50,50,50,50);
  } else {
    fill(125,125,125);
    ellipse(50,50,50,50);
  }
  if (button2 == ON) {
    fill(0,255,0);  // Green
    ellipse(150,50,50,50);
  } else {
    fill(125,125,125);
    ellipse(150,50,50,50);
  } 
  if (button3 == ON) {
    fill(0,0,255);  // Blue
    ellipse(50,150,50,50);
  } else {
    fill(125,125,125);
    ellipse(50,150,50,50);  
  }
  if (button4 == ON) {
    fill(255,255,255);  // WHITE
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
      if (button1 == ON) {
        button1 = OFF;
      }
      else if (button1 == OFF) {
        button1 = ON;
      }
      sendMessage(LED_TAG, RED, button1);
    }
    if (mouseX >100 && mouseX <200 && mouseY <100) {
      if (button2 == ON) {
        button2 = OFF;
      }
      else if (button2 == OFF) {
        button2 = ON;
      }
      sendMessage(LED_TAG, GREEN, button2);
    }
    if (mouseX <100 && mouseY >100 && mouseY <200) {
      if (button3 == ON) {
        button3 = OFF;
      }
      else if (button3 == OFF) {
        button3 = ON;
      }
      sendMessage(LED_TAG, BLUE, button3);
    }
    if (mouseX >100 && mouseX <200 && mouseY >100 && mouseY <200) {
      if (button4 == ON) {
        button4 = OFF;
      }
      else if (button4 == OFF) {
        button4  = ON;
      }
      sendMessage(LED_TAG, WHITE, button4);
    }
}


void sendMessage(char tag, int led, int button)
{
  myPort.write(HEADER);
  myPort.write(tag);
  myPort.write((char)(0x00));  // msb
  myPort.write((char)(led & 0xff));  // lsb
  myPort.write((char)(0x00));  // msb
  myPort.write((char)(button & 0xff));  // lsb
}
