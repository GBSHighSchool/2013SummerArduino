
/*
	초음파 센서
	NT-TS601
	T쪽이 GND
	중앙이 GND
	오른쪽이 Signal
*/

const int pingPin = 7;

void setup() 
{
        Serial.begin(9600);
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
        duration = pulseIn(pingPin, HIGH);

        //받아진 펄스입력은 해당되는 값의 범위로 바꾸어줌.
        cm = microsecondsToCentimeters(duration);

        //값을 시리얼 모니터창으로 출력
        Serial.print(cm);
        Serial.print("cm");
        Serial.println();

        delay(100);
}

long microsecondsToCentimeters(long microseconds)
{
        // The speed of sound is 340 m/s or 29 microseconds per centimeter.
        // The ping travels out and back, so to find the distance of the
        // object we take half of the distance travelled.
        return microseconds / 29 / 2;
}

