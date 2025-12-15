#include <WiFi.h>
#include <PubSubClient.h>

const char* ssid = "Xiaomi11T"; 
const char* password = "12345678"; 
const char* mqtt_server = "10.213.20.241";  

#define RELAY_PIN 13
const char* topic_subscribe = "RFID_LOGIN"; 

WiFiClient espClient;
PubSubClient client(espClient);


void setup_wifi();
void reconnect();
void callback(char* topic, byte* message, unsigned int length); 

void setup() {
 Serial.begin(115200);
 pinMode(RELAY_PIN, OUTPUT);
 digitalWrite(RELAY_PIN, LOW);
 setup_wifi();
 client.setServer(mqtt_server, 1883);
 client.setCallback(callback);
}

void setup_wifi() {
 delay(10);
 WiFi.begin(ssid, password);
 while (WiFi.status() != WL_CONNECTED) delay(500);
 Serial.println("Connected to WiFi!");
}

void callback(char* topic, byte* message, unsigned int length) {
 String msg = "";
 for (int i = 0; i < length; i++) {
msg += (char)message[i];
 }
 Serial.print("Received: ");
 Serial.println(msg);

 int commaIndex = msg.indexOf(',');
 
 if (commaIndex != -1) {
String status = msg.substring(commaIndex + 1); 
status.trim(); 

if (status == "1") {
 digitalWrite(RELAY_PIN, HIGH);
 Serial.println(" -> RELAY ON");
} 
else if (status == "0") {
 digitalWrite(RELAY_PIN, LOW);
 Serial.println(" -> RELAY OFF");
} else {
      Serial.println(" -> Ignoring UNREGISTERED command.");
    }
 } 
 else {
Serial.println(" -> Ignoring Request (Raw UID)");
 }
}

void reconnect() {
 while (!client.connected()) {
    Serial.print("Attempting MQTT connection...");
if (client.connect("ESP32Relay")) {
      Serial.println("Connected!");
 client.subscribe(topic_subscribe); 
} else {
      Serial.print("Failed, RC=");
      Serial.print(client.state());
      Serial.println(" trying again in 5s");
 delay(5000);
}
 }
}

void loop() {
 if (!client.connected()) reconnect();
 client.loop();
}