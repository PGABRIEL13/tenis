// ODDS API INTEGRATION MODULE
// This module handles The Odds API integration for tennis matches and odds comparison

const ODDS_CONFIG = {
  PROXY_URL: 'https://odds-api-proxy.vercel.app/api/odds', // Replace with your Vercel deployment
  CACHE_KEY: 'tennis_odds_cache_v1',
  CACHE_DURATION: 5 * 60 * 1000, // 5 minutes
  SPORTS: {
    atp: 'tennis_atp',
    wta: 'tennis_wta'
  }
};

let oddsData = [];
let oddsCache = null;
let lastOddsUpdate = null;
let oddsLoading = false;
let currentOddsFilters = {
  dateFilter: 'Today',
  tournament: '',
  category: '',
  player: '',
  market: 'h2h',
  bookmaker: ''
};

// Initialize odds section
function initializeOddsSection() {
  addOddsNavButton();
  addOddsPageSection();
  loadCachedOdds();
}

function addOddsNavButton() {
  const navContainer = document.querySelector('nav');
  if (!navContainer || document.getElementById('odds-nav-btn')) return;

  const oddsBtn = document.createElement('button');
  oddsBtn.id = 'odds-nav-btn';
  oddsBtn.className = 'nav-btn w-full flex items-center space-x-3 px-4 py-3 text-sm font-medium rounded text-zinc-300 hover:bg-zinc-900 hover:text-white transition';
  oddsBtn.setAttribute('onclick', "navigate('odds')");
  oddsBtn.setAttribute('data-page', 'odds');
  oddsBtn.innerHTML = `
    <svg class="w-4 h-4 text-tennis-green" fill="none" stroke="currentColor" viewBox="0 0 24 24">
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z"></path>
    </svg>
    <span>Tennis Odds</span>
  `;
  
  // Insert before settings button
  const settingsBtn = document.querySelector('[data-page="settings"]');
  if (settingsBtn) {
    settingsBtn.parentNode.insertBefore(oddsBtn, settingsBtn);
  } else {
    navContainer.appendChild(oddsBtn);
  }
}

