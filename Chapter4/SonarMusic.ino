#include "pitches.h"
#include <firFilter.h>

firFilter Filter;

int value;
int filtered;

const int pingPin = 7;

int gbfiltered;

int melody[] = {
 NOTE_C3, NOTE_D3, NOTE_E3, NOTE_F3, NOTE_G3, NOTE_A3, NOTE_B3, 
 NOTE_C4, NOTE_D4, NOTE_E4, NOTE_F4, NOTE_G4, NOTE_A4, NOTE_B4,
 NOTE_C5, NOTE_D5, NOTE_E5, NOTE_F5, NOTE_G5, NOTE_A5, NOTE_B5,
};

void setup() 
{
        Serial.begin(9600);
        Filter.begin();
}

void loop()
{

        long duration, inches, cm;

        //초음파센서에 HIGH 신호의 트리커 신호 보내기.
        // HIGH 신호를 보내기 전 깨끗하게 하기 위해 LOW 를 2 마이크로세컨드 동안 보냄.
        pinMode(pingPin, OUTPUT);
        digitalWrite(pingPin, LOW);
        delayMicroseconds(2);
        digitalWrite(pingPin, HIGH);
        delayMicroseconds(5);
        digitalWrite(pingPin, LOW);

        //출력으로 트리거 신호를 보냈던 핀을 입력으로 바꾸어줌. 그리고 펄스입력을 받음.
        pinMode(pingPin, INPUT);
        duration = pulseIn(pingPin, HIGH, 10000);

        //받아진 펄스입력은 해당되는 값의 범위로 바꾸어줌.
        cm = microsecondsToCentimeters(duration);
        filtered= Filter.run(cm);
        filtered = map(filtered,0,100,0,22);
        filtered = constrain(filtered,0,22);
        if(filtered!=gbfiltered)
        {
                gbfiltered = filtered;
                tone(9, melody[filtered], 100);// pin, frequency, duration
        }
      
        
        delay(10);
}

long microsecondsToCentimeters(long microseconds)
{
        // The speed of sound is 340 m/s or 29 microseconds per centimeter.
        // The ping travels out and back, so to find the distance of the
        // object we take half of the distance travelled.
        return microseconds / 29 / 2;
}
