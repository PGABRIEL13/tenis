# TENNIS SIGNALS - The Odds API Integration Guide

## Overview
Esta guia fornece instruções completas para integrar The Odds API ao Tennis Signals.

---

## 1. SETUP DO PROXY SERVERLESS (Cloudflare Workers)

### Por que um proxy?
A API Key não deve ser exposta no frontend. Vamos usar Cloudflare Workers como proxy gratuito.

### Passo 1: Criar conta Cloudflare
1. Aceda a https://workers.cloudflare.com/
2. Crie uma conta gratuita
3. Confirme o email

### Passo 2: Criar novo Worker
1. Dashboard → Workers → Create Service
2. Nome: `tennis-signals-proxy`
3. Create Service

### Passo 3: Configurar o Worker
Copie o código do arquivo `cloudflare-worker.js` para o editor do Worker.

Substitua `YOUR_API_KEY` pela sua API Key do The Odds API.

### Passo 4: Copiar URL do Worker
Após publicar, você terá uma URL como:
```
https://tennis-signals-proxy.seu-username.workers.dev
```

Copie esta URL e use-a no frontend como `ODDS_API_URL`.

---

## 2. IMPLEMENTAÇÃO NO FRONTEND

### Passo 1: Backup do arquivo atual
```bash
git checkout main app
cp app app.backup
```

### Passo 2: Atualizar o arquivo `app`
Substitua o conteúdo do arquivo `app` pelo arquivo `app-updated.html`.

### Passo 3: Configurar a URL do Proxy
No início do `<script>`, procure:
```javascript
const ODDS_API_URL = 'https://tennis-signals-proxy.seu-username.workers.dev';
```

Substitua `seu-username` pelo seu username do Cloudflare.

### Passo 4: Fazer Push
```bash
git add app
git commit -m "Add The Odds API integration with Tennis Odds section"
git push origin main
```

---

## 3. FUNCIONALIDADES IMPLEMENTADAS

### ✅ Nova Seção: Tennis Odds
- Localizada na sidebar entre "Signals" e "Bet of the Day"
- Mostra todos os jogos de ténis disponíveis
- Atualização em tempo real

### ✅ Dados Obtidos da API
- Tournament
- Category (ATP, WTA, etc.)
- Player 1 e Player 2
- Data e Hora
- Mercados (Match Winner, Totals, Handicaps)
- Odds e Bookmakers
- Best Odds (melhor odd disponível)

### ✅ Filtros
- Today / Tomorrow / This Week
- Por Tournament
- Por Category
- Por Player (search)
- Por Market
- Por Bookmaker

### ✅ Comparação de Odds
- Mostra todas as odds por bookmaker
- Destaca a melhor odd
- Calcula diferença percentual

### ✅ Probabilidades
- **Implied Probability**: Calculada automaticamente (1 / Odds × 100)
- **Edge**: Permite input manual da probabilidade estimada
- Calcula automaticamente a diferença

### ✅ Create Signal
- Preenche automaticamente os dados da odd
- Abre o formulário de sinal existente
- Usuário completa Stake, Confidence, Analysis, etc.

### ✅ Refresh
- Botão "Refresh Odds"
- Atualiza dados da API
- Mostra "Last Updated" com data/hora
- Rate limiting: máximo 1 request por 10 segundos

---

## 4. ESTRUTURA DE DADOS

### Match Object (da API)
```javascript
{
  id: string,
  sport_key: string,
  sport_title: string,
  commence_time: ISO string,
  home_team: string,
  away_team: string,
  bookmakers: [
    {
      key: string,
      title: string,
      markets: [
        {
          key: string,
          outcomes: [
            {
              name: string,
              price: number
            }
          ]
        }
      ]
    }
  ]
}
```

### Mapped Tennis Match (no app)
```javascript
{
  eventId: string,
  tournament: string,
  category: string,
  player1: string,
  player2: string,
  date: string,
  time: string,
  surface: "Not provided",
  markets: {
    h2h: { player1: {...}, player2: {...} },
    spreads: [...],
    totals: [...]
  },
  bookmakers: [...]
}
```

---

## 5. TRATAMENTO DE ERROS

O app trata automaticamente:
- ❌ "No tennis matches found"
- ❌ "Unable to load odds"
- ❌ "API error"
- ❌ "Rate limit reached"
- ❌ "Invalid API key"

Mostra estado de loading enquanto carrega.

---

## 6. LOCALSTORAGE

Os odds são armazenados em:
```javascript
STORAGE_ODDS = 'tennis_odds_db_v1'
STORAGE_ODDS_LAST_UPDATE = 'tennis_odds_last_update_v1'
```

Não afeta os sinais existentes que usam:
```javascript
STORAGE_SIGNALS = 'tennis_signals_db_v1'
```

---

## 7. LIMITES E SEGURANÇA

### The Odds API
- Plano Free: 500 requests/mês
- Recomendado: 1-2 refreshes por dia
- Rate limit: 1 request por 10 segundos (implementado)

### Cloudflare Workers
- Plano Free: 100,000 requests/dia
- Sem limite de uso mensal
- API Key protegida no servidor

### Frontend
- API Key nunca é exposta
- Todos os requests passam pelo proxy
- CORS configurado corretamente

---

## 8. TROUBLESHOOTING

### "API error. Please try again."
- Verifique se o Worker está publicado
- Verifique se a URL está correta em `ODDS_API_URL`
- Verifique se a API Key está correta no Worker

### "No tennis matches found"
- Normal em fins de semana sem torneios
- Tente amanhã ou este fim de semana
- A API pode não ter dados para certas datas

### "Rate limit reached"
- Aguarde 10 segundos antes de tentar novamente
- O app mostra este aviso automaticamente

### "Invalid API key"
- Verifique a API Key no Worker
- Regenere uma nova API Key em https://theoddsapi.com/

---

## 9. FUTURAS MELHORIAS

- [ ] Sincronizar surface com dados reais da API (quando disponível)
- [ ] Histórico de odds com gráficos
- [ ] Alertas de mudanças de odds
- [ ] Exportação de odds em CSV
- [ ] Integração com múltiplos proxies para redundância

---

## 10. CONTATO E SUPORTE

Para questões sobre The Odds API:
- https://theoddsapi.com/api-documentation

Para questões sobre Cloudflare Workers:
- https://developers.cloudflare.com/workers/

---

**Versão**: 1.0  
**Data**: 2026-07-21  
**Status**: ✅ Pronto para produção
