<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RFID Master Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; }
        ::-webkit-scrollbar { width: 6px; height: 6px; }
        ::-webkit-scrollbar-track { background: #f1f5f9; }
        ::-webkit-scrollbar-thumb { background: #cbd5e1; border-radius: 3px; }
        .toggle-checkbox:checked { right: 0; border-color: #10b981; }
        .toggle-checkbox:checked + .toggle-label { background-color: #10b981; }
    </style>
</head>
<body class="bg-slate-100 text-slate-800 min-h-screen flex flex-col pt-4">

    <main class="flex-1 max-w-7xl mx-auto w-full p-4 gap-6 grid grid-cols-1 lg:grid-cols-12">
        
        <section class="lg:col-span-4 flex flex-col bg-white rounded-xl shadow-sm border border-slate-200 h-[500px] lg:h-[calc(100vh-40px)]">
            <div class="p-4 border-b border-slate-100 bg-slate-50/50 flex justify-between items-center">
                <h2 class="font-semibold text-slate-700">Registered Cards</h2>
                <span class="text-[10px] bg-blue-100 text-blue-700 px-2 py-0.5 rounded-full font-bold uppercase"></span>
            </div>
            
            <div id="registered-container" class="flex-1 overflow-y-auto p-4 space-y-3">
                </div>
        </section>

        <section class="lg:col-span-8 flex flex-col bg-white rounded-xl shadow-sm border border-slate-200 h-[500px] lg:h-[calc(100vh-40px)]">
            <div class="p-4 border-b border-slate-100 bg-slate-50/50">
                <h2 class="font-semibold text-slate-700">Activity Logs</h2>
            </div>

            <div class="grid grid-cols-12 bg-slate-50 text-xs font-semibold text-slate-500 uppercase tracking-wider py-2 px-4 border-b border-slate-100">
                <div class="col-span-1">#</div>
                <div class="col-span-5">RFID Tag</div>
                <div class="col-span-2 text-center">Status</div>
                <div class="col-span-4 text-right">Date & Time</div>
            </div>

            <div class="flex-1 overflow-y-auto">
                <div id="log-table-body" class="divide-y divide-slate-100">
                    </div>
            </div>
        </section>

    </main>

    <script>
        // Helper function for required date format: "Month DD, YYYY hh:mma"
        function formatTimeLog(dateString) {
            const date = new Date(dateString);
            if (isNaN(date)) return dateString; // Return original if invalid

            const monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
            
            let hours = date.getHours();
            const minutes = date.getMinutes().toString().padStart(2, '0');
            const ampm = hours >= 12 ? 'pm' : 'am';
            hours = hours % 12;
            hours = hours ? hours : 12; // The hour '0' should be '12'

            const month = monthNames[date.getMonth()];
            const day = date.getDate();
            const year = date.getFullYear();

            return `${month} ${day}, ${year} ${hours}:${minutes}${ampm}`;
        }
        
        // --- RENDER REGISTERED LIST ---
        function renderRegistered(data) {
            const container = document.getElementById('registered-container');
            if(data.length === 0) { container.innerHTML = '<div class="text-center text-slate-400 py-10">No cards.</div>'; return; }
            let html = '';
            data.forEach((user, index) => {
                let isChecked = (user.status == '1') ? 'checked' : '';
                let activeClass = (user.status == '1') ? 'border-l-emerald-500 bg-emerald-50/30' : 'border-l-slate-300';
                html += `
                <div class="flex items-center justify-between p-3 rounded-lg border border-slate-100 shadow-sm ${activeClass} border-l-4">
                    <div class="flex items-center gap-3">
                        <span class="text-xs font-bold text-slate-400">#${index + 1}</span>
                        <div>
                            <div class="font-mono text-sm font-bold text-slate-700">${user.uid}</div>
                            <div class="text-[10px] uppercase font-bold ${user.status == '1' ? 'text-emerald-600' : 'text-slate-400'}">
                                ${user.status == '1' ? 'Active' : 'Inactive'}
                            </div>
                        </div>
                    </div>
                    <div class="relative inline-block w-10 align-middle select-none">
                        <input type="checkbox" class="toggle-checkbox absolute block w-5 h-5 rounded-full bg-white border-4 appearance-none pointer-events-none transition-all duration-300" ${isChecked} style="top: 2px; left: 2px;"/>
                        <label class="toggle-label block overflow-hidden h-6 rounded-full bg-slate-200"></label>
                    </div>
                </div>`;
            });
            container.innerHTML = html;
        }

        // --- RENDER LOGS TABLE ---
        function renderLogs(data) {
            const container = document.getElementById('log-table-body');
            let html = '';
            
            data.forEach((log, index) => {
                let statusBadge = '';
                
                // Status Logic (1, 0, or NULL/NOT FOUND)
                if (log.status === '1') {
                    statusBadge = `<span class="inline-flex items-center gap-1 px-2.5 py-0.5 rounded-full text-xs font-medium bg-emerald-100 text-emerald-800">
                        <span class="w-1.5 h-1.5 rounded-full bg-emerald-500"></span> 1
                    </span>`;
                } else if (log.status === '0') {
                    statusBadge = `<span class="inline-flex items-center gap-1 px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800">
                        <span class="w-1.5 h-1.5 rounded-full bg-blue-500"></span> 0
                    </span>`;
                } else {
                    // Catches NULL
                    statusBadge = `<span class="inline-flex items-center gap-1 px-2.5 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800">
                        <svg class="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                        RFID NOT FOUND
                    </span>`;
                }

                html += `
                    <div class="grid grid-cols-12 px-4 py-3 text-sm hover:bg-slate-50 items-center border-b border-slate-100 last:border-0">
                        <div class="col-span-1 text-slate-400 text-xs">${index + 1}</div>
                        <div class="col-span-5 font-mono font-medium text-slate-700 text-xs md:text-sm">${log.rfid}</div>
                        <div class="col-span-2 text-center">${statusBadge}</div>
                        <div class="col-span-4 text-right text-slate-500 text-[10px] md:text-xs font-mono">
                            ${formatTimeLog(log.time_log)} </div>
                    </div>`;
            });
            container.innerHTML = html;
        }

        // --- FETCH DATA ---
        function refreshData() {
            fetch('/api/registered').then(r => r.json()).then(d => renderRegistered(d));
            fetch('/api/logs').then(r => r.json()).then(d => renderLogs(d));
        }
        refreshData();
        setInterval(refreshData, 2000); 
    </script>
</body>
</html>