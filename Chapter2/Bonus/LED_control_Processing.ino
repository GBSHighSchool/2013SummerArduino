
const char HEADER = 'H';
const int TOTAL_BYTES = 4;

const char LED_TAG = 'L';

const int LED1 = 1;
const int LED2 = 2;
const int LED3 = 3;
const int LED4 = 4;

const int ON = 1;
const int OFF = 0;
 
const int LED1_pin = 2;
const int LED2_pin = 3;
const int LED3_pin = 4;
const int LED4_pin = 5;

int led_port = 0;
int button_state = 0;
int randNumber;


void setup() {
  Serial.begin(9600);
  pinMode(LED1_pin,OUTPUT);
  pinMode(LED2_pin,OUTPUT);
  pinMode(LED3_pin,OUTPUT);
  pinMode(LED4_pin,OUTPUT);

  digitalWrite(LED1_pin, HIGH);
  digitalWrite(LED2_pin, HIGH);
  digitalWrite(LED3_pin, HIGH);
  digitalWrite(LED4_pin, HIGH);
  delay(100);
  digitalWrite(LED1_pin, LOW);
  digitalWrite(LED2_pin, LOW);
  digitalWrite(LED3_pin, LOW);
  digitalWrite(LED4_pin, LOW);
  
  randomSeed(analogRead(0));
  
  
}

void loop() 
{
    randNumber = random(2, 6);
    digitalWrite(randNumber, HIGH);
    
    Serial.print(randNumber-1);
    Serial.print(",");
    Serial.print(1,DEC);
    Serial.print(",");
    Serial.println();
    delay(100);
    digitalWrite(randNumber, LOW);
    Serial.print(randNumber-1);
    Serial.print(",");
    Serial.print(0,DEC);
    Serial.print(",");
    Serial.println();
    delay(100);
   
}
