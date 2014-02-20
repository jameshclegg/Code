/*

  SLMSYNCTEST1
  
  Eventually I hope this will read the digital state of the SLM LED
  drive output and use that to switch an LED on and off. This is 
  the first stage in getting the sync between SLM and scanning
  working.
    
  At the moment this just reads the state of the pin numReadings times
  and then prints those values to the serial port monitor.
  Then it stops.
  
  20th February 2013. JHC.
*/


const int numReadings = 400;
byte readings[numReadings];      // the readings from the analog input
int readingTimes[numReadings];
int index = 0;                  // the index of the current reading
int slmInput = 13;

void setup()
{
  // initialize serial communication with computer:
  Serial.begin(9600);                   
  // initialize all the readings to 0: 
  for (int thisReading = 0; thisReading < numReadings; thisReading++)
  {
    readings[thisReading] = 0;
    readingTimes[thisReading] = 0;
  }
  // make the pushbutton's pin an input:
  pinMode( slmInput, INPUT );    
}

void loop() {
   
  // read from the sensor:  
  readings[index] = (byte) digitalRead( slmInput );
  readingTimes[index] = (int) micros();
      
  // advance to the next position in the array:  
  index = index + 1;                    

  // if we're at the end of the array...
  if (index >= numReadings)
{   
    int ii;
    for (ii = 0; ii < numReadings; ii = ii++) 
    {
      Serial.print( readingTimes[ii] );
      Serial.print( ',' );
      Serial.println( readings[ii] );
    }
    while (true);
}
         
}


