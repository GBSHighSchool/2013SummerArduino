import processing.serial.*;

Serial myArduinoPort;

final Byte   LF = 10; //line feed

//twitter Oauth에서 설정한 값 입력
final String OAUTH_CONSUMER_KEY = "";
final String OAUTH_CONSUMER_SECRET = "";
final String OAUTH_ACCESS_TOKEN = "-";
final String OAUTH_ACCESS_TOKEN_SECRET = "";


final float  MAX_TEMPERATURE_FOR_MESSAGE_SENDING = 32.0;
float temperature = 0.0;
PFont myFont; 
int i = 0;
void setup() {
  size(500,100);
  background(255);
  
  

  myFont = createFont("Calibri Bold",32); 
  textFont(myFont); 

  println(Serial.list()); 
  myArduinoPort = new Serial(this, Serial.list()[0], 9600);
  myArduinoPort.bufferUntil(LF);
}


void draw() {
  String windowMessage = "=> Temperature: ";
  background(255); 
  
  fill(0); 
  text("Arduino + Processing + Twitter", 20,40);
  
  fill(0, 0, 255); 
  windowMessage = windowMessage + temperature + " [C]";
  text(windowMessage, 20,80);
  delay(3000);
  temperature += 0.1;
  sendMessage(temperature);
} 


void serialEvent(Serial port) {
  final String serialTexData = port.readStringUntil(LF);
  if (serialTexData != null) {
    final String[] textData = split(trim(serialTexData), ' ');
    if (textData.length == 2)
    {
      if( (textData[1].equals("C") ) || (textData[1].equals("c")) )
      {
        temperature = float(textData[0]); //String to float
        println(temperature);
        int nextDataSendingWaitingTime_ms = 5 * 1000; //5 second
        if (temperature > MAX_TEMPERATURE_FOR_MESSAGE_SENDING) {
          sendMessage(temperature);
          nextDataSendingWaitingTime_ms =  10 * 1000; //10 second
        }
        try {
          Thread.sleep(nextDataSendingWaitingTime_ms);
        }
        catch(InterruptedException ignoreMe) {}
      }
    }
  }
}


void sendMessage(float temperature) {
  
  int s = second();  // Values from 0 - 59
  int m = minute();  // Values from 0 - 59
  int h = hour();    // Values from 0 - 23
  int d = day();    // Values from 1 - 31
  int mon = month();  // Values from 1 - 12
  int y = year();   // 2003, 2004, 2005, etc.
  
  String  twitterMessage = "[Processing] Temperature: ";
  
  twitterMessage = twitterMessage + temperature + " C";
  
  // To remove duplication error
  twitterMessage = twitterMessage+". Date: " + y +"-" + mon + "-" + d ;
  twitterMessage = twitterMessage+". Time: " + h + ":" + m + ":" + s ;
  
  // twitter OAuth 
  ConfigurationBuilder cb = new ConfigurationBuilder();
  cb.setOAuthConsumerKey(OAUTH_CONSUMER_KEY);
  cb.setOAuthConsumerSecret(OAUTH_CONSUMER_SECRET);
  cb.setOAuthAccessToken(OAUTH_ACCESS_TOKEN);
  cb.setOAuthAccessTokenSecret(OAUTH_ACCESS_TOKEN_SECRET);
  
  TwitterFactory tf = new TwitterFactory(cb.build());
  Twitter twitter = tf.getInstance();

  try {
    Status status = twitter.updateStatus(twitterMessage);
    println("Successfully updated the status to [" + status.getText() + "].");
  }
  catch (TwitterException e) {
    e.printStackTrace();
  }
}
