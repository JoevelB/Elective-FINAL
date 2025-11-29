#include <WiFi.h>
#include <PubSubClient.h>
#include <SPI.h>
#include <MFRC522.h>

// --- CONFIGURATION ---
const char* ssid = "Xiaomi11T";          // YOUR WIFI NAME
const char* password = "12345678";    // YOUR WIFI PASSWORD
const char* mqtt_server = "10.213.20.241";     // YOUR LAPTOP IP

// --- PINS ---
#define SS_PIN  32
#define RST_PIN 27

const char* topic_publish = "RFID_INPUT"; 

WiFiClient espClient;
PubSubClient client(espClient);
MFRC522 rfid(SS_PIN, RST_PIN);

// Function Prototypes (for the compiler)
void setup_wifi();
void reconnect();
void callback(char* topic, byte* message, unsigned int length); 

void setup() {
  Serial.begin(115200);
  delay(1000); 
  Serial.println("\n--- RFID SCANNER STARTING ---");

  Serial.println("Initializing SPI and RFID...");
  SPI.begin(); 
  rfid.PCD_Init(); 
  Serial.println("RFID Ready.");
  
  Serial.println("Initializing Network...");
  setup_wifi();
  
  client.setServer(mqtt_server, 1883); 
  client.setCallback(callback);
  Serial.println("Setup Complete.");
}

void setup_wifi() {
  delay(10);
  Serial.print("Connecting to WiFi");
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println(" Connected!");
}

// --- MESSAGE HANDLER (Scanner receives its status reply) ---
void callback(char* topic, byte* message, unsigned int length) {
  String responseMsg = "";
  for (int i = 0; i < length; i++) {
    responseMsg += (char)message[i];
  }
  
  if (responseMsg.indexOf(',') != -1) {
    String status = responseMsg.substring(responseMsg.indexOf(',') + 1); 
    status.trim();
    
    Serial.print("\n--- SERVER STATUS: ");

    if (status == "1") {
      Serial.println("ACCESS GRANTED (1)");
    } else if (status == "0") {
      Serial.println("ACCESS REVOKED (0)");
    } else {
      Serial.println("RFID NOT FOUND ---");
    }
    Serial.println("--- READY FOR NEW SCAN ---\n");
  }
}

void reconnect() {
  while (!client.connected()) {
    Serial.print("Attempting MQTT connection...");
    if (client.connect("ESP32Scanner")) {
      Serial.println("Connected.");
      client.subscribe(topic_publish); 
    } else {
      delay(5000);
    }
  }
}

void loop() {
  if (!client.connected()) reconnect();
  client.loop(); 

  // --- SCANNER LOGIC ---
  if (!rfid.PICC_IsNewCardPresent()) return;
  if (!rfid.PICC_ReadCardSerial()) return;

  String uidString = "";
  for (byte i = 0; i < rfid.uid.size; i++) {
    uidString += String(rfid.uid.uidByte[i] < 0x10 ? "0" : "");
    uidString += String(rfid.uid.uidByte[i], HEX);
  }
  uidString.toUpperCase();

  String payload = uidString; 

  Serial.print("Sending Request: ");
  Serial.println(payload);
  client.publish(topic_publish, payload.c_str()); 

  rfid.PICC_HaltA();
  rfid.PCD_StopCrypto1();
  delay(2000); 
}