function addOddsPageSection() {
  const mainContent = document.querySelector('main .p-6');
  if (!mainContent || document.getElementById('page-odds')) return;

  const oddsSection = document.createElement('section');
  oddsSection.id = 'page-odds';
  oddsSection.className = 'page-content hidden space-y-6';
  oddsSection.innerHTML = `
    <div class="flex flex-col gap-4">
      <!-- Controls -->
      <div class="border border-zinc-200 rounded p-5 bg-white space-y-4">
        <div class="flex flex-col sm:flex-row gap-4 justify-between items-start sm:items-center">
          <div class="flex flex-wrap gap-2">
            <button onclick="setOddsFilter('dateFilter', 'Today')" class="odds-filter-btn px-3 py-1.5 text-xs font-semibold rounded border border-zinc-300 bg-black text-white" data-filter="Today">Today</button>
            <button onclick="setOddsFilter('dateFilter', 'Tomorrow')" class="odds-filter-btn px-3 py-1.5 text-xs font-semibold rounded border border-zinc-300 bg-white text-zinc-700 hover:bg-zinc-50" data-filter="Tomorrow">Tomorrow</button>
            <button onclick="setOddsFilter('dateFilter', 'This Week')" class="odds-filter-btn px-3 py-1.5 text-xs font-semibold rounded border border-zinc-300 bg-white text-zinc-700 hover:bg-zinc-50" data-filter="This Week">This Week</button>
            <button onclick="setOddsFilter('dateFilter', 'All')" class="odds-filter-btn px-3 py-1.5 text-xs font-semibold rounded border border-zinc-300 bg-white text-zinc-700 hover:bg-zinc-50" data-filter="All">All</button>
          </div>
          <button onclick="refreshOdds()" id="refresh-odds-btn" class="px-4 py-2 bg-tennis-green text-black font-semibold text-sm rounded hover:bg-tennis-green-hover transition flex items-center space-x-2">
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A9.001 9.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.973 8.973 0 01-15.357-2m15.357 2H15"></path>
            </svg>
            <span>Refresh Odds</span>
          </button>
        </div>

        <div class="flex flex-col sm:flex-row gap-3">
          <input type="text" id="odds-player-search" placeholder="Search player..." oninput="setOddsFilter('player', this.value); renderOddsPage()" class="px-3 py-1.5 text-sm border border-zinc-300 rounded flex-1 focus:outline-none focus:border-black">
          <select id="odds-tournament-filter" onchange="setOddsFilter('tournament', this.value); renderOddsPage()" class="px-3 py-1.5 text-sm border border-zinc-300 rounded focus:outline-none focus:border-black">
            <option value="">All Tournaments</option>
            <option value="Wimbledon">Wimbledon</option>
            <option value="Roland Garros">Roland Garros</option>
            <option value="US Open">US Open</option>
            <option value="Australian Open">Australian Open</option>
            <option value="Masters">ATP Masters</option>
          </select>
          <select id="odds-category-filter" onchange="setOddsFilter('category', this.value); renderOddsPage()" class="px-3 py-1.5 text-sm border border-zinc-300 rounded focus:outline-none focus:border-black">
            <option value="">All Categories</option>
            <option value="ATP">ATP</option>
            <option value="WTA">WTA</option>
          </select>
        </div>

        <div class="text-xs text-zinc-500 flex justify-between items-center">
          <span id="odds-status-text">Last Updated: Not synced</span>
          <span id="odds-match-count" class="font-semibold text-zinc-700">0 matches</span>
        </div>
      </div>

      <!-- Status / Content -->
      <div id="odds-status" class="text-center py-8">
        <p class="text-zinc-400">Click "Refresh Odds" to load tennis matches from The Odds API</p>
      </div>

      <!-- Odds Grid -->
      <div id="odds-content" class="space-y-4"></div>
    </div>
  `;

  mainContent.parentNode.insertBefore(oddsSection, mainContent.nextSibling);
}

function loadCachedOdds() {
  try {
    const cached = localStorage.getItem(ODDS_CONFIG.CACHE_KEY);
    if (cached) {
      const parsedCache = JSON.parse(cached);
      if (Date.now() - parsedCache.timestamp < ODDS_CONFIG.CACHE_DURATION) {
        oddsCache = parsedCache.data;
        oddsData = oddsCache;
        lastOddsUpdate = new Date(parsedCache.timestamp);
        updateOddsStatus();
      }
    }
  } catch (e) {
    console.error('Error loading cached odds:', e);
  }
}

function cacheOdds(data) {
  try {
    localStorage.setItem(ODDS_CONFIG.CACHE_KEY, JSON.stringify({
      data: data,
      timestamp: Date.now()
    }));
    lastOddsUpdate = new Date();
    updateOddsStatus();
  } catch (e) {
    console.error('Error caching odds:', e);
  }
}

function updateOddsStatus() {
  const statusEl = document.getElementById('odds-status-text');
  if (statusEl && lastOddsUpdate) {
    const time = lastOddsUpdate.toLocaleTimeString();
    statusEl.innerText = `Last Updated: ${time}`;
  }
  
  const countEl = document.getElementById('odds-match-count');
  if (countEl) {
    const filtered = applyOddsFilters(oddsData);
    countEl.innerText = `${filtered.length} matches`;
  }
}

