<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use PhpMqtt\Client\Facades\MQTT;
use App\Models\RfidRegistered;
use App\Models\RfidLog;

class ListenToMqtt extends Command
{
    protected $signature = 'mqtt:listen';
    protected $description = 'Listen to ESP32 MQTT Topic';

    public function handle()
    {
        $this->info("System Ready. Listening on 'RFID_INPUT'...");

        // CRITICAL: Subscribe to the private input channel from the Scanner
        MQTT::connection()->subscribe('RFID_INPUT', function (string $topic, string $message) {
            
            try {
                $rfid = trim($message); 
                $this->info("Processing Request: $rfid");

                // --- PROCESSING LOGIC (The Brain) ---
                $registeredCard = RfidRegistered::where('uid', $rfid)->first();
                $responseStatus = "";
                $dbStatus = "";

                if (!$registeredCard) {
                    // UNREGISTERED (Public log is skipped, but DB records history)
                    $responseStatus = "RFID NOT FOUND"; 
                    $dbStatus = null; // Saves NULL to database
                    $this->error("[$rfid] -> RFID NOT FOUND");
                } else {
                    // REGISTERED (Execute Toggle Logic)
                    $currentStatus = $registeredCard->status;
                    $newStatus = ($currentStatus == '1') ? '0' : '1';

                    $registeredCard->update(['status' => $newStatus]);
                    $responseStatus = $newStatus; // '1' or '0'
                    $dbStatus = $newStatus;
                    
                    //$this->info("[$rfid] -> Status Toggled to: $newStatus");
                }

                // 1. SAVE HISTORY LOG
                RfidLog::create([
                    'rfid' => $rfid,
                    'status' => $dbStatus, 
                    'time_log' => now()->format('m/d/Y H:i'),
                ]);

                // 2. CONDITIONAL PUBLISH FEEDBACK (Only publish if success, to keep MQTTX clean)
                if ($responseStatus === "1" || $responseStatus === "0") {
                    
                    $finalPayload = "$rfid,$responseStatus";
                    
                    // Publish the clean message to the public channel
                    MQTT::connection()->publish('RFID_LOGIN', $finalPayload); 
                    $this->info("[$rfid] -> RFID UID and STATUS: $finalPayload");
                } else {
                    $this->info("[$rfid] -> Unregistered Card");
                }

            } catch (\Throwable $e) {
                $this->error("CRITICAL ERROR: " . $e->getMessage());
            }
        });

        MQTT::connection()->loop(true);
    }
}