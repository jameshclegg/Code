/*

  SLMSYNCTEST_LEDSWITCH
  
  Read the value of the SLM LED drive pin and then switch
  an LED on and off in sync with this.
  
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
  slmState = digitalRead( slmInput );
  
  digitalWrite( LEDOutput, slmState );
  
  
}
