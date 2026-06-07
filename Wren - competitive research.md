# Wren — Competitive Research & Strategic Analysis

Data: giugno 2026
Autore: Sisyphus (AI analysis)

---

## Market landscape

4 direct competitors in the "system-wide macOS AI autocomplete" space:

| | Cotypist | Cotabby | Typeahead | GhostType |
|---|---|---|---|---|
| **Release** | 2025 (beta), 2026 (paid) | Apr 2026 | Jun 2026 | May 2026 |
| **Stars** | N/A (closed) | 380 | N/A | ~20 |
| **Open issues** | N/A | 48 | N/A | ~5 |
| **Contributors** | 1 (Daniel Gräfe) | 4 | ~3 | 1 |
| **License** | Proprietary | AGPL-3.0 | Proprietary | MIT |
| **Language** | Swift | Swift | Swift | Swift |
| **macOS min** | 14.0 | 15.0 | 14.0 | 14.0 |
| **Apple Silicon** | Required | Required | Required | Recommended |
| **Model engine** | Qwen 2.5 1.5B (in-process) | llama.cpp (in-process) + Apple Intelligence | llama.cpp (in-process) | Any OpenAI-compatible server |

## Price comparison

| | Free tier | Individual | Multi-device |
|---|---|---|---|
| **Cotypist** | 100 words/day | $10/mo (1 device) | $15/mo (3 devices) |
| **Cotabby** | Full | Free | Free |
| **Typeahead** | No | $79 lifetime | $79 lifetime |
| **GhostType** | Full | Free | Free |
| **Wren** | Full (MIT) | Free | Free |

## Feature comparison

| Feature | Cotypist | Cotabby | Typeahead | GhostType | **Wren** |
|---|---|---|---|---|---|
| Inline completion | ✅ | ✅ | ✅ | ✅ | ✅ |
| Word-by-word accept | ✅ | ✅ | ✅ | ✅ | ✅ |
| Full-sentence accept | ✅ | ✅ | ✅ | ✅ | ✅ |
| Typo auto-correct | ✅ (v0.22) | ✅ (Apple Int.) | ❌ | ❌ | ✅ |
| Grammar correction | ❌ | ❌ | ❌ | ❌ | ✅ **unique** |
| Fluency rewrite | ❌ | ❌ | ❌ | ❌ | ✅ **unique** |
| AI Compose | ❌ | ❌ | ❌ | ❌ | ✅ **unique** |
| Smart Reply | ❌ | ❌ | ❌ | ❌ | ✅ **unique** |
| Explain/Summarize | ❌ | ❌ | ❌ | ❌ | ✅ **unique** |
| Screen context OCR | ❌ | ⚠️ optional | ❌ | ❌ | ✅ built-in |
| Per-app profiles | ✅ (Pro tier) | ❌ | ❌ | ⚠️ per-app exclusions | ✅ |
| Per-app rules | ✅ (Pro tier) | ❌ | ❌ | ❌ | ✅ |
| Multilingual | ⚠️ "try it" | ⚠️ soft prompt | ❌ | ❌ | ✅ 5 families |
| Subprocess isolation | ❌ in-process | ❌ in-process | ❌ in-process | ❌ in-process | ✅ **unique** |
| Style learning | ✅ | ❌ | ❌ | ❌ | ✅ |
| Snippet expansion | ❌ | ❌ | ❌ | ❌ | ✅ |
| Custom prompts | ❌ | ❌ | ❌ | ❌ | ✅ |
| Hallucination guard | ❌ | ❌ | ❌ | ❌ | ✅ |
| Cloud model option | ❌ local-only | ❌ local-only | ❌ local-only | ✅ (Ollama) | ✅ opt-in |
| iCloud sync | ❌ | ❌ | ❌ | ❌ | ✅ |
| Offline | ✅ | ✅ | ✅ | ✅ | ✅ |
| Open source | ❌ | ✅ (AGPL) | ❌ | ✅ (MIT) | ✅ (MIT) |

## RAM usage

| App | RAM active | RAM idle | Notes |
|---|---|---|---|
| Cotypist | 1-2.5 GB | ~500 MB | In-process model, continuous |
| Cotabby | ~1 GB | ~400 MB | In-process model, continuous |
| Typeahead | ~1 GB | ~300 MB | In-process model, continuous |
| GhostType | Depends on server | — | External LLM server |
| **Wren** | **≤1 GB** | **~30 MB (app)** | **Subprocess model, memory-mapped** |

---

## User complaints (from Reddit, TidBITS, MPU Talk, reviews)

### Cotypist complaints

**Pricing (most common)**:
- "$10/month per device for a local open-source model is absurd"
- "Free tier: 100 words/day — blown through in 5 minutes"
- "No grandfathering for beta testers"
- "Discounted first year, then full price — bait and switch feel"

