#include <secrets.h>

#include <wifi.h>
#include <ntp.h>
#include <mqtt.h>

int readInterval = 0;

void checkWiFiThenMQTT(void)
{
  connectToWiFi("Checking WiFi");
  connectToMqtt();
}

void setup() {
  Serial.begin(115200);
  delay(5000);
  Serial.println();
  Serial.println();

  setupWifi();
  NTPConnect();
  setupSSL();
  setupMQTT();

  connectToMqtt();
}

void loop() {
  now = time(nullptr);
  if (!client.connected()) {
    checkWiFiThenMQTT();
  } else {
    client.loop();
    delay(200);

    // TODO: implementar mensagem de status
    // TODO: implementar deep sleep
    //if (millis() - lastMillis > readInterval) {
      //lastMillis = millis();
      //long data = getScale();
      //sendData(data);
      //readInterval = 18e5;
    //}
  }
}
