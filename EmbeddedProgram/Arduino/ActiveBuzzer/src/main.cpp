#include <Arduino.h>

int speakerPin = A0;//Yellow wire to A0

void setup()
{
  pinMode(speakerPin, OUTPUT);//pinmode setup
}

void loop()
{
  Serial.println("Begin loop:");
  analogWrite(speakerPin, 1000);
  delay(1000);
  noTone(speakerPin);
  delay(1000);
  analogWrite(speakerPin, 400);
}