**Technical**:
- "1-2.5 GB RAM — fans spin up, M1 Air unusable"
- "Slack completions stop appearing — need to restart Slack"
- "Google Docs requires enabling Accessibility mode (not documented)"
- "No text transformation — need separate grammar tool"
- "No mid-line completions (experimental only in Labs)"
- "1 device only at Plus tier — I have 2 Macs"

**Market sentiment**:
- "Open source alternatives will become viable within 6 months"
- "Hope Raycast adds this feature"
- "I'll pay for year 1 then switch to something cheaper"

### Cotabby complaints (from 48 open issues)

- #446: "Context lost on daemon restart — can't build persistent style"
- "Heap-corruption crash on caret geometry cache deinit"
- "Flickering in permission helper"
- "Double spaces when accepting suggestions"
- "Lags in Chrome/Electron apps — background polling too aggressive"
- "Only 4 contributors, development pace uncertain"

### Typeahead (too early for complaints)

Launched Jun 1, 2026. $79 lifetime. Hiten Shah. Product Hunt launch.

### GhostType (early stage)

- Manual trigger for Slack/Discord
- Requires external LLM server
- No screen context

---

## What Wren already has (code exists, may need README/docs)

### 1. Screen context OCR — non-blocking, anti-feedback loop
File: `ScreenContextProvider.swift`
- Apple Vision OCR, async background refresh
- 8-second cache → suggestion path never waits
- Auto-crops input field → no feedback loop
- TTL configurable
**Unique**: Cotypist doesn't have it at all. Cotypist has it optional. Only OpenAI Codex Chronicle does it — but cloud-processed, $100/mo.

### 2. Subprocess isolation
File: `CompletionHelper/` (separate binary)
- Model in dedicated subprocess → crash doesn't affect UI
- Memory-mapped → shared weights with Parrot
- Zero input lag from inference
**Unique**: Every competitor runs in-process.

### 3. Full product suite in one app
- Inline completion ✅
- Grammar correction ✅  
- Fluency rewrite ✅
- AI Compose ✅
- Smart Reply ✅
- Explain/Summarize ✅
- Translate ✅
- Hallucination guard ✅
**Unique**: Cotypist = autocomplete only. WunderType = correction only. Wren = both.

### 4. MIT license
**Unique**: Only GhostType matches MIT. Cotabby is AGPL. Cotypist/Typeahead = proprietary.

---

## What Wren needs (gaps vs competitors)

### 1. App compatibility list — NOT DONE
Cotypist has a `Troubleshooting` page with known app issues. Wren: nothing.
**Action**: Test Mail, Slack, Notes, Safari, Chrome, VS Code, Messages, Telegram, Outlook, Bear, Notion, Pages, TextEdit. Document results in README with icons.

### 2. Performance numbers — NOT DONE
Cotypist publishes: "1-2.5 GB RAM, 500MB Activity Monitor." Wren: nothing.
**Action**: Measure RAM (app + subprocess), CPU idle, per-keystroke latency. Publish in README.

### 3. Homebrew cask — NOT DONE
Competitors distribute via DMG. Typeahead has one-time purchase flow.
**Action**: Build automation → `.app` zipped release → PR to homebrew/cask.

### 4. MLX backend — NOT DONE
Apple MLX runs 2-3x faster than llama.cpp on Apple Silicon.
**Action**: Add `MLXLLMService.swift`, model downloads, Settings toggle.

### 5. Apple Intelligence backend — NOT DONE
Cotabby supports Apple Intelligence models (macOS 26+). Wren: no.
**Action**: Add `AppleIntelligenceService.swift` using `SystemLanguageModel` framework.

