#include <Wire.h>
#include <SPI.h>
#include <Adafruit_LSM9DS1.h>
#include <Adafruit_Sensor.h> 
#define BUZZERPIN A0
Adafruit_LSM9DS1 lsm = Adafruit_LSM9DS1();

static int armed = 1;

void setupSensor()
{
  lsm.setupAccel(lsm.LSM9DS1_ACCELRANGE_2G);
}


void setup() 
{
  Serial.begin(115200);

  while (!Serial) {
    delay(1);
  }
  
 
  if (!lsm.begin())
  {
    Serial.println("Oops ... unable to initialize the LSM9DS1. Check your wiring!");
    while (1);
  }
  Serial.println("Found LSM9DS1 9DOF");
  setupSensor();
}

void loop() 
{ 
  int foo = Serial.read();
  if(foo == 50)
  {
    armed = 0;
    foo = 69;
  }
  if(foo == 49)
  {
    armed = 1;
    foo = 69;
  }
  if(armed == 1)
  {
      sensors_event_t a;
    
      lsm.getEvent(&a,NULL,NULL,NULL);
    
      float sumOfComp = pow(a.acceleration.x,2) + pow(a.acceleration.y,2) + pow(a.acceleration.z,2);
      float magnitude = pow(sumOfComp,0.5);
      if(magnitude > 20)//tgus is a good acceleration magnitude to identify a bike as stolen based from my test
      {
        Serial.println(armed ? "armed" : "not armed");
        Serial.write(0b1);
        analogWrite(BUZZERPIN,0);
        for(int i = 0; i<50; i++)
        {
          tone(BUZZERPIN,500);
          delay(2);
          noTone(BUZZERPIN);
          delay(20);
        }
        analogWrite(BUZZERPIN,1024);
      }
    
      //Serial.write(0x0);
      delay(20);
  }
}