async function refreshOdds() {
  if (oddsLoading) return;
  
  oddsLoading = true;
  const btnEl = document.getElementById('refresh-odds-btn');
  const statusEl = document.getElementById('odds-status');
  
  if (btnEl) btnEl.disabled = true;
  if (statusEl) statusEl.innerHTML = '<div class="text-center py-8"><p class="text-zinc-600">Loading tennis matches...</p><div class="mt-2 inline-block"><div class="animate-spin h-5 w-5 border-2 border-tennis-green border-t-transparent rounded-full"></div></div></div>';

  try {
    // Fetch both ATP and WTA
    const [atpData, wtaData] = await Promise.all([
      fetchSportOdds('tennis_atp'),
      fetchSportOdds('tennis_wta')
    ]);

    const allOdds = [...(atpData || []), ...(wtaData || [])];
    
    if (allOdds.length === 0) {
      if (statusEl) statusEl.innerHTML = '<div class="text-center py-8"><p class="text-zinc-400">No tennis matches found.</p></div>';
      oddsData = [];
      return;
    }

    // Process and normalize odds
    oddsData = processOddsData(allOdds);
    cacheOdds(oddsData);
    renderOddsPage();
    
  } catch (error) {
    console.error('Error fetching odds:', error);
    handleOddsError(error);
  } finally {
    oddsLoading = false;
    if (btnEl) btnEl.disabled = false;
  }
}

async function fetchSportOdds(sport) {
  try {
    const params = new URLSearchParams({
      sport: sport,
      regions: 'us,eu,au',
      markets: 'h2h,spreads,totals',
      dateFormat: 'iso'
    });

    const response = await fetch(`${ODDS_CONFIG.PROXY_URL}?${params}`);
    
    if (!response.ok) {
      const text = await response.text();
      if (response.status === 401) throw new Error('Invalid API key');
      if (response.status === 429) throw new Error('Rate limit reached');
      throw new Error(`API Error: ${response.status} - ${text}`);
    }

    const data = await response.json();
    return data;
  } catch (error) {
    console.error(`Error fetching ${sport}:`, error);
    throw error;
  }
}

function processOddsData(rawOdds) {
  if (!Array.isArray(rawOdds)) return [];

  return rawOdds.map(event => {
    const h2hMarket = event.bookmakers?.[0]?.markets?.find(m => m.key === 'h2h');
    
    return {
      id: event.id,
      tournament: extractTournament(event.competition || event.league || 'Not provided'),
      category: detectCategory(event.competition || event.league || ''),
      player1: event.competitors?.[0]?.name || event.home_team || 'Not provided',
      player2: event.competitors?.[1]?.name || event.away_team || 'Not provided',
      date: event.commence_time?.split('T')[0] || 'Not provided',
      time: event.commence_time?.split('T')[1]?.slice(0, 5) || 'Not provided',
      surface: 'Not provided',
      bookmakers: processBookmakers(event.bookmakers || []),
      markets: event.bookmakers?.[0]?.markets || [],
      rawEvent: event
    };
  }).filter(e => e.player1 !== 'Not provided' && e.player2 !== 'Not provided');
}

function processBookmakers(bookmakers) {
  return bookmakers.map(bookmaker => ({
    name: bookmaker.title,
    lastUpdate: bookmaker.last_update,
    markets: bookmaker.markets
  }));
}

function extractTournament(competitionName) {
  if (!competitionName) return 'Not provided';
  
  const tournaments = {
    'Wimbledon': 'Wimbledon',
    'Roland Garros': 'Roland Garros',
    'US Open': 'US Open',
    'Australian Open': 'Australian Open',
    'Masters': 'ATP Masters',
    'WTA Finals': 'WTA Finals',
    'Miami': 'Miami Masters',
    'Madrid': 'Madrid Masters',
    'Rome': 'Rome Masters',
    'Monte Carlo': 'Monte Carlo Masters'
  };

  for (const [key, value] of Object.entries(tournaments)) {
    if (competitionName.includes(key)) return value;
  }

  return competitionName;
}

function detectCategory(competitionName) {
  if (!competitionName) return 'ATP';
  if (competitionName.includes('WTA')) return 'WTA';
  if (competitionName.includes('ATP')) return 'ATP';
  if (competitionName.includes('Challenger')) return 'Challenger';
  if (competitionName.includes('ITF')) return 'ITF';
  return 'ATP';
}

