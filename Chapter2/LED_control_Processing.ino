
const char HEADER = 'H';
const int TOTAL_BYTES = 6;

const char LED_TAG = 'L';

const int RED = 1;
const int GREEN = 2;
const int BLUE = 3;
const int WHITE = 4;

const int ON = 1;
const int OFF = 0;
 
const int red_pin = 2;
const int green_pin = 3;
const int blue_pin = 4;
const int white_pin = 5;

int led_port = 0;
int button_state = 0;


void setup() {
  Serial.begin(9600);
  pinMode(red_pin,OUTPUT);
  pinMode(green_pin,OUTPUT);
  pinMode(blue_pin,OUTPUT);
  pinMode(white_pin,OUTPUT);

  digitalWrite(red_pin, HIGH);
  digitalWrite(green_pin, HIGH);
  digitalWrite(blue_pin, HIGH);
  digitalWrite(white_pin, HIGH);
  delay(100);
  digitalWrite(red_pin, LOW);
  digitalWrite(green_pin, LOW);
  digitalWrite(blue_pin, LOW);
  digitalWrite(white_pin, LOW);
}

void loop() 
{
  if(Serial.available() >= TOTAL_BYTES)
  {
    if(Serial.read() == HEADER)
     {
       char tag = Serial.read();
       if(tag == LED_TAG)
       {
         int led = Serial.read() * 256;
         led = led + Serial.read();
         int button = Serial.read() * 256;
         button = button + Serial.read();
         if(led == RED && button == ON)
         {
           led_port = red_pin;
           button_state = HIGH;
         }
         else if(led == RED && button == OFF)
         {
           led_port = red_pin;
           button_state = LOW;
         }
         else if(led == GREEN && button == ON)
         {
           led_port = green_pin;
           button_state = HIGH;
         }
         else if(led == GREEN && button == OFF)
         {
           led_port = green_pin;
           button_state = LOW;
         }
         else if(led == BLUE && button == ON)
         {
           led_port = blue_pin;
           button_state = HIGH;
         }
         else if(led == BLUE && button == OFF)
         {
           led_port = blue_pin;
           button_state = LOW;
         }
         else if(led == WHITE && button == ON)
         {
           led_port = white_pin;
           button_state = HIGH;
         }
         else if(led == WHITE && button == OFF)
         {
           led_port = white_pin;
           button_state = LOW;
         }
         digitalWrite(led_port, button_state);
       } // (tag == LED_TAG)
     }
  }
  
  delay(100);
  
}

