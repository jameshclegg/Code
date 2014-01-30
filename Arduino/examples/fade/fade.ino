/*
Fade

Fade an LED on pin 3 (PWM) using analogWrite().
Tutorial at arduino.cc/en/Tutorial/Fade

James Clegg. 24.01.14
*/

int led = 3;  // LED pin
int bness = 0;
int fadeD = 5;
int tDelay = 15; //delay in ms

// setup runs when you press reset
void setup() {
 pinMode( led, OUTPUT ); 
}

void loop() {
 
 if (bness > 255) {
  bness = 255;
 }

 if (bness < 0) {
  bness = 0;
 } 
  
 analogWrite( led, bness ); 
  
 bness = bness + fadeD;
 
 if (bness == 0 || bness == 255) {
  fadeD = -fadeD; 
 }
 
 delay( tDelay );
}