### 6. Persistent style learning — PARTIAL
Wren has `StyleProfiler` + `CompletionLearningStore`, but:
- No SQLite persistence (Cotabby issue #446)
- Cotypist uses encrypted SQLite for cross-restart persistence
**Action**: Add SQLite-backed context store with encryption.

### 7. Per-app shortcuts for correction features — PARTIAL
Wren has shortcuts for grammar/fluency/translate etc. But per-app overrides? Partial.
Cotypist has per-app enable/disable per tier.
**Action**: Per-app shortcut overrides in AppRulesTab.

### 8. Model catalog browser — NOT DONE
Cotabby added HuggingFace model browser in v0.2.0.
Wren: hardcoded model list.
**Action**: In-app model browser with search, one-click download.

---

## Unexplored ideas (no competitor does them)

### Idea 1: Write Once, Everywhere — cross-app context persistence
**Problem**: Cotypist forgets your context when you switch apps. Cotabby forgets on restart.
**Solution**: Wren already reads screen context via OCR. Persist OCR results + accepted completions across app switches. When user moves from Mail to Slack, Wren already knows the topic.

**Technical path**:
1. `ScreenContextProvider` → OCR result → `CompletionLearningStore` (persistent)
2. When app focus changes → inject previous app's context as prefix
3. User types "As I mentioned in my email…" → Wren already knows what was mentioned

**Difficulty**: Medium. All pieces exist.

### Idea 2: Automatic tone adaptation per recipient
**Problem**: Users manually set style in Cotypist. Nobody auto-detects.
**Solution**: Wren analyzes the conversation thread (via screen context). If the other party writes formally → Wren suggests formal completions. If casual → casual.

**Technical path**:
1. `ContextAnalyzer` → detect conversation partner's formality
2. `StyleProfiler` → adjust prompt instructions automatically
3. No user configuration needed

**Difficulty**: Low-Medium. Analyzer + Profiler exist, need wiring.

### Idea 3: AI snippets (hybrid deterministic + generative)
**Problem**: Snippets are either fully deterministic (TextExpander) or fully AI (Compose). Nobody mixes both.
**Solution**: User defines template `Email about {{ISSUE}} to {{NAME}}` → Wren fills placeholders using screen context + LLM.

**Technical path**:
1. `SnippetExpander` → detect AI-enabled snippets
2. `ScreenContextProvider` → fill context
3. `LLMService` → generate personalized expansion

**Difficulty**: Medium.

### Idea 4: Cloud model fallback router
**Problem**: Local models are private but dumb. Cloud models are smart but cost money. User must choose one.
**Solution**: Wren routes automatically: quick notes → local model. Important emails → cloud. Based on: app (Mail → cloud, Notes → local), text length, time of day, recipient.

**Technical path**:
1. `LLMServiceFactory` → add router logic
2. Heuristics: bundle ID, text length, `StyleProfiler` confidence
3. Settings toggle: "Auto-route" with per-app override

**Difficulty**: Low. Both services exist.

### Idea 5: Writing streak & gamification
**Problem**: Cotypist shows "words saved." Boring.
**Solution**: Daily sparkline, streak counter, "characters saved today", weekly trends.

**Technical path**:
1. `StatsStore` already tracks acceptances
2. Add streak computation
3. DashboardTab enhancement

**Difficulty**: Very Low. Data exists, only UI missing.

### Idea 6: Agent mode — "reply to this email"
**Problem**: User reads email, switches to ChatGPT, copies response, pastes. Multiple steps.
**Solution**: Wren reads email via screen context. Single shortcut → generates full reply inline. User reviews, edits if needed, sends.

**Technical path**:
1. `ScreenContextProvider` → capture email thread
2. `SmartReplyManager` + `ComposeManager` → generate full response
3. Overlay shows preview → Tab to insert

**Difficulty**: Low-Medium. Both managers exist.

### Idea 7: Dictation hybrid
**Problem**: Whisper/Superwhisper for dictation, Cotypist for typing. Two separate tools.
**Solution**: Wren also transcribes dictation (on-device via Apple Speech framework) with inline completion on top.

**Technical path**:
1. Add `DictationService` (Apple Speech framework)
2. Existing completion pipeline works on transcribed text
3. Mode toggle: Type / Dictate / Hybrid

**Difficulty**: Medium-High. New service, but Apple Speech framework is well-documented.

---

## Strategic positioning summary

### Wren's 3 unique moats (no competitor has any of these)

1. **Full product suite**: completion + correction + compose + reply + explain + translate. Cotypist = autocomplete only. WunderType = correction only. Wren = everything.

2. **Screen context as default, non-blocking**: 8s cache, async OCR, anti-feedback loop. Cotypist: no screen context. Cotabby: optional. OpenAI Codex Chronicle: $100/mo, cloud-processed.

3. **Subprocess isolation**: Model crash → subprocess restarts, app continues. Cotypist/Cotabby/Typeahead: model crash → app crash + input lag + fans.

### Market timing advantage
- Cotypist just launched paid ($10-15/mo) — users angry about pricing
- Typeahead just launched ($79 lifetime) — too early, unknown quality
- Cotabby has 48 open issues — unstable
- Apple WWDC (macOS 27) didn't announce system-wide autocomplete this year — window is open

### Risk
- Apple could Sherlock this category in macOS 28
- Grammarly could add autocomplete
- Raycast could add inline completion

### Recommendation
1. **Ship app compatibility list** (2 days) — remove doubt, build trust
2. **Publish performance numbers** (3 days) — prove subprocess advantage
3. **Homebrew cask** (1 week CI) — remove install friction
4. **Persistent style learning via SQLite** (1 week) — match Cotabby #446 ask
5. **Cloud model fallback** (3 days) — beat "local-only" limitation
6. **Writing streak dashboard** (1 day) — free dopamine
7. **Agent mode: reply to email** (1 week) — killer demo for Reddit/HN launch

Ordered by impact/effort ratio. Items 1-3 are the launch blockers for "repo of the day."