function getBestOdds(event, market = 'h2h') {
  const bestOdds = { player1: null, player2: null };

  event.bookmakers?.forEach(bookmaker => {
    const marketData = bookmaker.markets?.find(m => m.key === market);
    if (!marketData) return;

    marketData.outcomes?.forEach((outcome, idx) => {
      const playerKey = idx === 0 ? 'player1' : 'player2';
      const price = parseFloat(outcome.price);
      
      if (!bestOdds[playerKey] || price > bestOdds[playerKey].price) {
        bestOdds[playerKey] = {
          price: price,
          bookmaker: bookmaker.name,
          probability: (1 / price * 100).toFixed(2)
        };
      }
    });
  });

  return bestOdds;
}

function renderOddsPage() {
  const filtered = applyOddsFilters(oddsData);
  
  const oddsContainer = document.getElementById('odds-content');
  if (!oddsContainer) return;

  updateOddsStatus();

  if (filtered.length === 0) {
    oddsContainer.innerHTML = '<div class="text-center py-8"><p class="text-zinc-400">No matches match your filters.</p></div>';
    return;
  }

  let html = '';
  filtered.forEach(event => {
    const bestOdds = getBestOdds(event);
    html += renderOddsCard(event, bestOdds);
  });

  oddsContainer.innerHTML = html;
}

function renderOddsCard(event, bestOdds) {
  return `
    <div class="border border-zinc-200 rounded p-5 space-y-4 bg-white hover:border-zinc-300 transition">
      <div class="flex justify-between items-start gap-4">
        <div class="flex-1">
          <div class="text-xs text-zinc-500 space-x-2 flex flex-wrap gap-1">
            <span class="font-semibold">${event.tournament}</span>
            <span>•</span>
            <span>${event.category}</span>
          </div>
          <h3 class="text-base font-bold text-zinc-900 mt-1">${event.player1} vs ${event.player2}</h3>
          <div class="text-xs text-zinc-400 mt-1">
            <span>${event.date}</span>
            ${event.time !== 'Not provided' ? `<span class="ml-2">${event.time}</span>` : ''}
          </div>
        </div>
        <span class="text-xs px-2 py-1 bg-tennis-green text-black font-bold rounded">H2H</span>
      </div>

      <div class="grid grid-cols-2 gap-3 bg-zinc-50 p-4 rounded border border-zinc-200">
        <div class="space-y-2">
          <div class="text-xs text-zinc-500 uppercase font-semibold">Player 1</div>
          <div class="font-bold text-sm text-black truncate">${event.player1}</div>
          <div class="space-y-1">
            ${bestOdds.player1 ? `
              <div class="text-sm">
                <div class="font-mono font-bold text-emerald-600">@${bestOdds.player1.price.toFixed(2)}</div>
                <div class="text-xs text-zinc-600">${bestOdds.player1.bookmaker}</div>
                <div class="text-xs text-zinc-500">Implied: ${bestOdds.player1.probability}%</div>
              </div>
            ` : '<div class="text-xs text-zinc-400">No odds</div>'}
          </div>
        </div>
        <div class="space-y-2">
          <div class="text-xs text-zinc-500 uppercase font-semibold">Player 2</div>
          <div class="font-bold text-sm text-black truncate">${event.player2}</div>
          <div class="space-y-1">
            ${bestOdds.player2 ? `
              <div class="text-sm">
                <div class="font-mono font-bold text-emerald-600">@${bestOdds.player2.price.toFixed(2)}</div>
                <div class="text-xs text-zinc-600">${bestOdds.player2.bookmaker}</div>
                <div class="text-xs text-zinc-500">Implied: ${bestOdds.player2.probability}%</div>
              </div>
            ` : '<div class="text-xs text-zinc-400">No odds</div>'}
          </div>
        </div>
      </div>

      <div class="flex gap-2 pt-2">
        <button onclick="createSignalFromOdds('${event.id}', '${event.player1.replace(/'/g, "\\'")}', ${bestOdds.player1?.price || 'null'})" class="flex-1 px-3 py-2 bg-tennis-green text-black text-xs font-bold rounded hover:bg-tennis-green-hover transition">
          Signal P1
        </button>
        <button onclick="createSignalFromOdds('${event.id}', '${event.player2.replace(/'/g, "\\'")}', ${bestOdds.player2?.price || 'null'})" class="flex-1 px-3 py-2 bg-tennis-green text-black text-xs font-bold rounded hover:bg-tennis-green-hover transition">
          Signal P2
        </button>
        <button onclick="showOddsComparison('${event.id}')" class="flex-1 px-3 py-2 border border-zinc-300 text-zinc-700 text-xs font-bold rounded hover:bg-zinc-50 transition">
          Compare
        </button>
      </div>
    </div>
  `;
}

