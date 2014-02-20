/*

  TESTREADWRITESPEED
  
  Loop round reading and writing and see how long it takes...
  
  20th February 2014. JHC.
  
*/

byte slmInput = 13;
byte LEDOutput = 7;
byte slmState;

void setup()
{
  pinMode( slmInput, INPUT );
  pinMode( LEDOutput, OUTPUT );
}

void loop() 
{
  byte stateNow = 1;
  
  //for (int ii = 0; ii < 10; ii++)
  //{
    digitalWrite( LEDOutput, LOW );
    // do a digital read, but it doesn't matter what it is
    slmState = digitalRead( slmInput );
    digitalWrite( LEDOutput, HIGH );
    //stateNow = !stateNow;
    //delayMicroseconds( 10 );
  //}
}
