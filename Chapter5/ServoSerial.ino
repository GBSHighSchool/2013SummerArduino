
#include <Servo.h>

Servo myservo;
int val;
void setup() {
  Serial.begin(9600);
   myservo.attach(2);
}

void loop() 
{
  if(Serial.available()) {
    
  }
}