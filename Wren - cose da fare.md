# Wren — Cose da fare

## Stato attuale (già nel README dopo aggiornamenti)
- ✅ Supporto multilingue documentato (5 famiglie, 21 lingue)
- ✅ Context-aware completions con esempio
- ✅ Anti-subscription messaging (No subscription. No account. No cloud.)
- ✅ Language picker nelle impostazioni (Advanced → Language)
- ✅ Subprocess isolation evidenziato come vantaggio performance

---

## 1. App compatibility list (manca)

**Cosa**: Una sezione "Works in" nel README che elenchi app testate con icone.

**Perché**: Utenti Cotabby/Cotypist si lamentano che autocomplete non funziona in Mail, Slack, Chrome. Una lista trasparente è un differenziatore.

**Da fare**:
- [ ] Testare sistematicamente ogni app (Mail, Slack, Notes, Safari, Chrome, VS Code, Terminal, Messages, Telegram, Outlook, Bear, Notion, Pages, TextEdit)
- [ ] Documentare risultato: ✅ Full / ⚠️ Partial / ❌ No
- [ ] Aggiungere sezione nel README con tabella e icone
- [ ] Il codice `Surface/` ha già backends NativeAX, ChromiumAX, Universal — i test servono per compilare la matrice

---

## 2. MLX model support (manca)

**Cosa**: Supporto per modelli in formato MLX (Apple framework) in alternativa a llama.cpp.

**Perché**: MLX corre 2-3× più veloce di llama.cpp su Apple Silicon. Richiesto esplicitamente su Reddit.

**Da fare**:
- [ ] Aggiungere dipendenza `mlx-swift` o bridge C
- [ ] Nuovo servizio `MLXLLMService.swift` parallelo a `LocalLLMService.swift`
- [ ] Integrare in `LLMServiceFactory.swift`
- [ ] Selezionabile in Settings → Models (MLX vs llama.cpp)
- [ ] Scaricare modelli in formato MLX via `ModelManager`
- [ ] Test di latenza comparativo llama.cpp vs MLX

---

## 3. Homebrew cask (manca)

**Cosa**: `brew install --cask wren` per installazione一键.

**Perché**: Abbatte la barriera d'ingresso. Ogni repo macOS che trenda offre Homebrew.

**Da fare**:
- [ ] Build automation in GitHub Actions che produce `.app` zippato signed
- [ ] Upload su GitHub Releases
- [ ] PR su `homebrew/cask` per aggiungere cask
- [ ] Aggiornare README: "Install via Homebrew" section

---

## 4. Performance metrics (da raccogliere)

**Cosa**: Numeri reali di RAM, CPU, latenza da pubblicare nel README.

**Perché**: Competitor soffrono di spike CPU e ventole. Wren ha architettura migliore (subprocess) ma nessun numero a supporto.

**Da fare**:
- [ ] Strumentare `LatencyTracer` per esportare metriche (es. p50/p95 in ms)
- [ ] Misurare RAM totale (app + helper subprocess) su idle e active
- [ ] Misurare CPU% su idle con completion attivo
- [ ] Registrare latenza per-keystroke p50/p95/p99
- [ ] Pubblicare nel README in sezione "Performance" dedicata
- [ ] Confronto architetturale con Cotabby/Cotypist (subprocess vs in-process)

---

## Priorità suggerita

| # | Item | Sforzo | Impatto utenti |
|---|---|---|---|
| 1 | App compatibility list | ⏱️ 2-3h test + 30min README | Alto |
| 2 | Performance metrics | ⏱️ 4-6h strumentazione + misura | Alto |
| 3 | Homebrew cask | ⏱️ 1-2g CI + PR | Alto |
| 4 | MLX backend | ⏱️ 1-2 settimane engineering | Medio |
