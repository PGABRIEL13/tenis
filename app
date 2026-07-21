<!DOCTYPE html>
<html lang="pt">
<head>
     <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="robots" content="noindex, nofollow">
    <title>TENNIS SIGNALS</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Chart.js CDN -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        'tennis-green': '#CCFF00',
                        'tennis-green-hover': '#b8e600',
                        'sidebar': '#111111',
                    }
                }
            }
        }
    </script>
    <style>
        * {
            box-shadow: none !important;
            text-shadow: none !important;
        }
        ::-webkit-scrollbar {
            width: 6px;
            height: 6px;
        }
        ::-webkit-scrollbar-track {
            background: #f1f1f1;
        }
        ::-webkit-scrollbar-thumb {
            background: #ccc;
        }
        ::-webkit-scrollbar-thumb:hover {
            background: #999;
        }
    </style>
</head>
<body class="bg-white text-zinc-900 font-sans antialiased min-h-screen flex flex-col md:flex-row">

    <!-- MOBILE TOP BAR -->
    <div class="md:hidden bg-sidebar text-white flex justify-between items-center p-4 border-b border-zinc-800 sticky top-0 z-50">
        <div class="flex items-center space-x-2">
            <span class="w-3 h-3 bg-tennis-green rounded-full inline-block"></span>
            <span class="font-bold tracking-wider text-sm">TENNIS SIGNALS</span>
        </div>
        <button id="mobile-menu-btn" onclick="toggleMobileSidebar()" class="text-zinc-300 hover:text-white p-1">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path>
            </svg>
        </button>
    </div>

    <!-- SIDEBAR -->
    <aside id="sidebar" class="hidden md:flex flex-col w-full md:w-64 bg-sidebar text-white min-h-screen flex-shrink-0 border-r border-zinc-800 z-40">
        <div class="p-6 border-b border-zinc-800 hidden md:flex items-center space-x-3">
            <span class="w-3.5 h-3.5 bg-tennis-green rounded-full inline-block"></span>
            <span class="font-extrabold tracking-widest text-base text-white">TENNIS SIGNALS</span>
        </div>

        <nav class="flex-1 px-3 py-6 space-y-1">
            <button onclick="navigate('dashboard')" class="nav-btn w-full flex items-center space-x-3 px-4 py-3 text-sm font-medium rounded text-zinc-300 hover:bg-zinc-900 hover:text-white transition" data-page="dashboard">
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zM14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zM14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z"></path></svg>
                <span>Dashboard</span>
            </button>
            <button onclick="navigate('signals')" class="nav-btn w-full flex items-center space-x-3 px-4 py-3 text-sm font-medium rounded text-zinc-300 hover:bg-zinc-900 hover:text-white transition" data-page="signals">
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z"></path></svg>
                <span>Signals</span>
            </button>
            <button onclick="navigate('botd')" class="nav-btn w-full flex items-center space-x-3 px-4 py-3 text-sm font-medium rounded text-zinc-300 hover:bg-zinc-900 hover:text-white transition" data-page="botd">
                <svg class="w-4 h-4 text-tennis-green" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 3v4M3 5h4M6 17v4m-2-2h4m5-16l2.286 6.857L21 12l-5.714 2.143L13 21l-2.286-6.857L5 12l5.714-2.143L13 3z"></path></svg>
                <span>Bet of the Day</span>
            </button>
            <button onclick="navigate('botw')" class="nav-btn w-full flex items-center space-x-3 px-4 py-3 text-sm font-medium rounded text-zinc-300 hover:bg-zinc-900 hover:text-white transition" data-page="botw">
                <svg class="w-4 h-4 text-tennis-green" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11.049 2.927c.3-.921 1.603-.921 1.902 0l1.519 4.674a1 1 0 00.95.69h4.915c.969 0 1.371 1.24.588 1.81l-3.976 2.888a1 1 0 00-.363 1.118l1.518 4.674c.3.922-.755 1.688-1.538 1.118l-3.976-2.888a1 1 0 00-1.176 0l-3.976 2.888c-.783.57-1.838-.197-1.538-1.118l1.518-4.674a1 1 0 00-.363-1.118l-3.976-2.888c-.784-.57-.38-1.81.588-1.81h4.914a1 1 0 00.951-.69l1.519-4.674z"></path></svg>
                <span>Bet of the Week</span>
            </button>
            <button onclick="navigate('results')" class="nav-btn w-full flex items-center space-x-3 px-4 py-3 text-sm font-medium rounded text-zinc-300 hover:bg-zinc-900 hover:text-white transition" data-page="results">
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                <span>Results</span>
            </button>
            <button onclick="navigate('history')" class="nav-btn w-full flex items-center space-x-3 px-4 py-3 text-sm font-medium rounded text-zinc-300 hover:bg-zinc-900 hover:text-white transition" data-page="history">
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                <span>History</span>
            </button>
            <button onclick="navigate('statistics')" class="nav-btn w-full flex items-center space-x-3 px-4 py-3 text-sm font-medium rounded text-zinc-300 hover:bg-zinc-900 hover:text-white transition" data-page="statistics">
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"></path></svg>
                <span>Statistics</span>
            </button>
            <button onclick="navigate('bankroll')" class="nav-btn w-full flex items-center space-x-3 px-4 py-3 text-sm font-medium rounded text-zinc-300 hover:bg-zinc-900 hover:text-white transition" data-page="bankroll">
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h18M7 15h1m4 0h1m-7 4h12a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"></path></svg>
                <span>Bankroll</span>
            </button>
            <button onclick="navigate('settings')" class="nav-btn w-full flex items-center space-x-3 px-4 py-3 text-sm font-medium rounded text-zinc-300 hover:bg-zinc-900 hover:text-white transition" data-page="settings">
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"></path><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path></svg>
                <span>Settings</span>
            </button>
        </nav>

        <div class="p-4 border-t border-zinc-800 text-xs text-zinc-500 flex items-center justify-between">
            <span>Versão MVP 1.0</span>
            <span class="w-2 h-2 rounded-full bg-tennis-green inline-block"></span>
        </div>
    </aside>

    <!-- MAIN CONTENT AREA -->
    <main class="flex-1 flex flex-col min-w-0 bg-white min-h-screen">
        <!-- HEADER -->
        <header class="border-b border-zinc-200 px-6 py-4 flex items-center justify-between bg-white">
            <h1 id="page-title" class="text-xl font-bold uppercase tracking-wide text-zinc-900">Dashboard</h1>
            <button onclick="openModal()" class="bg-tennis-green text-black font-semibold px-4 py-2 text-sm rounded hover:bg-tennis-green-hover transition flex items-center space-x-2">
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path></svg>
                <span>Novo Sinal</span>
            </button>
        </header>

        <!-- CONTAINER -->
        <div class="p-6 flex-1 max-w-7xl w-full mx-auto space-y-8">

            <!-- PAGE: DASHBOARD -->
            <section id="page-dashboard" class="page-content space-y-6">
                <div class="grid grid-cols-2 md:grid-cols-4 gap-4" id="kpi-grid"></div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div class="border border-zinc-200 rounded p-5 bg-white space-y-3">
                        <div class="flex justify-between items-center border-b border-zinc-100 pb-2">
                            <span class="text-xs font-bold uppercase tracking-wider text-zinc-500">Destaque</span>
                            <span class="text-xs font-bold px-2 py-0.5 bg-black text-tennis-green rounded">BET OF THE DAY</span>
                        </div>
                        <div id="dashboard-botd"></div>
                    </div>

                    <div class="border border-zinc-200 rounded p-5 bg-white space-y-3">
                        <div class="flex justify-between items-center border-b border-zinc-100 pb-2">
                            <span class="text-xs font-bold uppercase tracking-wider text-zinc-500">Destaque</span>
                            <span class="text-xs font-bold px-2 py-0.5 bg-black text-tennis-green rounded">BET OF THE WEEK</span>
                        </div>
                        <div id="dashboard-botw"></div>
                    </div>
                </div>

                <div class="border border-zinc-200 rounded p-5 space-y-4">
                    <h3 class="text-sm font-bold uppercase tracking-wide text-zinc-700">Últimos Sinais Registados</h3>
                    <div class="overflow-x-auto">
                        <table class="w-full text-left text-sm">
                            <thead class="border-b border-zinc-200 text-xs font-semibold text-zinc-500 uppercase bg-zinc-50">
                                <tr>
                                    <th class="p-3">Data</th>
                                    <th class="p-3">Torneio</th>
                                    <th class="p-3">Jogo</th>
                                    <th class="p-3">Mercado</th>
                                    <th class="p-3">Seleção</th>
                                    <th class="p-3">Odds</th>
                                    <th class="p-3">Stake</th>
                                    <th class="p-3">Status</th>
                                </tr>
                            </thead>
                            <tbody id="recent-signals-table" class="divide-y divide-zinc-100"></tbody>
                        </table>
                    </div>
                </div>
            </section>

            <!-- PAGE: SIGNALS -->
            <section id="page-signals" class="page-content hidden space-y-6">
                <div class="overflow-x-auto border border-zinc-200 rounded">
                    <table class="w-full text-left text-sm">
                        <thead class="border-b border-zinc-200 text-xs font-semibold text-zinc-500 uppercase bg-zinc-50">
                            <tr>
                                <th class="p-3">Data/Hora</th>
                                <th class="p-3">Torneio</th>
                                <th class="p-3">Jogo</th>
                                <th class="p-3">Mercado / Seleção</th>
                                <th class="p-3">Odds</th>
                                <th class="p-3">Stake</th>
                                <th class="p-3">Tipo</th>
                                <th class="p-3">Status</th>
                                <th class="p-3 text-right">Ações</th>
                            </tr>
                        </thead>
                        <tbody id="signals-list-table" class="divide-y divide-zinc-100"></tbody>
                    </table>
                </div>
            </section>

            <!-- PAGE: BET OF THE DAY -->
            <section id="page-botd" class="page-content hidden space-y-6">
                <div id="botd-full-view"></div>
            </section>

            <!-- PAGE: BET OF THE WEEK -->
            <section id="page-botw" class="page-content hidden space-y-6">
                <div id="botw-full-view"></div>
            </section>

            <!-- PAGE: RESULTS -->
            <section id="page-results" class="page-content hidden space-y-6">
                <div class="grid grid-cols-1 md:grid-cols-3 gap-4" id="results-summary"></div>
                <div class="border border-zinc-200 rounded p-5 space-y-4">
                    <h3 class="text-sm font-bold uppercase tracking-wide text-zinc-700">Sinais Resolvidos (Cálculo Automático)</h3>
                    <div class="overflow-x-auto">
                        <table class="w-full text-left text-sm">
                            <thead class="border-b border-zinc-200 text-xs font-semibold text-zinc-500 uppercase bg-zinc-50">
                                <tr>
                                    <th class="p-3">Data</th>
                                    <th class="p-3">Jogo</th>
                                    <th class="p-3">Seleção</th>
                                    <th class="p-3">Odds</th>
                                    <th class="p-3">Stake</th>
                                    <th class="p-3">Resultado</th>
                                    <th class="p-3 font-bold text-right">Lucro/Prejuízo</th>
                                </tr>
                            </thead>
                            <tbody id="results-table-body" class="divide-y divide-zinc-100"></tbody>
                        </table>
                    </div>
                </div>
            </section>

            <!-- PAGE: HISTORY -->
            <section id="page-history" class="page-content hidden space-y-6">
                <div class="flex flex-col sm:flex-row gap-4 justify-between items-center">
                    <div class="flex space-x-2">
                        <button onclick="filterHistory('All')" class="history-filter-btn px-3 py-1.5 text-xs font-semibold rounded border border-zinc-300 bg-black text-white" data-filter="All">Todos</button>
                        <button onclick="filterHistory('Green')" class="history-filter-btn px-3 py-1.5 text-xs font-semibold rounded border border-zinc-300 bg-white text-zinc-700 hover:bg-zinc-50" data-filter="Green">Green</button>
                        <button onclick="filterHistory('Red')" class="history-filter-btn px-3 py-1.5 text-xs font-semibold rounded border border-zinc-300 bg-white text-zinc-700 hover:bg-zinc-50" data-filter="Red">Red</button>
                        <button onclick="filterHistory('Void')" class="history-filter-btn px-3 py-1.5 text-xs font-semibold rounded border border-zinc-300 bg-white text-zinc-700 hover:bg-zinc-50" data-filter="Void">Void</button>
                        <button onclick="filterHistory('Pending')" class="history-filter-btn px-3 py-1.5 text-xs font-semibold rounded border border-zinc-300 bg-white text-zinc-700 hover:bg-zinc-50" data-filter="Pending">Pending</button>
                    </div>
                    <input type="text" id="history-search" oninput="renderHistory()" placeholder="Pesquisar jogador ou torneio..." class="px-3 py-1.5 text-sm border border-zinc-300 rounded w-full sm:w-64 focus:outline-none focus:border-black">
                </div>

                <div class="overflow-x-auto border border-zinc-200 rounded">
                    <table class="w-full text-left text-sm">
                        <thead class="border-b border-zinc-200 text-xs font-semibold text-zinc-500 uppercase bg-zinc-50">
                            <tr>
                                <th class="p-3">Data</th>
                                <th class="p-3">Torneio</th>
                                <th class="p-3">Superfície</th>
                                <th class="p-3">Jogo</th>
                                <th class="p-3">Seleção</th>
                                <th class="p-3">Odds</th>
                                <th class="p-3">Stake</th>
                                <th class="p-3">Status</th>
                                <th class="p-3 text-right">Profit</th>
                            </tr>
                        </thead>
                        <tbody id="history-table-body" class="divide-y divide-zinc-100"></tbody>
                    </table>
                </div>
            </section>

            <!-- PAGE: STATISTICS -->
            <section id="page-statistics" class="page-content hidden space-y-8">
                <div class="border border-zinc-200 rounded p-5 space-y-3">
                    <h3 class="text-sm font-bold uppercase tracking-wide text-zinc-800">Estatísticas por Mercado</h3>
                    <div class="overflow-x-auto">
                        <table class="w-full text-left text-sm">
                            <thead class="border-b border-zinc-200 text-xs font-semibold text-zinc-500 uppercase bg-zinc-50">
                                <tr>
                                    <th class="p-3">Mercado</th>
                                    <th class="p-3">Total</th>
                                    <th class="p-3">Greens</th>
                                    <th class="p-3">Reds</th>
                                    <th class="p-3">Voids</th>
                                    <th class="p-3">Win Rate</th>
                                    <th class="p-3">ROI</th>
                                    <th class="p-3 text-right">Profit</th>
                                </tr>
                            </thead>
                            <tbody id="stats-market-body" class="divide-y divide-zinc-100"></tbody>
                        </table>
                    </div>
                </div>

                <div class="border border-zinc-200 rounded p-5 space-y-3">
                    <h3 class="text-sm font-bold uppercase tracking-wide text-zinc-800">Estatísticas por Superfície</h3>
                    <div class="overflow-x-auto">
                        <table class="w-full text-left text-sm">
                            <thead class="border-b border-zinc-200 text-xs font-semibold text-zinc-500 uppercase bg-zinc-50">
                                <tr>
                                    <th class="p-3">Superfície</th>
                                    <th class="p-3">Total</th>
                                    <th class="p-3">Greens</th>
                                    <th class="p-3">Reds</th>
                                    <th class="p-3">Voids</th>
                                    <th class="p-3">Win Rate</th>
                                    <th class="p-3">ROI</th>
                                    <th class="p-3 text-right">Profit</th>
                                </tr>
                            </thead>
                            <tbody id="stats-surface-body" class="divide-y divide-zinc-100"></tbody>
                        </table>
                    </div>
                </div>

                <div class="border border-zinc-200 rounded p-5 space-y-3">
                    <h3 class="text-sm font-bold uppercase tracking-wide text-zinc-800">Estatísticas por Categoria</h3>
                    <div class="overflow-x-auto">
                        <table class="w-full text-left text-sm">
                            <thead class="border-b border-zinc-200 text-xs font-semibold text-zinc-500 uppercase bg-zinc-50">
                                <tr>
                                    <th class="p-3">Categoria</th>
                                    <th class="p-3">Total</th>
                                    <th class="p-3">Greens</th>
                                    <th class="p-3">Reds</th>
                                    <th class="p-3">Voids</th>
                                    <th class="p-3">Win Rate</th>
                                    <th class="p-3">ROI</th>
                                    <th class="p-3 text-right">Profit</th>
                                </tr>
                            </thead>
                            <tbody id="stats-category-body" class="divide-y divide-zinc-100"></tbody>
                        </table>
                    </div>
                </div>
            </section>

            <!-- PAGE: BANKROLL -->
            <section id="page-bankroll" class="page-content hidden space-y-6">
                <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                    <div class="border border-zinc-200 rounded p-5 space-y-4 bg-zinc-50">
                        <h3 class="text-sm font-bold uppercase tracking-wide text-zinc-800">Definições da Banca</h3>
                        <form id="bankroll-form" onsubmit="saveBankrollSettings(event)" class="space-y-4">
                            <div>
                                <label class="block text-xs font-semibold text-zinc-600 mb-1">Banca Inicial (€)</label>
                                <input type="number" step="0.01" id="input-initial-bankroll" required class="w-full px-3 py-2 border border-zinc-300 rounded text-sm focus:outline-none focus:border-black">
                            </div>
                            <div>
                                <label class="block text-xs font-semibold text-zinc-600 mb-1">Stake Padrão (€)</label>
                                <input type="number" step="0.01" id="input-default-stake" required class="w-full px-3 py-2 border border-zinc-300 rounded text-sm focus:outline-none focus:border-black">
                            </div>
                            <button type="submit" class="w-full bg-black text-white font-semibold py-2 text-sm rounded hover:bg-zinc-800 transition">
                                Salvar Parâmetros
                            </button>
                        </form>
                    </div>

                    <div class="md:col-span-2 grid grid-cols-2 gap-4" id="bankroll-kpi-cards"></div>
                </div>

                <div class="border border-zinc-200 rounded p-5 space-y-4">
                    <h3 class="text-sm font-bold uppercase tracking-wide text-zinc-800">Evolução da Banca (€)</h3>
                    <div class="h-64 w-full">
                        <canvas id="bankrollChart"></canvas>
                    </div>
                </div>
            </section>

            <!-- PAGE: SETTINGS -->
            <section id="page-settings" class="page-content hidden space-y-6">
                <div class="max-w-2xl border border-zinc-200 rounded p-6 space-y-6">
                    <div>
                        <h3 class="text-base font-bold text-zinc-900">Gestão de Dados Locais</h3>
                        <p class="text-sm text-zinc-500 mt-1">Todos os dados estão armazenados exclusivamente no localStorage do navegador.</p>
                    </div>
                    <hr class="border-zinc-200">
                    <div class="space-y-4">
                        <div class="flex items-center justify-between">
                            <div>
                                <h4 class="text-sm font-semibold text-zinc-800">Exportar Dados (JSON)</h4>
                                <p class="text-xs text-zinc-500">Faça download do ficheiro JSON de salvaguarda.</p>
                            </div>
                            <button onclick="exportData()" class="px-4 py-2 bg-black text-white text-sm font-semibold rounded hover:bg-zinc-800 transition">Exportar JSON</button>
                        </div>
                        <hr class="border-zinc-100">
                        <div class="flex items-center justify-between">
                            <div>
                                <h4 class="text-sm font-semibold text-zinc-800">Importar Dados (JSON)</h4>
                                <p class="text-xs text-zinc-500">Restaure os dados de um ficheiro previamente exportado.</p>
                            </div>
                            <label class="px-4 py-2 bg-zinc-100 border border-zinc-300 text-zinc-800 text-sm font-semibold rounded hover:bg-zinc-200 cursor-pointer transition">
                                Importar JSON
                                <input type="file" id="import-file" accept=".json" onchange="importData(event)" class="hidden">
                            </label>
                        </div>
                        <hr class="border-zinc-100">
                        <div class="flex items-center justify-between pt-2">
                            <div>
                                <h4 class="text-sm font-semibold text-rose-600">Eliminar Todos os Dados</h4>
                                <p class="text-xs text-zinc-500">Elimina de forma irreversível os dados no navegador.</p>
                            </div>
                            <button onclick="resetData()" class="px-4 py-2 bg-rose-600 text-white text-sm font-semibold rounded hover:bg-rose-700 transition">Reset Total</button>
                        </div>
                    </div>
                </div>
            </section>

        </div>

        <!-- FOOTER -->
        <footer class="border-t border-zinc-200 py-4 px-6 text-center text-xs text-zinc-500 mt-auto bg-white">
            Os sinais apresentados são análises e não garantem resultados ou lucros. As apostas envolvem risco e devem ser realizadas de forma responsável.
        </footer>
    </main>

    <!-- MODAL (CREATE / EDIT SIGNAL) -->
    <div id="signal-modal" class="fixed inset-0 bg-black/60 z-50 hidden flex items-center justify-center p-4">
        <div class="bg-white rounded border border-zinc-300 w-full max-w-2xl max-h-[90vh] flex flex-col overflow-hidden">
            <div class="px-6 py-4 border-b border-zinc-200 flex justify-between items-center bg-zinc-50">
                <h3 id="modal-title" class="text-base font-bold text-zinc-900">Novo Sinal</h3>
                <button onclick="closeModal()" class="text-zinc-400 hover:text-black">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path></svg>
                </button>
            </div>

            <form id="signal-form" onsubmit="handleSignalSubmit(event)" class="p-6 overflow-y-auto space-y-4">
                <input type="hidden" id="signal-id">

                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <div>
                        <label class="block text-xs font-semibold text-zinc-600 mb-1">Torneio *</label>
                        <input type="text" id="form-tournament" placeholder="Ex: Wimbledon" required class="w-full px-3 py-1.5 border border-zinc-300 rounded text-sm focus:outline-none focus:border-black">
                    </div>
                    <div>
                        <label class="block text-xs font-semibold text-zinc-600 mb-1">Categoria *</label>
                        <select id="form-category" class="w-full px-3 py-1.5 border border-zinc-300 rounded text-sm focus:outline-none focus:border-black">
                            <option value="ATP">ATP</option>
                            <option value="WTA">WTA</option>
                            <option value="Challenger">Challenger</option>
                            <option value="ITF Masculino">ITF Masculino</option>
                            <option value="ITF Feminino">ITF Feminino</option>
                        </select>
                    </div>
                    <div>
                        <label class="block text-xs font-semibold text-zinc-600 mb-1">Ronda</label>
                        <input type="text" id="form-round" placeholder="Ex: Oitavos de Final" class="w-full px-3 py-1.5 border border-zinc-300 rounded text-sm focus:outline-none focus:border-black">
                    </div>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <label class="block text-xs font-semibold text-zinc-600 mb-1">Jogador / Par 1 *</label>
                        <input type="text" id="form-player1" placeholder="Ex: Carlos Alcaraz" required class="w-full px-3 py-1.5 border border-zinc-300 rounded text-sm focus:outline-none focus:border-black">
                    </div>
                    <div>
                        <label class="block text-xs font-semibold text-zinc-600 mb-1">Jogador / Par 2 *</label>
                        <input type="text" id="form-player2" placeholder="Ex: Jannik Sinner" required class="w-full px-3 py-1.5 border border-zinc-300 rounded text-sm focus:outline-none focus:border-black">
                    </div>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <div>
                        <label class="block text-xs font-semibold text-zinc-600 mb-1">Data *</label>
                        <input type="date" id="form-date" required class="w-full px-3 py-1.5 border border-zinc-300 rounded text-sm focus:outline-none focus:border-black">
                    </div>
                    <div>
                        <label class="block text-xs font-semibold text-zinc-600 mb-1">Hora</label>
                        <input type="time" id="form-time" class="w-full px-3 py-1.5 border border-zinc-300 rounded text-sm focus:outline-none focus:border-black">
                    </div>
                    <div>
                        <label class="block text-xs font-semibold text-zinc-600 mb-1">Superfície *</label>
                        <select id="form-surface" class="w-full px-3 py-1.5 border border-zinc-300 rounded text-sm focus:outline-none focus:border-black">
                            <option value="Hard">Hard (Piso Rápido)</option>
                            <option value="Clay">Clay (Terra Batida)</option>
                            <option value="Grass">Grass (Relva)</option>
                            <option value="Carpet">Carpet (Sintético)</option>
                            <option value="Indoor">Indoor</option>
                        </select>
                    </div>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <label class="block text-xs font-semibold text-zinc-600 mb-1">Mercado *</label>
                        <input type="text" id="form-market" placeholder="Ex: Match Winner" required class="w-full px-3 py-1.5 border border-zinc-300 rounded text-sm focus:outline-none focus:border-black">
                    </div>
                    <div>
                        <label class="block text-xs font-semibold text-zinc-600 mb-1">Seleção *</label>
                        <input type="text" id="form-selection" placeholder="Ex: Carlos Alcaraz" required class="w-full px-3 py-1.5 border border-zinc-300 rounded text-sm focus:outline-none focus:border-black">
                    </div>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                    <div>
                        <label class="block text-xs font-semibold text-zinc-600 mb-1">Odds *</label>
                        <input type="number" step="0.01" min="1.01" id="form-odds" required class="w-full px-3 py-1.5 border border-zinc-300 rounded text-sm focus:outline-none focus:border-black">
                    </div>
                    <div>
                        <label class="block text-xs font-semibold text-zinc-600 mb-1">Stake (€) *</label>
                        <input type="number" step="0.01" min="1" id="form-stake" required class="w-full px-3 py-1.5 border border-zinc-300 rounded text-sm focus:outline-none focus:border-black">
                    </div>
                    <div>
                        <label class="block text-xs font-semibold text-zinc-600 mb-1">Confiança</label>
                        <input type="text" id="form-confidence" placeholder="Ex: 8/10" class="w-full px-3 py-1.5 border border-zinc-300 rounded text-sm focus:outline-none focus:border-black">
                    </div>
                    <div>
                        <label class="block text-xs font-semibold text-zinc-600 mb-1">Edge / Valor</label>
                        <input type="text" id="form-edge" placeholder="Ex: +5.2%" class="w-full px-3 py-1.5 border border-zinc-300 rounded text-sm focus:outline-none focus:border-black">
                    </div>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <label class="block text-xs font-semibold text-zinc-600 mb-1">Tipo de Sinal *</label>
                        <select id="form-type" class="w-full px-3 py-1.5 border border-zinc-300 rounded text-sm focus:outline-none focus:border-black">
                            <option value="Normal">Normal</option>
                            <option value="Bet of the Day">Bet of the Day</option>
                            <option value="Bet of the Week">Bet of the Week</option>
                        </select>
                    </div>
                    <div>
                        <label class="block text-xs font-semibold text-zinc-600 mb-1">Status *</label>
                        <select id="form-status" class="w-full px-3 py-1.5 border border-zinc-300 rounded text-sm focus:outline-none focus:border-black">
                            <option value="Pending">Pending (Pendente)</option>
                            <option value="Green">Green (Ganha)</option>
                            <option value="Red">Red (Perdida)</option>
                            <option value="Void">Void (Anulada)</option>
                        </select>
                    </div>
                </div>

                <div>
                    <label class="block text-xs font-semibold text-zinc-600 mb-1">Análise Tática</label>
                    <textarea id="form-analysis" rows="3" placeholder="Insira a análise e justificação..." class="w-full px-3 py-1.5 border border-zinc-300 rounded text-sm focus:outline-none focus:border-black"></textarea>
                </div>

                <div class="pt-4 border-t border-zinc-200 flex justify-end space-x-3">
                    <button type="button" onclick="closeModal()" class="px-4 py-2 border border-zinc-300 rounded text-sm text-zinc-700 hover:bg-zinc-100 transition">Cancelar</button>
                    <button type="submit" class="px-4 py-2 bg-tennis-green text-black font-semibold rounded text-sm hover:bg-tennis-green-hover transition">Guardar Sinal</button>
                </div>
            </form>
        </div>
    </div>

    <!-- LOGICAL JAVASCRIPT -->
    <script>
        const STORAGE_SIGNALS = 'tennis_signals_db_v1';
        const STORAGE_CONFIG = 'tennis_signals_config_v1';

        let signals = [];
        let config = { initialBankroll: 1000, defaultStake: 50 };
        let currentFilterHistory = 'All';
        let chartInstance = null;

        const sampleSignals = [
            {
                id: 'sig_1',
                tournament: 'Wimbledon',
                category: 'ATP',
                round: 'Final',
                player1: 'Carlos Alcaraz',
                player2: 'Jannik Sinner',
                date: '2026-07-12',
                time: '15:00',
                surface: 'Grass',
                market: 'Match Winner',
                selection: 'Carlos Alcaraz',
                odds: 1.95,
                stake: 100,
                confidence: '9/10',
                edge: '+6.5%',
                analysis: 'Alcaraz apresenta percentagem de 1º serviço superior a 72% na relva e elevado rendimento na devolução.',
                type: 'Bet of the Day',
                status: 'Green'
            },
            {
                id: 'sig_2',
                tournament: 'Roland Garros',
                category: 'ATP',
                round: 'Meias-Finais',
                player1: 'Novak Djokovic',
                player2: 'Rafael Nadal',
                date: '2026-06-05',
                time: '16:30',
                surface: 'Clay',
                market: 'Total Games',
                selection: 'Mais de 38.5 Games',
                odds: 1.85,
                stake: 50,
                confidence: '8/10',
                edge: '+4.0%',
                analysis: 'Confronto equilibrado em terra batida com tendência estatística para encontros longos.',
                type: 'Bet of the Week',
                status: 'Green'
            },
            {
                id: 'sig_3',
                tournament: 'US Open',
                category: 'WTA',
                round: 'Ronda 3',
                player1: 'Iga Swiatek',
                player2: 'Aryna Sabalenka',
                date: '2026-07-18',
                time: '19:00',
                surface: 'Hard',
                market: 'Handicap Sets',
                selection: 'Aryna Sabalenka +1.5',
                odds: 1.70,
                stake: 50,
                confidence: '7/10',
                edge: '+3.0%',
                analysis: 'Piso rápido favorece o serviço agressivo de Sabalenka.',
                type: 'Normal',
                status: 'Red'
            },
            {
                id: 'sig_4',
                tournament: 'ATP Masters Madrid',
                category: 'ATP',
                round: 'Quartos de Final',
                player1: 'Stefanos Tsitsipas',
                player2: 'Casper Ruud',
                date: '2026-07-21',
                time: '14:00',
                surface: 'Clay',
                market: 'Vencedor Set 1',
                selection: 'Casper Ruud',
                odds: 2.10,
                stake: 50,
                confidence: '7.5/10',
                edge: '+5.0%',
                analysis: 'Ruud tem iniciado os encontros com elevada eficácia no 1º set.',
                type: 'Normal',
                status: 'Pending'
            }
        ];

        document.addEventListener('DOMContentLoaded', () => {
            loadData();
            navigate('dashboard');
        });

        function toggleMobileSidebar() {
            document.getElementById('sidebar').classList.toggle('hidden');
        }

        function loadData() {
            const storedSignals = localStorage.getItem(STORAGE_SIGNALS);
            const storedConfig = localStorage.getItem(STORAGE_CONFIG);

            if (storedSignals) {
                signals = JSON.parse(storedSignals);
            } else {
                signals = sampleSignals;
                saveSignals();
            }

            if (storedConfig) {
                config = JSON.parse(storedConfig);
            } else {
                saveConfig();
            }

            document.getElementById('input-initial-bankroll').value = config.initialBankroll;
            document.getElementById('input-default-stake').value = config.defaultStake;
            document.getElementById('form-stake').value = config.defaultStake;
        }

        function saveSignals() {
            localStorage.setItem(STORAGE_SIGNALS, JSON.stringify(signals));
        }

        function saveConfig() {
            localStorage.setItem(STORAGE_CONFIG, JSON.stringify(config));
        }

        function navigate(pageId) {
            document.querySelectorAll('.page-content').forEach(el => el.classList.add('hidden'));
            const targetPage = document.getElementById(`page-${pageId}`);
            if (targetPage) targetPage.classList.remove('hidden');

            document.querySelectorAll('.nav-btn').forEach(btn => {
                if (btn.dataset.page === pageId) {
                    btn.classList.add('bg-zinc-800', 'text-white', 'border-l-4', 'border-tennis-green');
                    btn.classList.remove('text-zinc-300');
                } else {
                    btn.classList.remove('bg-zinc-800', 'text-white', 'border-l-4', 'border-tennis-green');
                    btn.classList.add('text-zinc-300');
                }
            });

            const titles = {
                dashboard: 'Dashboard',
                signals: 'Gestão de Sinais',
                botd: 'Bet of the Day',
                botw: 'Bet of the Week',
                results: 'Resultados',
                history: 'Histórico',
                statistics: 'Estatísticas',
                bankroll: 'Bankroll',
                settings: 'Definições'
            };
            document.getElementById('page-title').innerText = titles[pageId] || 'Tennis Signals';

            if (window.innerWidth < 768) {
                document.getElementById('sidebar').classList.add('hidden');
            }

            if (pageId === 'dashboard') renderDashboard();
            if (pageId === 'signals') renderSignals();
            if (pageId === 'botd') renderBOTD();
            if (pageId === 'botw') renderBOTW();
            if (pageId === 'results') renderResults();
            if (pageId === 'history') renderHistory();
            if (pageId === 'statistics') renderStatistics();
            if (pageId === 'bankroll') renderBankroll();
        }

        function calculateMetrics(signalList = signals) {
            let totalSignals = signalList.length;
            let greens = 0, reds = 0, voids = 0, pending = 0;
            let totalProfit = 0;
            let totalStakeSettled = 0;

            signalList.forEach(s => {
                const odds = parseFloat(s.odds) || 0;
                const stake = parseFloat(s.stake) || 0;

                if (s.status === 'Green') {
                    greens++;
                    totalProfit += stake * (odds - 1);
                    totalStakeSettled += stake;
                } else if (s.status === 'Red') {
                    reds++;
                    totalProfit -= stake;
                    totalStakeSettled += stake;
                } else if (s.status === 'Void') {
                    voids++;
                    totalStakeSettled += stake;
                } else {
                    pending++;
                }
            });

            const decidedBets = greens + reds;
            const winRate = decidedBets > 0 ? ((greens / decidedBets) * 100).toFixed(1) : '0.0';
            const roi = totalStakeSettled > 0 ? ((totalProfit / totalStakeSettled) * 100).toFixed(1) : '0.0';
            const currentBankroll = parseFloat(config.initialBankroll) + totalProfit;

            return { totalSignals, greens, reds, voids, pending, winRate, roi, totalProfit, currentBankroll };
        }

        function calculateSignalProfit(s) {
            const odds = parseFloat(s.odds) || 0;
            const stake = parseFloat(s.stake) || 0;
            if (s.status === 'Green') return stake * (odds - 1);
            if (s.status === 'Red') return -stake;
            return 0;
        }

        function renderDashboard() {
            const m = calculateMetrics();

            document.getElementById('kpi-grid').innerHTML = `
                <div class="p-4 border border-zinc-200 rounded">
                    <p class="text-xs font-semibold text-zinc-500 uppercase">Total Signals</p>
                    <p class="text-2xl font-black text-zinc-900 mt-1">${m.totalSignals}</p>
                </div>
                <div class="p-4 border border-zinc-200 rounded">
                    <p class="text-xs font-semibold text-zinc-500 uppercase">Greens / Reds / Voids</p>
                    <p class="text-xl font-bold mt-1">
                        <span class="text-emerald-600">${m.greens}</span> / 
                        <span class="text-rose-600">${m.reds}</span> / 
                        <span class="text-zinc-500">${m.voids}</span>
                    </p>
                </div>
                <div class="p-4 border border-zinc-200 rounded">
                    <p class="text-xs font-semibold text-zinc-500 uppercase">Win Rate</p>
                    <p class="text-2xl font-black text-zinc-900 mt-1">${m.winRate}%</p>
                </div>
                <div class="p-4 border border-zinc-200 rounded">
                    <p class="text-xs font-semibold text-zinc-500 uppercase">ROI</p>
                    <p class="text-2xl font-black ${m.roi >= 0 ? 'text-emerald-600' : 'text-rose-600'} mt-1">${m.roi}%</p>
                </div>
                <div class="p-4 border border-zinc-200 rounded col-span-2">
                    <p class="text-xs font-semibold text-zinc-500 uppercase">Total Profit</p>
                    <p class="text-2xl font-black ${m.totalProfit >= 0 ? 'text-emerald-600' : 'text-rose-600'} mt-1">
                        ${m.totalProfit >= 0 ? '+' : ''}€${m.totalProfit.toFixed(2)}
                    </p>
                </div>
                <div class="p-4 border border-zinc-200 rounded col-span-2 bg-zinc-50">
                    <p class="text-xs font-semibold text-zinc-500 uppercase">Current Bankroll</p>
                    <p class="text-2xl font-black text-zinc-900 mt-1">€${m.currentBankroll.toFixed(2)}</p>
                </div>
            `;

            const botd = signals.find(s => s.type === 'Bet of the Day');
            document.getElementById('dashboard-botd').innerHTML = botd ? renderCardMini(botd) : '<p class="text-sm text-zinc-400 py-4">Not provided</p>';

            const botw = signals.find(s => s.type === 'Bet of the Week');
            document.getElementById('dashboard-botw').innerHTML = botw ? renderCardMini(botw) : '<p class="text-sm text-zinc-400 py-4">Not provided</p>';

            const recent = [...signals].slice(-5).reverse();
            const tbody = document.getElementById('recent-signals-table');
            if (recent.length === 0) {
                tbody.innerHTML = '<tr><td colspan="8" class="p-4 text-center text-zinc-400">Not provided</td></tr>';
            } else {
                tbody.innerHTML = recent.map(s => `
                    <tr class="hover:bg-zinc-50">
                        <td class="p-3 text-zinc-600 text-xs">${s.date || 'Not provided'}</td>
                        <td class="p-3 font-semibold text-zinc-800">${s.tournament || 'Not provided'}</td>
                        <td class="p-3">${s.player1 || 'Not provided'} vs ${s.player2 || 'Not provided'}</td>
                        <td class="p-3 text-zinc-600">${s.market || 'Not provided'}</td>
                        <td class="p-3 font-medium text-black">${s.selection || 'Not provided'}</td>
                        <td class="p-3 font-mono font-bold">@${s.odds || 'Not provided'}</td>
                        <td class="p-3 font-mono">€${s.stake || 'Not provided'}</td>
                        <td class="p-3">${renderStatusBadge(s.status)}</td>
                    </tr>
                `).join('');
            }
        }

        function renderCardMini(s) {
            return `
                <div class="space-y-2">
                    <div class="flex justify-between text-xs text-zinc-500">
                        <span>${s.tournament || 'Not provided'} • ${s.surface || 'Not provided'}</span>
                        <span>${s.date || 'Not provided'} ${s.time || ''}</span>
                    </div>
                    <p class="font-bold text-base text-zinc-900">${s.player1 || 'Not provided'} vs ${s.player2 || 'Not provided'}</p>
                    <div class="flex justify-between items-center bg-zinc-50 p-2.5 rounded border border-zinc-200">
                        <div>
                            <span class="text-xs text-zinc-500 block">${s.market || 'Not provided'}</span>
                            <span class="font-bold text-sm text-black">${s.selection || 'Not provided'}</span>
                        </div>
                        <div class="text-right">
                            <span class="text-xs text-zinc-500 block">Odds / Stake</span>
                            <span class="font-mono font-bold text-sm text-black">@${s.odds} • €${s.stake}</span>
                        </div>
                    </div>
                    <div class="flex justify-between items-center pt-1">
                        <span class="text-xs text-zinc-500">Confiança: <strong>${s.confidence || 'Not provided'}</strong></span>
                        ${renderStatusBadge(s.status)}
                    </div>
                </div>
            `;
        }

        function renderSignals() {
            const tbody = document.getElementById('signals-list-table');
            if (signals.length === 0) {
                tbody.innerHTML = '<tr><td colspan="9" class="p-4 text-center text-zinc-400">Not provided</td></tr>';
                return;
            }
            tbody.innerHTML = signals.map(s => `
                <tr class="hover:bg-zinc-50">
                    <td class="p-3 text-xs text-zinc-600">${s.date || 'Not provided'}<br><span class="text-zinc-400">${s.time || ''}</span></td>
                    <td class="p-3 font-medium">${s.tournament || 'Not provided'}<br><span class="text-xs text-zinc-400">${s.category || 'Not provided'}</span></td>
                    <td class="p-3 font-semibold">${s.player1 || 'Not provided'} vs ${s.player2 || 'Not provided'}</td>
                    <td class="p-3"><span class="text-xs text-zinc-500 block">${s.market || 'Not provided'}</span><span class="font-bold">${s.selection || 'Not provided'}</span></td>
                    <td class="p-3 font-mono font-bold">@${s.odds}</td>
                    <td class="p-3 font-mono">€${s.stake}</td>
                    <td class="p-3"><span class="text-xs px-2 py-0.5 rounded bg-zinc-100 border border-zinc-200 font-medium">${s.type}</span></td>
                    <td class="p-3">${renderStatusBadge(s.status)}</td>
                    <td class="p-3 text-right space-x-2">
                        <button onclick="openModal('${s.id}')" class="text-xs font-semibold text-zinc-700 hover:text-black underline">Editar</button>
                        <button onclick="deleteSignal('${s.id}')" class="text-xs font-semibold text-rose-600 hover:text-rose-800 underline">Eliminar</button>
                    </td>
                </tr>
            `).join('');
        }

        function renderBOTD() {
            const botd = signals.find(s => s.type === 'Bet of the Day');
            document.getElementById('botd-full-view').innerHTML = botd ? renderFullSignalCard(botd, 'BET OF THE DAY') : `
                <div class="border border-dashed border-zinc-300 rounded p-12 text-center text-zinc-500">
                    <p class="font-bold text-lg">Sem Bet of the Day atribuída</p>
                </div>
            `;
        }

        function renderBOTW() {
            const botw = signals.find(s => s.type === 'Bet of the Week');
            document.getElementById('botw-full-view').innerHTML = botw ? renderFullSignalCard(botw, 'BET OF THE WEEK') : `
                <div class="border border-dashed border-zinc-300 rounded p-12 text-center text-zinc-500">
                    <p class="font-bold text-lg">Sem Bet of the Week atribuída</p>
                </div>
            `;
        }

        function renderFullSignalCard(s, badgeTitle) {
            const profit = calculateSignalProfit(s);
            return `
                <div class="border border-zinc-300 rounded p-6 bg-white space-y-6">
                    <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-2 border-b border-zinc-200 pb-4">
                        <div>
                            <span class="text-xs font-bold px-2 py-1 bg-black text-tennis-green rounded uppercase">${badgeTitle}</span>
                            <h2 class="text-2xl font-black text-zinc-900 mt-2">${s.player1 || 'Not provided'} vs ${s.player2 || 'Not provided'}</h2>
                        </div>
                        <div>${renderStatusBadge(s.status)}</div>
                    </div>

                    <div class="grid grid-cols-2 md:grid-cols-4 gap-4 text-sm bg-zinc-50 p-4 rounded border border-zinc-200">
                        <div>
                            <span class="text-xs text-zinc-500 uppercase block">Torneio / Categoria</span>
                            <span class="font-bold text-zinc-800">${s.tournament || 'Not provided'} (${s.category || 'Not provided'})</span>
                        </div>
                        <div>
                            <span class="text-xs text-zinc-500 uppercase block">Superfície</span>
                            <span class="font-bold text-zinc-800">${s.surface || 'Not provided'}</span>
                        </div>
                        <div>
                            <span class="text-xs text-zinc-500 uppercase block">Data e Hora</span>
                            <span class="font-bold text-zinc-800">${s.date || 'Not provided'} ${s.time || ''}</span>
                        </div>
                        <div>
                            <span class="text-xs text-zinc-500 uppercase block">Ronda</span>
                            <span class="font-bold text-zinc-800">${s.round || 'Not provided'}</span>
                        </div>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                        <div class="border border-zinc-200 p-4 rounded">
                            <span class="text-xs text-zinc-500 uppercase block">Mercado & Seleção</span>
                            <span class="text-sm text-zinc-600 block">${s.market || 'Not provided'}</span>
                            <span class="text-lg font-black text-black">${s.selection || 'Not provided'}</span>
                        </div>
                        <div class="border border-zinc-200 p-4 rounded">
                            <span class="text-xs text-zinc-500 uppercase block">Odds & Stake</span>
                            <span class="text-lg font-mono font-black text-black">@${s.odds} • €${s.stake}</span>
                        </div>
                        <div class="border border-zinc-200 p-4 rounded">
                            <span class="text-xs text-zinc-500 uppercase block">Confiança / Edge</span>
                            <span class="text-base font-bold text-zinc-800">${s.confidence || 'Not provided'} | ${s.edge || 'Not provided'}</span>
                        </div>
                    </div>

                    <div class="border border-zinc-200 p-4 rounded bg-white">
                        <h4 class="text-xs font-bold uppercase text-zinc-500 mb-2">Análise Tática</h4>
                        <p class="text-sm text-zinc-800 leading-relaxed">${s.analysis || 'Not provided'}</p>
                    </div>

                    <div class="flex justify-between items-center pt-2">
                        <span class="text-sm text-zinc-500">Lucro Calculado: <strong class="font-mono ${profit >= 0 ? 'text-emerald-600' : 'text-rose-600'}">${profit >= 0 ? '+' : ''}€${profit.toFixed(2)}</strong></span>
                        <button onclick="openModal('${s.id}')" class="px-4 py-2 bg-black text-white text-xs font-bold rounded hover:bg-zinc-800">Editar</button>
                    </div>
                </div>
            `;
        }

        function renderResults() {
            const m = calculateMetrics();
            document.getElementById('results-summary').innerHTML = `
                <div class="p-4 border border-zinc-200 rounded">
                    <p class="text-xs font-semibold text-zinc-500 uppercase">Total Profit</p>
                    <p class="text-2xl font-black ${m.totalProfit >= 0 ? 'text-emerald-600' : 'text-rose-600'} mt-1">
                        ${m.totalProfit >= 0 ? '+' : ''}€${m.totalProfit.toFixed(2)}
                    </p>
                </div>
                <div class="p-4 border border-zinc-200 rounded">
                    <p class="text-xs font-semibold text-zinc-500 uppercase">Win Rate</p>
                    <p class="text-2xl font-black text-zinc-900 mt-1">${m.winRate}%</p>
                </div>
                <div class="p-4 border border-zinc-200 rounded">
                    <p class="text-xs font-semibold text-zinc-500 uppercase">ROI</p>
                    <p class="text-2xl font-black ${m.roi >= 0 ? 'text-emerald-600' : 'text-rose-600'} mt-1">${m.roi}%</p>
                </div>
            `;

            const settled = signals.filter(s => s.status !== 'Pending');
            const tbody = document.getElementById('results-table-body');

            if (settled.length === 0) {
                tbody.innerHTML = '<tr><td colspan="7" class="p-4 text-center text-zinc-400">Not provided</td></tr>';
                return;
            }

            tbody.innerHTML = settled.map(s => {
                const profit = calculateSignalProfit(s);
                return `
                    <tr class="hover:bg-zinc-50">
                        <td class="p-3 text-xs text-zinc-600">${s.date || 'Not provided'}</td>
                        <td class="p-3 font-semibold">${s.player1 || 'Not provided'} vs ${s.player2 || 'Not provided'}</td>
                        <td class="p-3 font-medium">${s.selection || 'Not provided'}</td>
                        <td class="p-3 font-mono">@${s.odds}</td>
                        <td class="p-3 font-mono">€${s.stake}</td>
                        <td class="p-3">${renderStatusBadge(s.status)}</td>
                        <td class="p-3 font-mono font-bold text-right ${profit >= 0 ? 'text-emerald-600' : 'text-rose-600'}">
                            ${profit >= 0 ? '+' : ''}€${profit.toFixed(2)}
                        </td>
                    </tr>
                `;
            }).join('');
        }

        function filterHistory(filter) {
            currentFilterHistory = filter;
            document.querySelectorAll('.history-filter-btn').forEach(btn => {
                if (btn.dataset.filter === filter) {
                    btn.classList.remove('bg-white', 'text-zinc-700');
                    btn.classList.add('bg-black', 'text-white');
                } else {
                    btn.classList.remove('bg-black', 'text-white');
                    btn.classList.add('bg-white', 'text-zinc-700');
                }
            });
            renderHistory();
        }

        function renderHistory() {
            const searchTerm = (document.getElementById('history-search')?.value || '').toLowerCase();
            let filtered = signals;

            if (currentFilterHistory !== 'All') {
                filtered = filtered.filter(s => s.status === currentFilterHistory);
            }

            if (searchTerm) {
                filtered = filtered.filter(s => 
                    (s.player1 && s.player1.toLowerCase().includes(searchTerm)) ||
                    (s.player2 && s.player2.toLowerCase().includes(searchTerm)) ||
                    (s.tournament && s.tournament.toLowerCase().includes(searchTerm))
                );
            }

            const tbody = document.getElementById('history-table-body');
            if (filtered.length === 0) {
                tbody.innerHTML = '<tr><td colspan="9" class="p-4 text-center text-zinc-400">Not provided</td></tr>';
                return;
            }

            tbody.innerHTML = filtered.map(s => {
                const profit = calculateSignalProfit(s);
                return `
                    <tr class="hover:bg-zinc-50">
                        <td class="p-3 text-xs text-zinc-600">${s.date || 'Not provided'}</td>
                        <td class="p-3 font-medium">${s.tournament || 'Not provided'}</td>
                        <td class="p-3 text-xs text-zinc-500">${s.surface || 'Not provided'}</td>
                        <td class="p-3 font-semibold">${s.player1 || 'Not provided'} vs ${s.player2 || 'Not provided'}</td>
                        <td class="p-3 font-medium">${s.selection || 'Not provided'}</td>
                        <td class="p-3 font-mono font-bold">@${s.odds}</td>
                        <td class="p-3 font-mono">€${s.stake}</td>
                        <td class="p-3">${renderStatusBadge(s.status)}</td>
                        <td class="p-3 font-mono font-bold text-right ${profit >= 0 ? 'text-emerald-600' : 'text-rose-600'}">
                            ${s.status === 'Pending' ? '—' : `${profit >= 0 ? '+' : ''}€${profit.toFixed(2)}`}
                        </td>
                    </tr>
                `;
            }).join('');
        }

        function renderStatistics() {
            renderGroupedStats('market', 'stats-market-body');
            renderGroupedStats('surface', 'stats-surface-body');
            renderGroupedStats('category', 'stats-category-body');
        }

        function renderGroupedStats(field, targetElemId) {
            const groups = {};

            signals.forEach(s => {
                const key = s[field] || 'Not provided';
                if (!groups[key]) groups[key] = [];
                groups[key].push(s);
            });

            const tbody = document.getElementById(targetElemId);
            const keys = Object.keys(groups);

            if (keys.length === 0) {
                tbody.innerHTML = '<tr><td colspan="8" class="p-4 text-center text-zinc-400">Not provided</td></tr>';
                return;
            }

            tbody.innerHTML = keys.map(key => {
                const groupSignals = groups[key];
                const m = calculateMetrics(groupSignals);
                return `
                    <tr class="hover:bg-zinc-50">
                        <td class="p-3 font-bold text-zinc-900">${key}</td>
                        <td class="p-3 font-mono">${m.totalSignals}</td>
                        <td class="p-3 text-emerald-600 font-semibold">${m.greens}</td>
                        <td class="p-3 text-rose-600 font-semibold">${m.reds}</td>
                        <td class="p-3 text-zinc-500 font-semibold">${m.voids}</td>
                        <td class="p-3 font-bold">${m.winRate}%</td>
                        <td class="p-3 font-bold ${m.roi >= 0 ? 'text-emerald-600' : 'text-rose-600'}">${m.roi}%</td>
                        <td class="p-3 font-mono font-bold text-right ${m.totalProfit >= 0 ? 'text-emerald-600' : 'text-rose-600'}">
                            ${m.totalProfit >= 0 ? '+' : ''}€${m.totalProfit.toFixed(2)}
                        </td>
                    </tr>
                `;
            }).join('');
        }

        function renderBankroll() {
            const m = calculateMetrics();

            document.getElementById('bankroll-kpi-cards').innerHTML = `
                <div class="p-4 border border-zinc-200 rounded bg-white">
                    <p class="text-xs font-semibold text-zinc-500 uppercase">Initial Bankroll</p>
                    <p class="text-xl font-black text-zinc-900 mt-1">€${parseFloat(config.initialBankroll).toFixed(2)}</p>
                </div>
                <div class="p-4 border border-zinc-200 rounded bg-white">
                    <p class="text-xs font-semibold text-zinc-500 uppercase">Total Profit</p>
                    <p class="text-xl font-black ${m.totalProfit >= 0 ? 'text-emerald-600' : 'text-rose-600'} mt-1">
                        ${m.totalProfit >= 0 ? '+' : ''}€${m.totalProfit.toFixed(2)}
                    </p>
                </div>
                <div class="p-4 border border-zinc-200 rounded bg-white">
                    <p class="text-xs font-semibold text-zinc-500 uppercase">ROI</p>
                    <p class="text-xl font-black ${m.roi >= 0 ? 'text-emerald-600' : 'text-rose-600'} mt-1">${m.roi}%</p>
                </div>
                <div class="p-4 border border-zinc-200 rounded bg-black text-white">
                    <p class="text-xs font-semibold text-zinc-400 uppercase">Current Bankroll</p>
                    <p class="text-xl font-black text-tennis-green mt-1">€${m.currentBankroll.toFixed(2)}</p>
                </div>
            `;

            renderChart();
        }

        function saveBankrollSettings(e) {
            e.preventDefault();
            config.initialBankroll = parseFloat(document.getElementById('input-initial-bankroll').value) || 0;
            config.defaultStake = parseFloat(document.getElementById('input-default-stake').value) || 0;
            saveConfig();
            renderBankroll();
        }

        function renderChart() {
            const ctx = document.getElementById('bankrollChart').getContext('2d');
            
            const settled = [...signals]
                .filter(s => s.status !== 'Pending')
                .sort((a, b) => new Date(a.date) - new Date(b.date));

            let current = parseFloat(config.initialBankroll);
            const labels = ['Início', ...settled.map((s, i) => s.date || `#${i+1}`)];
            const dataPoints = [current];

            settled.forEach(s => {
                current += calculateSignalProfit(s);
                dataPoints.push(current);
            });

            if (chartInstance) {
                chartInstance.destroy();
            }

            chartInstance = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Bankroll (€)',
                        data: dataPoints,
                        borderColor: '#000000',
                        backgroundColor: '#CCFF00',
                        borderWidth: 2,
                        tension: 0.1,
                        pointRadius: 4,
                        pointBackgroundColor: '#CCFF00',
                        pointBorderColor: '#000000'
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: { legend: { display: false } },
                    scales: {
                        x: { grid: { display: false } },
                        y: {
                            grid: { color: '#f0f0f0' },
                            ticks: { callback: function(val) { return '€' + val; } }
                        }
                    }
                }
            });
        }

        function renderStatusBadge(status) {
            if (status === 'Green') return '<span class="px-2 py-0.5 text-xs font-bold rounded bg-emerald-100 text-emerald-800 border border-emerald-300">GREEN</span>';
            if (status === 'Red') return '<span class="px-2 py-0.5 text-xs font-bold rounded bg-rose-100 text-rose-800 border border-rose-300">RED</span>';
            if (status === 'Void') return '<span class="px-2 py-0.5 text-xs font-bold rounded bg-zinc-100 text-zinc-700 border border-zinc-300">VOID</span>';
            return '<span class="px-2 py-0.5 text-xs font-bold rounded bg-amber-100 text-amber-800 border border-amber-300">PENDING</span>';
        }

        function openModal(id = null) {
            const modal = document.getElementById('signal-modal');
            const form = document.getElementById('signal-form');
            form.reset();

            if (id) {
                const signal = signals.find(s => s.id === id);
                if (signal) {
                    document.getElementById('modal-title').innerText = 'Editar Sinal';
                    document.getElementById('signal-id').value = signal.id;
                    document.getElementById('form-tournament').value = signal.tournament === 'Not provided' ? '' : (signal.tournament || '');
                    document.getElementById('form-category').value = signal.category || 'ATP';
                    document.getElementById('form-round').value = signal.round === 'Not provided' ? '' : (signal.round || '');
                    document.getElementById('form-player1').value = signal.player1 === 'Not provided' ? '' : (signal.player1 || '');
                    document.getElementById('form-player2').value = signal.player2 === 'Not provided' ? '' : (signal.player2 || '');
                    document.getElementById('form-date').value = signal.date === 'Not provided' ? '' : (signal.date || '');
                    document.getElementById('form-time').value = signal.time || '';
                    document.getElementById('form-surface').value = signal.surface || 'Hard';
                    document.getElementById('form-market').value = signal.market === 'Not provided' ? '' : (signal.market || '');
                    document.getElementById('form-selection').value = signal.selection === 'Not provided' ? '' : (signal.selection || '');
                    document.getElementById('form-odds').value = signal.odds || '';
                    document.getElementById('form-stake').value = signal.stake || config.defaultStake;
                    document.getElementById('form-confidence').value = signal.confidence === 'Not provided' ? '' : (signal.confidence || '');
                    document.getElementById('form-edge').value = signal.edge === 'Not provided' ? '' : (signal.edge || '');
                    document.getElementById('form-type').value = signal.type || 'Normal';
                    document.getElementById('form-status').value = signal.status || 'Pending';
                    document.getElementById('form-analysis').value = signal.analysis === 'Not provided' ? '' : (signal.analysis || '');
                }
            } else {
                document.getElementById('modal-title').innerText = 'Novo Sinal';
                document.getElementById('signal-id').value = '';
                document.getElementById('form-stake').value = config.defaultStake;
                document.getElementById('form-date').value = new Date().toISOString().split('T')[0];
            }

            modal.classList.remove('hidden');
        }

        function closeModal() {
            document.getElementById('signal-modal').classList.add('hidden');
        }

        function handleSignalSubmit(e) {
            e.preventDefault();

            const id = document.getElementById('signal-id').value;
            const newSignal = {
                id: id || 'sig_' + Date.now(),
                tournament: document.getElementById('form-tournament').value.trim() || 'Not provided',
                category: document.getElementById('form-category').value || 'Not provided',
                round: document.getElementById('form-round').value.trim() || 'Not provided',
                player1: document.getElementById('form-player1').value.trim() || 'Not provided',
                player2: document.getElementById('form-player2').value.trim() || 'Not provided',
                date: document.getElementById('form-date').value || 'Not provided',
                time: document.getElementById('form-time').value || '',
                surface: document.getElementById('form-surface').value || 'Not provided',
                market: document.getElementById('form-market').value.trim() || 'Not provided',
                selection: document.getElementById('form-selection').value.trim() || 'Not provided',
                odds: parseFloat(document.getElementById('form-odds').value) || 1.0,
                stake: parseFloat(document.getElementById('form-stake').value) || 0,
                confidence: document.getElementById('form-confidence').value.trim() || 'Not provided',
                edge: document.getElementById('form-edge').value.trim() || 'Not provided',
                type: document.getElementById('form-type').value,
                status: document.getElementById('form-status').value,
                analysis: document.getElementById('form-analysis').value.trim() || 'Not provided'
            };

            if (newSignal.type === 'Bet of the Day') {
                signals.forEach(s => { if (s.id !== newSignal.id && s.type === 'Bet of the Day') s.type = 'Normal'; });
            }
            if (newSignal.type === 'Bet of the Week') {
                signals.forEach(s => { if (s.id !== newSignal.id && s.type === 'Bet of the Week') s.type = 'Normal'; });
            }

            if (id) {
                const index = signals.findIndex(s => s.id === id);
                if (index !== -1) signals[index] = newSignal;
            } else {
                signals.push(newSignal);
            }

            saveSignals();
            closeModal();

            renderDashboard();
            renderSignals();
            renderBOTD();
            renderBOTW();
            renderResults();
            renderHistory();
            renderStatistics();
            renderBankroll();
        }

        function deleteSignal(id) {
            if (confirm('Eliminar este sinal?')) {
                signals = signals.filter(s => s.id !== id);
                saveSignals();
                renderSignals();
                renderDashboard();
            }
        }

        function exportData() {
            const payload = {
                signals: signals,
                config: config,
                exportedAt: new Date().toISOString()
            };
            const dataStr = "data:text/json;charset=utf-8," + encodeURIComponent(JSON.stringify(payload, null, 2));
            const downloadAnchor = document.createElement('a');
            downloadAnchor.setAttribute("href", dataStr);
            downloadAnchor.setAttribute("download", `tennis_signals_export.json`);
            document.body.appendChild(downloadAnchor);
            downloadAnchor.click();
            downloadAnchor.remove();
        }

        function importData(event) {
            const file = event.target.files[0];
            if (!file) return;

            const reader = new FileReader();
            reader.onload = function(e) {
                try {
                    const parsed = JSON.parse(e.target.result);
                    if (parsed && parsed.signals && parsed.config) {
                        signals = parsed.signals;
                        config = parsed.config;
                        saveSignals();
                        saveConfig();
                        location.reload();
                    } else {
                        alert('Ficheiro JSON inválido.');
                    }
                } catch (err) {
                    alert('Erro ao carregar o ficheiro JSON.');
                }
            };
            reader.readAsText(file);
        }

        function resetData() {
            if (confirm('Eliminar permanentemente todos os dados?')) {
                localStorage.removeItem(STORAGE_SIGNALS);
                localStorage.removeItem(STORAGE_CONFIG);
                location.reload();
            }
        }
    </script>
</body>
</html>
