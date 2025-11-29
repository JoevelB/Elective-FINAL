<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\DashboardController;

// This tells Laravel: When the user goes to "/", show the Dashboard
Route::get('/', [DashboardController::class, 'index']);

// This is for the auto-refresh feature
Route::get('/api/logs', [DashboardController::class, 'getLogs']);
Route::get('/api/registered', [DashboardController::class, 'getRegistered']);