#include <Wire.h>
#include <BH1750.h>
#include <FirebaseESP32.h>
#include <DHT.h>
#include <WiFi.h>
#include <ArduinoJson.h>
#include <SPI.h>

#define DHTPIN 18
#define DHTTYPE DHT11
#define MOISTURE_SENSOR_ANALOG_PIN 35
#define LIGHT_SENSOR_ANALOG_PIN 34
#define LED_PIN 4

#define DATABASE_URL "your-database-url" //<databaseName>.firebaseio.com or <databaseName>.<region>.firebasedatabase.app
#define FIREBASE_HOST "your-firebase-host" // Đảm bảo có https://
#define FIREBASE_AUTH "your-firebase-auth"


#define WIFI_SSID "your-wifi-name"
#define WIFI_PASSWORD "your-wifi-password"

FirebaseConfig config;
FirebaseAuth auth;

DHT dht(DHTPIN, DHTTYPE);
FirebaseData fbdo;

int threshold_moisture = 25; // Ngưỡng độ ẩm đất

void setup() {
  Serial.begin(9600);
  Wire.begin();
  pinMode(LED_PIN, OUTPUT);
  
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("\nConnected to WiFi");

  config.database_url = DATABASE_URL;

  config.signer.test_mode = true;
  
  Firebase.reconnectWiFi(true);
  fbdo.setBSSLBufferSize(4096 , 1024 );
  
  Firebase.begin(&config, &auth);
  dht.begin();
}

void loop() {
  float h = dht.readHumidity();
  float t = dht.readTemperature();
  int bom = 0;
  if (isnan(h) || isnan(t)) {
    Serial.println("Failed to read from DHT sensor!");
    return;
  }

  int doam_dat = map(analogRead(MOISTURE_SENSOR_ANALOG_PIN), 0, 4095, 100, 0);
  uint16_t lux = analogRead(LIGHT_SENSOR_ANALOG_PIN);

  Serial.print("Humidity: ");
  Serial.print(h);
  Serial.println("%");

  Serial.print("Temperature: ");
  Serial.print(t);
  Serial.println("°C");

  Serial.print("Light intensity: ");
  Serial.print(lux);
  Serial.println(" lux");

  Serial.print("Soil Moisture: ");
  Serial.print(doam_dat);
  Serial.println("%");

  // Gửi giá trị nhiệt độ
Firebase.setFloat(fbdo, "/TT_nhung/Nhietdo", t);
Firebase.setFloat(fbdo, "/TT_nhung/DoamKK", h);
Firebase.setInt(fbdo, "/TT_nhung/Anhsang", lux);
Firebase.setInt(fbdo, "/TT_nhung/Doamdat", doam_dat);

if (doam_dat > threshold_moisture) {
    digitalWrite(LED_PIN, HIGH);
    Serial.println("LED is ON");
    Serial.println("============================");
    bom = 1; // Giả sử bom = 1 là bật
    Firebase.setInt(fbdo, "/TT_nhung/bom", bom);

} else {
    digitalWrite(LED_PIN, LOW);
    Serial.println("LED is OFF");
    Serial.println("============================");
    bom = 0; // Giả sử bom = 0 là tắt
    Firebase.setInt(fbdo, "/TT_nhung/bom", bom);
}


  delay(10000);
}