function showOddsComparison(eventId) {
  const event = oddsData.find(e => e.id === eventId);
  if (!event) return;

  let html = `
    <div class="space-y-6">
      <div>
        <h3 class="font-bold text-lg text-zinc-900">${event.player1} vs ${event.player2}</h3>
        <p class="text-sm text-zinc-600 mt-1">${event.tournament} • ${event.category} • ${event.date}</p>
      </div>
      
      <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
  `;

  [event.player1, event.player2].forEach((player, idx) => {
    const bookmakerOdds = [];
    event.bookmakers?.forEach(bookmaker => {
      const h2hMarket = bookmaker.markets?.find(m => m.key === 'h2h');
      const outcome = h2hMarket?.outcomes?.[idx];
      if (outcome) {
        bookmakerOdds.push({
          bookmaker: bookmaker.name,
          odds: parseFloat(outcome.price),
          probability: (1 / parseFloat(outcome.price) * 100).toFixed(2)
        });
      }
    });

    bookmakerOdds.sort((a, b) => b.odds - a.odds);
    const bestOdds = bookmakerOdds[0];

    html += `
      <div class="border border-zinc-200 rounded p-4 bg-white">
        <h4 class="font-bold text-zinc-900 mb-3 text-base">${player}</h4>
        <div class="space-y-2">
          ${bookmakerOdds.map((odd, i) => {
            const diff = i === 0 ? 0 : (bestOdds.odds - odd.odds).toFixed(3);
            return `
            <div class="flex justify-between items-center p-3 rounded ${i === 0 ? 'bg-yellow-50 border-2 border-yellow-300' : 'bg-zinc-50 border border-zinc-200'}">
              <span class="text-sm font-semibold text-zinc-700">${odd.bookmaker}</span>
              <div class="text-right">
                <div class="font-mono font-bold text-black text-base">@${odd.odds.toFixed(2)}</div>
                <div class="text-xs text-zinc-600">${odd.probability}% • ${i === 0 ? 'Best' : `−${diff}`}</div>
              </div>
            </div>
          `}).join('')}
        </div>
      </div>
    `;
  });

  html += `</div></div>`;

  const comparisonModal = document.createElement('div');
  comparisonModal.id = 'odds-comparison-modal';
  comparisonModal.className = 'fixed inset-0 bg-black/60 z-50 flex items-center justify-center p-4';
  comparisonModal.innerHTML = `
    <div class="bg-white rounded border border-zinc-300 w-full max-w-3xl max-h-[85vh] flex flex-col overflow-hidden">
      <div class="px-6 py-4 border-b border-zinc-200 flex justify-between items-center bg-zinc-50">
        <h3 class="text-base font-bold text-zinc-900">Bookmaker Odds Comparison</h3>
        <button onclick="document.getElementById('odds-comparison-modal')?.remove()" class="text-zinc-400 hover:text-black">
          <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
          </svg>
        </button>
      </div>
      <div class="p-6 overflow-y-auto">
        ${html}
      </div>
    </div>
  `;
  document.body.appendChild(comparisonModal);
}

