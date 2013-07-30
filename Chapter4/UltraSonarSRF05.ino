/*
	초음파 센서
	SRF05
*/

int val;
void setup() {
  Serial.begin(9600);
  pinMode(7, OUTPUT); //Trigger  tx
  pinMode(6, INPUT);  //Echo     rx
  
}

void loop()
{
  digitalWrite(7, HIGH);
  delayMicroseconds(10);
  digitalWrite(7, LOW);
  val=pulseIn(6,HIGH)/58;
  Serial.print("Distance(cm) = ");
  Serial.println(val);
 }
