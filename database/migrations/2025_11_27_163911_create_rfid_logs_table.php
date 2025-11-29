<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
    {
        Schema::create('rfid_logs', function (Blueprint $table) {
            $table->id();
            $table->string('rfid');          // Changed from 'uid'
            $table->string('status')->nullable(); // Allow NULL for unregistered
            $table->string('time_log');  // Changed from 'scanned_at'
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('rfid_logs');
    }
};
