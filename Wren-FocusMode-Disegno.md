# Wren — Focus Mode: Research + Design + Implementazione

Data: giugno 2026
Stato: spec completo, pronti per coding

---

## Indice
1. [Cross-Domain Research Synthesis](#1-cross-domain-research-synthesis)
2. [ADHD/Neurodivergent Tools Deep Dive](#2-adhdneurodivergent-tools-deep-dive)
3. [Focus Mode — Feature Design](#3-focus-mode--feature-design)
4. [Codebase Implementation Notes](#4-codebase-implementation-notes)
5. [Strategic Positioning](#5-strategic-positioning)

---

## 1. Cross-Domain Research Synthesis

```
┌────────────────────────────────────────────────────────────────┐
│  WREN FOCUS MODE — convergence di 4 domini di ricerca          │
├────────────────────────────────────────────────────────────────┤
│                                                                │
│  WRITING SURVEY     ADHD RESEARCH      RSI/ERGONOMIA           │
│  ┌──────────────┐   ┌──────────────┐   ┌──────────────┐        │
│  │• Blank page  │   │• Task        │   │• 6-8 ore     │        │
│  │  syndrome    │   │  paralysis   │   │  typing/giorno│        │
│  │• Perfection- │   │• Working     │   │• Dictation   │        │
│  │  ism loop    │   │  memory      │   │  frammentato │        │
│  │• Testo lungo │   │  overflow    │   │• 60% meno    │        │
│  │• Struttura   │   │• Time        │   │  keystrokes  │        │
│  │  povera      │   │  blindness   │   │  possibile   │        │
│  └──────┬───────┘   └──────┬───────┘   └──────┬────────┘       │
│         │                  │                  │                │
│         └──────────────────┼──────────────────┘                │
│                            ▼                                   │
│                ┌──────────────────────┐                        │
│                │   WREN FOCUS MODE    │                        │
│                │                      │                        │
│                │ Raw Draft + Timer    │                        │
│                │ + Streak + Dictation │                        │
│                │ + Focus Lock + Mood  │                        │
│                └──────────────────────┘                        │
│                            ▲                                   │
│         ┌──────────────────┼──────────────────┐                │
│         │                  │                  │                │
│  AI WRITING CRISIS   CODE-SWITCHING   COMPETITOR LANDSCAPE     │
│  ┌──────────────┐   ┌──────────────┐   ┌──────────────┐        │
│  │• 63% editing │   │• 60% pop.    │   │• ADHD        │        │
│  │  AI output   │   │  multilingue │   │  Novelist    │        │
│  │• 95% umano  │   │• 70% dicono  │   │• JustWrite   │        │
│  │  richiesto   │   │  autocorrect │   │• Hearth      │        │
│  │• 47% testo   │   │  rovina     │   │• StimPlanner │        │
│  │  artificiale │   │  messaggi   │   │• Edda        │        │
│  └──────────────┘   └──────────────┘   └──────────────┘        │
└────────────────────────────────────────────────────────────────┘
```

### Key Numbers (da Writing at Work Survey 2026)
| Problema | % | Soluzione Focus Mode |
|---|---|---|
| Testo troppo lungo | 42% | Raw draft → editing separato (prima scrivi, poi tagli) |
| Blank page syndrome | 37% | Brain dump mode + timer che abbassa l'attivazione |
| Tono sbagliato | 24% | Focus Mode silenzia correction → nessun "consiglio tono" |
| Struttura povera | 21% | Dopo draft: struttura guidata opzionale |
| Mancanza di fiducia | 21% | Streak + celebrazioni → feedback positivo immediato |

### Key Numbers (da AI Writing Crisis Survey — 1,165 writer)
- **63%** passa più tempo a editare AI che a scrivere da zero
- **95%** dei clienti chiede prova di contenuto umano
- **47%** dice "testo artificiale" è il problema #1 dei contenuti AI
- **25%** ha considerato di lasciare la professione per l'AI

**→ Wren è già posizionato perfettamente: AI assiste, non sostituisce.**
**→ Focus Mode ESTREME questo posizionamento: "a volte l'AI deve ZITTA."**

---

## 2. ADHD/Neurodivergent Tools Deep Dive

### Mappa Competitor (ADHD writing/focus — giugno 2026)

| Tool | Focus timer | Streak | Raw draft | Brain dump | Voice in | Gamification | Costo | Piattaforma |
|---|---|---|---|---|---|---|---|---|
| **ADHD Novelist** | ✅ | ✅ | ❌ | ❌ | ❌ | ✅ (mood goals) | $60/yr | Web |
| **JustWrite** | ✅ (kiosk) | ❌ | ✅ (forward) | ❌ | ❌ | ❌ | $30 LT | macOS |
| **Hearth** | ❌ | ✅ | ❌ | ❌ | ❌ | ✅ (streak) | $10/mo | Web |
| **StimPlanner** | ✅ | ✅ | ❌ | ✅ | ❌ | ✅ (XP/level) | Freemium | Web |
| **PlanMyDay** | ✅ | ✅ | ❌ | ✅ | ✅ | ✅ | Freemium | Web |
| **DoneFlow** | ✅ | ✅ | ❌ | ✅ | ✅ (pro) | ✅ (confetti) | Freemium | Web |
| **Ordísio** | ✅ | ❌ | ❌ | ✅ | ✅ | ❌ | Freemium | Web |
| **Edda** | ✅ (sprint) | ✅ | ✅ (blindwrite) | ❌ | ✅ (voice) | ❌ | $60 LT | Desktop |
| **Beside** | ✅ | ✅ | ❌ | ❌ | ❌ | ✅ (streak) | Free | iOS/macOS |
| **BuckleTime** | ✅ | ✅ | ❌ | ❌ | ❌ | ✅ (points) | Free | Web |
| **iPromise** | ✅ (AI buddy) | ❌ | ❌ | ❌ | ❌ | ❌ | ? | macOS |
| **Obsidian Writing Studio** | ✅ | ✅ | ✅ (draft mode) | ❌ | ❌ | ✅ (log) | Free | macOS/plugin |

### Pattern che emergono

1. **Nessuno unifica autocomplete + focus mode.** Hearth ha tab-complete MA non ha focus timer/raw draft. Edda ha blindwrite MA non ha AI completion. ADHD Novelist ha streak MA non ha AI.

2. **Body doubling è un trend enorme** (Beside, Focusmate, BuckleTime, Flow Club, Flown, Deepwrk) — ma nessuno lo ha integrato in un writing tool. Possibile integrazione futura.

3. **Voice input è il nuovo standard** per tool ADHD (PlanMyDay, DoneFlow, Edda, Ordísio) — Wren ha già DictationService.

4. **Gamification è standard** in tutti i tool ADHD. Streak, XP, livelli, confetti.

5. **Nessuno fa raw draft come feature esplicita** tranne Edda (Blindwrite Mode) e Obsidian Writing Studio. Ma Edda costa $60 LT e non ha AI.

### La gap che Wren può colmare

```
┌─────────────────────────────────────────────────────────────────┐
│                       LA GAP NEL MERCATO                        │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   HA AI          HA FOCUS TIMER    HA RAW DRAFT    HA STREAK    │
│                                                                 │
│   Hearth (web)   ADHD Novelist     Edda (desktop)   ADHD Novel.│
│   Cotypist (mac) JustWrite (mac)   Obsidian WS      Hearth      │
│   Cotabby (mac)  StimPlanner       JustWrite        StimPlanner │
│   Typeahead      DoneFlow                           JustWrite   │
│                                                                 │
│   ❌ NESSUNO FA TUTTE E 4                                         │
│   ❌ NESSUNO HA 4 SU MAC                                        │
│   ❌ NESSUNO INTEGRA AI + FOCUS MODE                            │
│                                                                 │
│   → WREN PUÒ ESSERE IL PRIMO                                    │
└─────────────────────────────────────────────────────────────────┘
```

### Psicologia dello Scrivente ADHD (da ricerca scientifica)

1. **Blank page syndrome** → non è pigrizia, è **task paralysis** da eccesso di opzioni. Soluzione: ridurre le opzioni a ZERO. Timer + raw draft = "scrivi qualsiasi cosa per 25 minuti".
2. **Perfectionism loop** → riscrivere la prima frase 30 volte. Soluzione: **blindwrite mode** (Edda lo fa) — il testo svanisce mentre scrivi, non puoi editare.
3. **Working memory overflow** → hai l'idea ma la perdi prima di scriverla. Soluzione: **brain dump** (Wren registra, poi organizza).
4. **Time blindness** → pensi siano 10 minuti, ne passano 2 ore. Soluzione: **timer visivo** + notifica gentile.
5. **Inconsistency** → 1000 parole un giorno, zero per una settimana. Soluzione: **streak forgiante** (perdere la streak fa male abbastanza da farti scrivere).
6. **Low-energy days** → non tutti i giorni sono da 1000 parole. Soluzione: **mood goals adattivi** — oggi è da 100 parole? Ok.

---

## 3. Focus Mode — Feature Design

### 3.1 Vision

> **Focus Mode è un layer sopra Wren che, quando attivo, trasforma l'esperienza di scrittura: spegne l'AI quando serve (raw draft), aggiunge struttura quando manca (timer, streak), e accoglie la voce quando le mani sono stanche (dictation).**

### 3.2 Modalità (4 stati)

```
┌────────────────────────────────────────────────────────────────┐
│  FOCUS MODE — STATE MACHINE                                    │
├────────────────────────────────────────────────────────────────┤
│                                                                │
│  OFF (default)  ←→  RAW DRAFT  ←→  FOCUS SESSION  ←→  DONE   │
│  Wren normale        AI spenta      Timer + streak    Recap   │
│  completion +        correction     + raw draft       Stats   │
│  correction          spenta         + AI spenta       Streak  │
│                      solo scrivi                        +1    │
│                                                                │
│  RAW DRAFT → si può avviare un FOCUS SESSION da lì            │
│  FOCUS SESSION → include RAW DRAFT automaticamente            │
└────────────────────────────────────────────────────────────────┘
```

### 3.3 Raw Draft Mode (feature standalone)

**Cosa fa**:
- Disabilita TUTTI i suggerimenti inline (completion)
- Disabilita TUTTE le correzioni (grammar, fluency, typo fix)
- Disabilita compose/rewrite
- Opzionale: "forward-only" — niente backspace (come JustWrite)
- Opzionale: "blindwrite" — il testo svanisce dopo N righe (come Edda)
- Toggle nel menu bar + shortcuts

**UX**:
```
┌────────────────────────────────────────────┐
│  🖊️ Raw Draft ● ○○○                        │
│                                            │
│  write whatever you want                    │
│  no suggestions no corrections              │
│  just you and the words                     │
│                                            │
│  [esc to exit]     [start focus session ▸]  │
└────────────────────────────────────────────┘
```

**Implementazione**: `CompletionController.isEnabled = false` + `TextCheckCoordinator.suspend()` + `RealtimeMonitor.stop()`

### 3.4 Focus Session (la feature principale)

Un timer con obiettivo che, mentre scorre, mette Wren in raw draft mode.

**Parametri**:
- Durata: 5 / 10 / 15 / 25 / 45 / custom minuti
- Goal opzionale: word count target
- Mood pre-session: 😰 😊 😐 (influenza la celebrazione post)
- Soundscape opzionale: silence / coffee shop / rain / lofi
- Body doubling: future (opzionale, presenza virtuale)

**Flux UX**:

```
┌─────────────┐      ┌─────────────┐      ┌─────────────┐
│  START      │ ──►  │  SESSION    │ ──►  │  RECAP      │
│             │      │             │      │             │
│ Pick timer  │      │ Raw draft   │      │ Word count  │
│ Pick mood   │      │ Countdown   │      │ Time spent  │
│ Pick goal   │      │ Word count  │      │ Streak +1   │
│             │      │ No AI       │      │ Celebration │
│ [Start]     │      │ [Pause]     │      │ [Save]      │
│             │      │ [Stop]      │      │ [Continue]  │
└─────────────┘      └─────────────┘      └─────────────┘
```

**UI del timer (sempre visibile)**:
```
┌────────────────────────────────────────────┐
│  ⏱ 15:23    🔥 7-day streak               │
│  ████████░░░░ 147/200 parole               │
│  🖊️ Raw draft (AI suggestions paused)      │
│  [|| pause]  [■ stop]                      │
└────────────────────────────────────────────┘
```

Il timer è un **floating overlay** stile JustWrite, sempre in primo piano, ma non bloccante (posso spostarlo, non è kiosk mode). Il kiosk mode di JustWrite è opzionale.

### 3.5 Streak Tracking

**Regole** (basate su ADHD Novelist + Hearth + BuckleTime):
- Uno "writing day" = almeno 1 focus session completata OPPURE X parole scritte (con Wren ovunque)
- Streat = giorni consecutivi
- **Forgiving streak** (da ADHD Novelist): 1 "freeze" a settimana — se salti un giorno non perdi la streak
- Mood tracking opzionale: dopo ogni sessione, scegli un'emoji

**Dati da salvare**:
```swift
struct FocusStats: Codable {
    var totalSessions: Int = 0
    var totalMinutes: Int = 0
    var totalWordsWritten: Int = 0
    var currentStreak: Int = 0
    var longestStreak: Int = 0
    var lastSessionDate: Date?
    var dailyLog: [Date: DailyEntry] = [:]
    var freezesUsedThisWeek: Int = 0
}

struct DailyEntry: Codable {
    var sessions: Int
    var minutes: Int
    var words: Int
    var mood: String?  // emoji
}
```

**Persistenza**: JSON file in Application Support (stile StatsStore) o UserDefaults.

### 3.6 Celebration System

Basato su DoneFlow + StimPlanner:

| Evento | Feedback |
|---|---|
| Sessione completata | ✅ "Great! 147 words in 15 min" |
| Nuovo streak (≥3) | 🔥 "3-day streak!" |
| Nuovo longest streak | 🏆 "New record!" |
| Mood basso ma sessione fatta | 💪 "You did it even though it was hard — that counts double" |
| Freeze usato | ❄️ "Streak saved. No worries." |

**Senza esagerare** — niente confetti esplosivi, niente notifiche intrusive. Un toast gentile nel menu bar.

### 3.7 Menu Bar Integration

Nuova sezione in MenuBarView:

```
Toggle Section (existing)
─────────────────────────────────
Inline completion  [switch]
─────────────────────────────────
FOCUS ───────────────────────────
Raw draft mode     [switch]
Start session ▸    15 min
                    25 min
                    45 min
                    custom…
Fire streak: 7 days 🔥
─────────────────────────────────
```

### 3.8 Dashboard Tab — Expanded

Aggiungere al DashboardTab esistente una sezione Focus:

```
USAGE (existing)
─────────────────────
Completions shown: 1234
Accepted: 987
...

FOCUS ─────────────────────
Sessions completed: 47
Total writing time: 18h 23m
Words in focus: 12,450
Current streak: 7 days 🔥
Longest streak: 14 days
┌─────────────────────────┐
│   M  T  W  T  F  S  S   │
│   █  █  ▓  █  █  █  ▓   │ <- heatmap
│   45 23 12 67 89 34 56   │ <- words
└─────────────────────────┘
```

### 3.9 Settings Tab — New Section

In `CompletionTab` o nuova `FocusTab`:

```
FOCUS MODE
────────────────────────────────────────────────
Default session duration: [25 minutes ▼]
Default sound: [Silence ▼]
Break reminder every: [30 minutes]
Forward-only mode (no backspace): [switch]
Blindwrite (text fades): [switch]
Kiosk mode (no escape): [switch]
Streak freeze per week: [1]

CELEBRATIONS
────────────────────────────────────────────────
Session complete toast: [switch]
Streak milestone: [switch]
Sound effects: [switch]
```

### 3.10 Shortcuts (da aggiungere a ShortcutConfig)

```
⌥⌘R    — Toggle raw draft mode
⌥⌘S    — Start/pause focus session
⌥⌘D    — Toggle dictation (focus mode)
```

---

## 4. Codebase Implementation Notes

### 4.1 Stato Attuale del Codebase

```
core/
├── App/
│   ├── AppMode.swift          → Mode enum (parrot/wren). Facile estendere.
│   ├── AppDelegate.swift      → Entry point
│   └── Constants.swift        → UserDefaults keys, bundleID
│
├── Core/
│   ├── Completion/
│   │   ├── CompletionController.swift  → loop suggerimenti. Gate: isEnabled
│   │   ├── StatsStore.swift            → stats JSON per completion. Pattern per focus stats
│   │   └── CompletionLearningStore     → learning n-gram (non serve per focus)
│   │
│   ├── DraftDetector.swift    → Già rileva bozze vs prosa. RIUSA per raw draft mode
│   ├── DictationService.swift → SFSpeechRecognizer funzionante. RIUSA per focus mode
│   ├── RealtimeMonitor.swift  → AX observer. Da sospendere in raw draft
│   └── TextCheckCoordinator   → Correction. Da sospendere in raw draft
│
├── Infra/
│   ├── PreferencesStore.swift → Tutti i toggle. @Observable. AGGIUNGI focus prefs qui
│   └── PreferencesCache.swift → Caching layer (se serve)
│
├── UI/
│   ├── MenuBarView.swift      → Menu principale. AGGIUNGI sezione Focus
│   ├── DashboardTab.swift     → Stats view. AGGIUNGI focus stats
│   ├── CompletionTab.swift    → Settings per completion. AGGIUNGI focus settings
│   ├── FloatingEditor.swift   → Finestra con dictation. PATTERN per focus window
│   ├── SpeechController.swift → TTS. Non toccare
│   ├── CompletionOverlayWindow.swift  → Ghost overlay pattern. RIUSA per timer overlay
│   └── SettingsView.swift     → Settings tabs container
```

### 4.2 Files Nuovi Necessari

| File | Cosa contiene | Basato su |
|---|---|---|
| `core/Core/FocusMode.swift` | FocusMode enum (off, rawDraft, session) | AppMode.swift |
| `core/Core/FocusStatsStore.swift` | Stats persistenza + streak logic | StatsStore.swift |
| `core/Core/FocusTimer.swift` | Timer logic con Task.sleep | CompletionController debounce |
| `core/UI/FocusOverlayWindow.swift` | Timer overlay fluttuante | CompletionOverlayWindow |
| `core/UI/FocusSessionView.swift` | SwiftUI view del timer + stats | FloatingEditorView |
| `core/UI/FocusTab.swift` | Settings tab per focus mode | CompletionTab.swift |
| (modifica) `core/UI/MenuBarView.swift` | Nuova sezione Focus | — |
| (modifica) `core/UI/DashboardTab.swift` | Focus stats nella dashboard | — |
| (modifica) `core/Core/Completion/CompletionController.swift` | Gate per raw draft | — |

### 4.3 Modifiche a File Esistenti

**`PreferencesStore.swift`** — Aggiungere:
```swift
var focusModeEnabled: Bool {
    get { bool("focusModeEnabled", default: false) }
    set { set(newValue, for: "focusModeEnabled") }
}
var focusDefaultDuration: Int {
    get { int("focusDefaultDuration", fallback: 25) }
    set { set(newValue, for: "focusDefaultDuration") }
}
var focusForwardOnly: Bool {
    get { bool("focusForwardOnly", default: false) }
    set { set(newValue, for: "focusForwardOnly") }
}
var focusBlindwrite: Bool {
    get { bool("focusBlindwrite", default: false) }
    set { set(newValue, for: "focusBlindwrite") }
}
var focusStreakFreeze: Int {
    get { int("focusStreakFreeze", fallback: 1) }
    set { set(newValue, for: "focusStreakFreeze") }
}
// + shortcut config per focus toggle, session start
```

**`CompletionController.swift`** — Già ha `isEnabled` gate. In raw draft:
```swift
// In textChanged():
guard isEnabled, !FocusMode.shared.isRawDraft else { return }
```

**`RealtimeMonitor.swift`** — Sospendere AX observer durante raw draft:
```swift
func suspend() { /* stop AX notifications */ }
func resume() { /* restart AX notifications */ }
```

### 4.4 Architettura Timer

Pattern da `CompletionController` (debounce con Task.sleep):

```swift
@MainActor
final class FocusTimer: ObservableObject {
    @Published var state: FocusState = .idle
    @Published var elapsedSeconds: Int = 0
    @Published var wordsWritten: Int = 0

    private var timerTask: Task<Void, Never>?

    enum FocusState: Equatable {
        case idle
        case running(duration: Int, startTime: Date)
        case paused(elapsed: Int, duration: Int)
        case completed(elapsed: Int, words: Int, duration: Int)
    }

    func start(durationMinutes: Int) {
        state = .running(duration: durationMinutes * 60, startTime: .now)
        wordsWritten = 0
        timerTask = Task { [weak self] in
            while !Task.isCancelled {
                try? await Task.sleep(for: .seconds(1))
                self?.tick()
            }
        }
    }

    func pause() {
        guard case .running(let duration, let start) = state else { return }
        let elapsed = Int(Date().timeIntervalSince(start))
        state = .paused(elapsed: elapsed, duration: duration)
        timerTask?.cancel()
    }

    func stop() { timerTask?.cancel(); state = .idle }

    private func tick() {
        guard case .running(let duration, let start) = state else { return }
        let elapsed = Int(Date().timeIntervalSince(start))
        if elapsed >= duration { complete(); return }
        state = .running(duration: duration, startTime: start)
        // Notify via objectWillChange per second
    }
}
```

### 4.5 Dictation Integration

`DictationService` esiste già e funziona. In focus mode:

```swift
// FocusSessionView:
DictationBar(dictation: dictationService)
// Mostra la trascrizione in tempo reale
// Al stop: testo trascritto → editor
```

### 4.6 Streak Logic

```swift
actor FocusStatsStore {
    static let shared = FocusStatsStore()

    func recordSession(words: Int, minutes: Int) {
        let today = Calendar.current.startOfDay(for: .now)
        var entry = dailyLog[today] ?? .init()
        entry.sessions += 1
        entry.minutes += minutes
        entry.words += words
        dailyLog[today] = entry
        updateStreak()
        save()
    }

    private func updateStreak() {
        let calendar = Calendar.current
        var streak = 0
        var date = calendar.startOfDay(for: .now)
        var freezesUsed = 0

        while streak < 365 {  // safety limit
            if dailyLog[date] != nil {
                streak += 1
                date = calendar.date(byAdding: .day, value: -1, to: date)!
            } else if freezesUsed < streakFreeze {
                // freeze: salta questo giorno
                freezesUsed += 1
                date = calendar.date(byAdding: .day, value: -1, to: date)!
            } else {
                break
            }
        }
        currentStreak = streak
        if streak > longestStreak { longestStreak = streak }
    }
}
```

### 4.7 Raw Draft Gate — Dove Mettere i Guard

| Feature | Come disabilitarla | Dove |
|---|---|---|
| Completion (ghost) | `CompletionController.isEnabled = false` | `FocusMode.isRawDraft` guard in `textChanged()` |
| Grammar correction | `PreferencesStore.autoCheckEnabled = false` | O `RealtimeMonitor.suspend()` |
| Fluency correction | `TextCheckCoordinator` sospeso | `FocusMode.isRawDraft` guard nei coordinator |
| Compose/rewrite | Shortcut disabilitati | Shortcut handler check `FocusMode.isRawDraft` |
| Typo fix | `CompletionController` skip | Già dentro `CompletionController.textChanged()` |
| Dictation | **NON disabilitare** — è voluto | Anzi, highlight in raw draft |

### 4.8 Scoring Prioritization per Implementatione

```
P0 (core, ship first):
├── FocusTimer (timer + overlay)
├── RawDraft toggle (CompletionController gate)
├── FocusStatsStore (streak + stats)
└── MenuBarView section

P1 (polish):
├── Celebration system (toast)
├── DashboardTab expanded (focus stats)
└── Settings tab (FocusTab)

P2 (stretch):
├── Mood tracking
├── Blindwrite mode
├── Forward-only mode
├── Soundscapes
├── Dictation shortcut in focus mode
└── Body doubling (future)

P3 (icebox):
├── Kiosk mode
├── Team standards
└── Code-switching integration
```

---

## 5. Strategic Positioning

### La Tesi

> **Wren non compete nella categoria "autocomplete app".**
>
> Cotypist compete con Cotabby. Typeahead compete con SuperComplete.
> Wren compete in una categoria che **non esiste ancora**:
> **"writing OS"** — un tool che unifica completamento, correzione,
> focus, dettatura, e motivazione in un ecosistema coerente.

### Come Focus Mode Cambia la Categoria

```
SENZA FOCUS MODE:                  CON FOCUS MODE:
                                   
Wren = autocomplete app            Wren = writing ecosystem
         │                                    │
         ▼                                    ▼
  "scrive mentre scrivi"            "ti aiuta a scrivere MEGLIO"
  AI always on                      AI when YOU want it
  correction sempre                 correction quando serve
  zero supporto executive           struttura per ADHD brain
  niente motivazione                streak + celebrazioni
  niente breakout timer             timer integrato
  niente dictation                  dettatura integrata
```

### Perché Questa Mossa è Vincente

1. **Nessun competitor** ha 4/4: AI + focus + streak + dictation. Hearth ha AI e streak ma no focus timer. JustWrite ha focus ma no AI. ADHD Novelist ha streak e focus ma no AI. Edda ha quasi tutto ma no AI completion.

2. **Blocca l'uscita** per Cotypist/Cotabby di aggiungere focus mode: loro sono puri autocomplete, aggiungere un timer + streak + raw draft richiederebbe riscrittura dell'architettura UX.

3. **Fidelizzazione**: streak + abitudine timer + flusso raw-draft → switching cost alto. Non si tratta di "quale autocomplete è più veloce" ma "quale tool ti ha aiutato a scrivere 10.000 parole questa settimana".

4. **Differenziazione PR**: "Wren non è solo un autocomplete — è il primo writing OS per ADHD e scrittori professionisti."

5. **Posizionamento B2B**: "Wren aiuta il tuo team a scrivere meglio" diventa più credibile quando hai mode che insegnano buone abitudini.

### Messaggio di Lancio (bozza)

> **Wren Focus Mode. Speak your draft. Timer your sprint. Track your streak.**
>
> Per anni gli autocomplete tool ti hanno aiutato a scrivere.
> Ma a volte il problema non è "cosa scrivere dopo" — è "come iniziare".
> O "come continuare". O "come non cancellare tutto dopo 3 parole".
>
> Focus Mode spegne l'AI quando serve silenzio,
> accende il timer quando serve struttura,
> e festeggia quando arrivi a 7 giorni di fila.
>
> Raw draft, brain dump, dettatura, streak tracker.
> Nient'altro ti serve per scrivere.

---

## Appendice A: Riferimenti

### Tool ADHD analizzati
- ADHD Novelist (adhdnovelist.com) — mood goals, streak, focus timer
- JustWrite (justwrite.ink) — kiosk mode, forward-only, forced breaks
- Hearth (hearth.sh) — AI tab-complete + streak + reminders
- Edda (edda.ink) — blindwrite, sprint timer, streak, dictation
- StimPlanner (stimplanner.com) — XP, streak, pomodoro, body doubling
- PlanMyDay (planmyday.me) — brain dump, voice input, gamification
- DoneFlow (doneflow.ai) — resistance tracking, confetti, focus mode
- Ordísio (ordisio.com) — brain dump, AI organization, focus timer
- Beside (App Store) — body doubling senza camera
- BuckleTime (buckletime.com) — body doubling con streak
- iPromise (launly.com) — AI buddy nel notch, body doubling
- Obsidian Writing Studio (GitHub: writerP-777) — draft/edit/review mode, sprint timer, streak log

### Ricerca scientifica
- Rose, M. "Rigid Rules, Inflexible Plans, and the Stifling of Language" — writer's block come rigidità cognitiva
- Burkley, M. "Got Writer's Block? Here's Your Cure" (Psychology Today) — 4 tipi di writer's block
- Frontiers in Psychology (2026) — self-efficacy, anxiety, e strategie di scrittura
- Springer (2026) — writing anxiety e well-being negli accademici
- Cambridge — behavioral-cognitive treatment of writer's block

### Survey
- Writing at Work Survey 2026 (71 professionisti)
- AI Writing Crisis Survey 2025-2026 (1,165 writer professionisti)
