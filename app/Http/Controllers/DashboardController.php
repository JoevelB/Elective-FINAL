<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class DashboardController extends Controller
{
    public function index() {
    // Return the view
    return view('dashboard');
}

public function getLogs() {
        // Removed ->take(10) to return all logs in the database.
        $logs = \App\Models\RfidLog::orderBy('id', 'desc')->get();
        
        return response()->json($logs);
    }
// Fetch the Master List of all users and their CURRENT status
    public function getRegistered() {
        $users = \App\Models\RfidRegistered::all();
        return response()->json($users);
    }
}
