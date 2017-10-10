#include <SoftwareSerial.h>

// pin 0 is to receive from the controller and does not need to be connected
// pin 1 needs to be connect to the serial data input of the board
SoftwareSerial pololu(0, 1);
  
#define NUM_OF_VALUES 4
String incomingString ="";
int incomingValues[NUM_OF_VALUES];

#define SERVO0 0
#define SERVO1 1
#define SERVO2 2
#define SERVO3 3
  
#define MIN_SERVO0 70
#define MAX_SERVO0 200

#define MIN_SERVO1 215
#define MAX_SERVO1 70

#define MIN_SERVO2 205
#define MAX_SERVO2 65

#define MIN_SERVO3 30
#define MAX_SERVO3 165


void setup() {
  Serial.begin(9600);
  pololu.begin(9600);

}
  
void loop() {

  if (Serial.available() > 0)
  {
    incomingString = Serial.readStringUntil('\n');
    split(incomingString, incomingValues, NUM_OF_VALUES);
  }

  move(SERVO0, incomingValues[0]);
  move(SERVO1, incomingValues[1]);
  move(SERVO2, incomingValues[2]);
  move(SERVO3, incomingValues[3]);

}

void split(String inputString, int returnData[], int numOfValues)
{
  int index = 0;
  int lastPos = 0;
  
  for(int i=0; i<inputString.length();i++)
  {
    if(inputString.charAt(i) == ',' && index < numOfValues)
    {
      String tempStr = inputString.substring(lastPos,i-1);
      returnData[index] = tempStr.toInt();
      index++;
      lastPos = i+1;
    }
  }
}

//translates values for each sensor
void move (int servo, int pos){
  float x;
  if(servo == 0){
    x = map(pos, 0, 100, MIN_SERVO0, MAX_SERVO0);
    setPosition(servo, x);
  } else if (servo == 1){
    x = map(pos, 0, 100, MIN_SERVO1, MAX_SERVO1);
    setPosition(servo, x);
  } else if (servo == 2){
    x = map(pos, 0, 100, MIN_SERVO2, MAX_SERVO2);
    setPosition(servo, x);
  } else if (servo == 3){
    x = map(pos, 0, 100, MIN_SERVO3, MAX_SERVO3);
    setPosition(servo, x);
  }
}

void setPosition(int servo, int pos) {
  pololu.write(0xFF); // write synchronization flag
  pololu.write(servo + 8); // write servo number (without +8 == 90°)
  pololu.write(pos); // write position
}