function createSignalFromOdds(eventId, selectedPlayer, odds) {
  const event = oddsData.find(e => e.id === eventId);
  if (!event) return;

  // Pre-fill form
  document.getElementById('signal-id').value = '';
  document.getElementById('form-tournament').value = event.tournament;
  document.getElementById('form-category').value = event.category;
  document.getElementById('form-round').value = 'Not provided';
  document.getElementById('form-player1').value = event.player1;
  document.getElementById('form-player2').value = event.player2;
  document.getElementById('form-date').value = event.date;
  document.getElementById('form-time').value = event.time;
  document.getElementById('form-surface').value = 'Hard';
  document.getElementById('form-market').value = 'Match Winner';
  document.getElementById('form-selection').value = selectedPlayer;
  document.getElementById('form-odds').value = odds ? odds.toFixed(2) : '';
  document.getElementById('form-stake').value = config.defaultStake;
  document.getElementById('form-confidence').value = '';
  document.getElementById('form-edge').value = '';
  document.getElementById('form-type').value = 'Normal';
  document.getElementById('form-status').value = 'Pending';
  document.getElementById('form-analysis').value = '';

  document.getElementById('modal-title').innerText = 'Create Signal from Odds';
  openModal();
}

function applyOddsFilters(data) {
  return data.filter(event => {
    // Date filter
    if (currentOddsFilters.dateFilter !== 'All') {
      const eventDate = new Date(event.date + 'T00:00:00');
      const today = new Date();
      today.setHours(0, 0, 0, 0);
      const tomorrow = new Date(today);
      tomorrow.setDate(tomorrow.getDate() + 1);
      const weekEnd = new Date(today);
      weekEnd.setDate(weekEnd.getDate() + 7);

      if (currentOddsFilters.dateFilter === 'Today' && eventDate.getTime() !== today.getTime()) return false;
      if (currentOddsFilters.dateFilter === 'Tomorrow' && eventDate.getTime() !== tomorrow.getTime()) return false;
      if (currentOddsFilters.dateFilter === 'This Week' && (eventDate < today || eventDate > weekEnd)) return false;
    }

    // Tournament filter
    if (currentOddsFilters.tournament && !event.tournament.includes(currentOddsFilters.tournament)) return false;

    // Category filter
    if (currentOddsFilters.category && event.category !== currentOddsFilters.category) return false;

    // Player filter
    if (currentOddsFilters.player) {
      const playerLower = currentOddsFilters.player.toLowerCase();
      if (!event.player1.toLowerCase().includes(playerLower) && !event.player2.toLowerCase().includes(playerLower)) {
        return false;
      }
    }

    return true;
  });
}

function setOddsFilter(filterType, value) {
  currentOddsFilters[filterType] = value;
  
  // Update UI buttons
  if (filterType === 'dateFilter') {
    document.querySelectorAll('.odds-filter-btn').forEach(btn => {
      if (btn.dataset.filter === value) {
        btn.classList.remove('bg-white', 'text-zinc-700');
        btn.classList.add('bg-black', 'text-white');
      } else {
        btn.classList.remove('bg-black', 'text-white');
        btn.classList.add('bg-white', 'text-zinc-700');
      }
    });
  }
  
  renderOddsPage();
}

function handleOddsError(error) {
  const statusEl = document.getElementById('odds-status');
  if (!statusEl) return;

  let message = 'Unable to load odds.';
  let icon = '⚠️';
  
  const errorMsg = error.message.toLowerCase();
  if (errorMsg.includes('401') || errorMsg.includes('invalid api key')) {
    message = 'Invalid API key. Please check your configuration.';
    icon = '🔑';
  } else if (errorMsg.includes('429') || errorMsg.includes('rate limit')) {
    message = 'Rate limit reached. Please try again in a few moments.';
    icon = '⏱️';
  } else if (errorMsg.includes('timeout')) {
    message = 'Request timeout. Please try again.';
    icon = '⏳';
  } else if (errorMsg.includes('network')) {
    message = 'Network error. Check your connection.';
    icon = '📡';
  }

  statusEl.innerHTML = `<div class="text-center py-12"><div class="text-4xl mb-2">${icon}</div><p class="text-rose-600 font-semibold">${message}</p></div>`;
}

// Initialize when document loads
document.addEventListener('DOMContentLoaded', () => {
  setTimeout(() => {
    initializeOddsSection();
  }, 500);
});
