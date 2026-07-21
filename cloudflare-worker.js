/**
 * Cloudflare Worker - Tennis Signals Proxy
 * 
 * Este worker funciona como proxy para The Odds API
 * Protege a API Key e faz cache das respostas
 * 
 * Deploy: copie para https://workers.cloudflare.com/
 */

const ODDS_API_KEY = 'YOUR_API_KEY_HERE'; // Substitua pela sua API Key
const ODDS_API_URL = 'https://api.the-odds-api.com/v4/sports';

// CORS Headers
const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'GET, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type',
};

async function handleRequest(request) {
  // Handle CORS preflight
  if (request.method === 'OPTIONS') {
    return new Response(null, { headers: corsHeaders });
  }

  if (request.method !== 'GET') {
    return new Response('Method not allowed', { status: 405 });
  }

  try {
    // Extrair parâmetros da URL
    const url = new URL(request.url);
    const sport = url.searchParams.get('sport') || 'tennis_atp';
    const regions = url.searchParams.get('regions') || 'us';
    const markets = url.searchParams.get('markets') || 'h2h';

    // Criar chave de cache
    const cacheKey = `odds-${sport}-${regions}-${markets}`;
    const cache = caches.default;

    // Tentar obter do cache (5 minutos)
    const cached = await cache.match(cacheKey);
    if (cached) {
      const response = new Response(cached.body, {
        headers: {
          ...corsHeaders,
          'Content-Type': 'application/json',
          'X-Cache': 'HIT',
        },
      });
      return response;
    }

    // Fazer request à API
    const apiUrl = `${ODDS_API_URL}/${sport}/events?apiKey=${ODDS_API_KEY}&regions=${regions}&markets=${markets}`;
    
    const apiResponse = await fetch(apiUrl);

    if (!apiResponse.ok) {
      // Se houver erro na API
      if (apiResponse.status === 401) {
        return new Response(
          JSON.stringify({ error: 'Invalid API key' }),
          { 
            status: 401,
            headers: { ...corsHeaders, 'Content-Type': 'application/json' }
          }
        );
      }
      if (apiResponse.status === 429) {
        return new Response(
          JSON.stringify({ error: 'Rate limit reached' }),
          { 
            status: 429,
            headers: { ...corsHeaders, 'Content-Type': 'application/json' }
          }
        );
      }
      throw new Error(`API error: ${apiResponse.status}`);
    }

    const data = await apiResponse.json();

    // Cachear resposta
    const responseToCache = new Response(JSON.stringify(data), {
      headers: {
        'Content-Type': 'application/json',
        'Cache-Control': 'public, max-age=300', // 5 minutos
      },
    });

    await cache.put(cacheKey, responseToCache);

    // Retornar resposta
    return new Response(JSON.stringify(data), {
      headers: {
        ...corsHeaders,
        'Content-Type': 'application/json',
        'X-Cache': 'MISS',
      },
    });

  } catch (error) {
    console.error('Worker error:', error);
    return new Response(
      JSON.stringify({ error: 'Unable to fetch odds' }),
      { 
        status: 500,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' }
      }
    );
  }
}

// Evento padrão do Worker
addEventListener('fetch', event => {
  event.respondWith(handleRequest(event.request));
});
