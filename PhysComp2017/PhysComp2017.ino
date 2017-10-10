#include <SoftwareSerial.h>
  
// pin 0 is to receive from the controller and does not need to be connected
// pin 1 needs to be connect to the serial data input of the board
SoftwareSerial pololu(0, 1);
  
int pos = 0;
  
void setup() {
  Serial.begin(9600);
  pololu.begin(9600);

}
  
void loop() {
  Serial.println(pos);
  
  // set position for eight servos simultaneously
  setPosition(0, pos);
  setPosition(1, pos);
  setPosition(2, pos);
  setPosition(3, pos);
  setPosition(4, pos);
    

  if(pos == 0) {
    pos = 254;
  } else {
    pos = 0;
  }
  
  delay(1200);

}
  
void setPosition(int servo, int pos) {
  // if (pos > 254) {
  //   pos = 254;
  // } else if(pos < 0){
  //   pos = 0;  
  // }
  pololu.write(0xFF); // write synchronization flag
  pololu.write(servo + 8); // write servo number (without +8 == 90°)
  pololu.write(pos); // write position
}