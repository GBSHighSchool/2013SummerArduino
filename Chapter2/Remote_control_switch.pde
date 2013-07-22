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

// Part 2. Temp Sensor control
public int button_MOTOR_LEFT = 0;
public int button_MOTOR_RIGHT = 0;
public static final char DC_MOTOR_TAG = 'D';
public static int MOTOR_LEFT = 1;
public static int MOTOR_RIGHT = 0;

// Part 3. Temp Sensor control
public static final char TEMP_TAG = 'T';
public static final short LF = 10;

int value2;
int value3;
int value_sum;

String [] data;

float voltage;
float temperature;

// Part 4. Reserved
public static int MOTOR_ON = 2;
public int button_reserved = 0;

        
void setup() {
  size (200,475);
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

  line(0,325,200,325);
  line(0,350,200,350);
  line(100,225,100,325);
  line(100,350,100,450);
  line(0,450,200,450);

 
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

// Paert 2. DC Motor control
  text("LEFT",50,320);
  text("RIGHT",150,320);
  text("DC Motor Control",100,345);

// Part 4. Reserved
  text("ON/OFF",150,445);
  text("Temperature Sensor Control",100,470);


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


// Part 2. DC Motor control
  if (button_MOTOR_LEFT == ON) {
    fill(255,255,0);  // WHITE
    beginShape(TRIANGLES);
    vertex(25,275);
    vertex(75,250);
    vertex(75,300);
    endShape(CLOSE);
  } else {
    fill(125,125,125);  // GRAY
    beginShape(TRIANGLES);
    vertex(25,275);
    vertex(75,250);
    vertex(75,300);
    endShape(CLOSE);
  }

  if (button_MOTOR_RIGHT == ON) {
    fill(255,255,0);  // WHITE
    beginShape(TRIANGLES);
    vertex(175,275);
    vertex(125,250);
    vertex(125,300);
    endShape(CLOSE);
   
  } else {
    fill(125,125,125);  // GRAY
    beginShape(TRIANGLES);
    vertex(175,275);
    vertex(125,250);
    vertex(125,300);
    endShape(CLOSE);
  }  


// Part 3. Temperature control
  fill(255,0,0);  // RED
  text("Temperature:",50,375);
  text(temperature,50,395);
  fill(value_sum);
  int temp_graph = int(temperature);
  rect(0, 400, value_sum/5, 25);


// Part 4. Reserved
  fill(0); // inner of of polygon, 0: black, 255: white

  if (button_reserved == ON) {
    fill(0,255,255);  // 
    rect(125,375,50,50);
  } else {
    fill(125,125,125);  // GRAY
    rect(125,375,50,50);
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


// Part 2. DC Motor control
    if (mouseX <100 && mouseY >225 && mouseY <325) {
      if (button_MOTOR_LEFT == ON) {
        button_MOTOR_LEFT = OFF;
      }
      else if (button_MOTOR_LEFT == OFF) {
        button_MOTOR_LEFT = ON;
      }
      if (button_MOTOR_RIGHT == ON) {
        button_MOTOR_RIGHT = OFF;
      }
      
      sendMessage(DC_MOTOR_TAG, MOTOR_LEFT, button_MOTOR_LEFT);
    }
    
    if (mouseX >100 && mouseX <200 && mouseY >225 && mouseY <325) {
      if (button_MOTOR_RIGHT == ON) {
        button_MOTOR_RIGHT = OFF;
      }
      else if (button_MOTOR_RIGHT == OFF) {
        button_MOTOR_RIGHT = ON;
      }
      if (button_MOTOR_LEFT == ON) {
        button_MOTOR_LEFT = OFF;
      }
      sendMessage(DC_MOTOR_TAG, MOTOR_RIGHT, button_MOTOR_RIGHT);
    }


// Part 4. Reserved
    if (mouseX >100 && mouseX <200 && mouseY >350 && mouseY <450) {
      if (button_reserved == ON) {
        button_reserved = OFF;
      }
      else if (button_reserved == OFF) {
        button_reserved = ON;
      }
      //sendMessage(RESERVED_TAG, RESERVED_ON, button_reserved);
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


// Part 3. Temperature Sensor control
void serialEvent(Serial p)
{
  String message = myPort.readStringUntil(LF);  
  if(message != null)
  {
    print(message);
    String [] data = message.split(",");
    if(data[0].charAt(0) == HEADER && data.length > 3)
    {
      if(data[1].charAt(0) == TEMP_TAG)
      {
        int [] list = int(split(message, ','));
        println("list[2] =" + list[2]);
        println("list[3] =" + list[3]);
        value2 = list[2];
        value3 = list[3];
        value_sum = list[2] + list[3]*256;
        println("value_sum =" + value_sum);
        voltage = (value_sum/1024.0) * 5.0;
        println("voltage =" + voltage);
        temperature = (voltage - .5) * 100;
        println("temperature =" + temperature);
      }
    }  
  }
}


