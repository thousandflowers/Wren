# Wren 🐦

**Instant, on-device inline completion for every macOS app.** As you type, Wren suggests the next words in grey — press **Tab** to accept. It also fixes typos in the word you just typed. **Everything runs on your Mac by default; nothing leaves your machine.** Wren can optionally use an OpenAI-compatible API if you prefer a cloud model, but this is entirely opt-in — no setup, no cloud dependency out of the box.

**No subscription. No account. No cloud. Just download and type.**

---

## Why I built this

I wanted to replace Cotypist — the inline completion app I was using — with something better. But the real insight came from Parrot: I was already collecting data about how I write, what corrections I accept, what I reject. That data was sitting locally on my Mac, doing nothing after a correction was applied.

Wren is what happens when you take that data and use it for prediction instead of correction. Same model, same local inference, same privacy — but pointing forward instead of backward.

---

## Features

- **Inline completion** — predictive ghost text in any text field, accept with Tab.
- **Typo fix on Tab** — misspelled last word? Tab corrects it (on-device spell check).
- **Custom accept keys** — choose your own keys for partial (word-by-word) and full (entire suggestion) accept.
- **Context-aware completions** — Wren reads what's on screen above your text field via on-device OCR: the email thread you're replying to, the chat conversation, the ticket description. Suggestions match the actual context, not generic text. Automatically crops out your input field to prevent feedback loops. Runs in the background with zero latency impact.
- **Personalization** — optional style instructions (e.g. "friendly and concise") with a strength slider so suggestions match your voice.
- **Style profiling** — Wren learns your writing fingerprint (formality, vocabulary, sentence length) from accepted completions and steers the model toward your natural voice.
- **Snippet expansion** — define custom abbreviations; Tab replaces them with full text.
- **Learning** — accepted completions are remembered via variable-order n-gram keys, so your recurring phrases come back instantly with no model call.
- **Dashboard** — live stats showing acceptance rate, characters saved, completions shown vs. dismissed, tracking since first use.
- **Corpus seeding** — import your own writing (emails, notes) to seed the learning store with your voice from day one.
- **On-device LLM** — llama.cpp running locally (a small base model). The model runs in a **dedicated helper subprocess** isolated from the UI, so inference never causes input lag, stutter, or fan spinup. Memory-mapped (shared with Parrot if both installed — one copy of the weights in RAM).
- **Hallucination guard** — topic-drift rejection prevents the model from suggesting off-topic content; post-context overlap rejection filters stale OCR garbage.
- **Multilingual** — auto-detects the language you are writing in and adapts grammar correction, fluency rewrites, and completion style accordingly. Works with any language the model supports.

> **Cloud?** Wren includes a built-in model and runs fully on-device with zero configuration. An OpenAI-compatible endpoint (OpenAI, Ollama, or any provider) can be enabled manually in Settings → Completion → Model — this is **strictly opt-in**. The default, recommended path never touches the network.

---

## Supported Languages

Wren detects your writing language automatically (via Apple's `NLLanguageRecognizer`) and tailors grammar correction, fluency rewrites, and completion to the language family:

| Family | Languages | Grammar instructions |
|---|---|---|
| **Latin** | English, Italian, French, Spanish, German, Portuguese, Dutch, & more | Verb agreement, noun/article gender/number, required prepositions |
| **CJK** | Chinese, Japanese, Korean, Thai | Particles, measure words, aspect markers, collocations |
| **Slavic** | Polish, Russian, Bulgarian, Czech, Ukrainian, Serbian, & more | Case declension, verb aspect (perfective/imperfective), gender agreement |
| **Nordic** | Swedish, Danish, Norwegian, Finnish, Icelandic | Noun gender agreement, verb conjugation |
| **Arabic** | Arabic, Persian, Hebrew, Urdu | Verb-subject agreement, broken plurals, definite article usage |

Completions, grammar checks, and rewrites stay in your language — every prompt includes an explicit instruction to never translate. Language defaults to your macOS locale; no configuration needed. Override it per-preset or per custom rule in Settings.

---

## Context-Aware Completions

Most inline completion tools suggest generic text based only on what you typed so far. Wren goes further: it reads the content **above** your text field.

**Real example**: You're replying to an email about a delayed project deadline. Wren's local OCR captures the email thread visible on screen, crops out your reply field (no feedback loop), and feeds that context into the model. The suggestion says *"I'll make sure the team prioritizes this — we'll have an update by end of day"* instead of generic *"Thank you for your email"*.

This works in any app — Mail, Slack, Notes, Safari, Chrome, VS Code — because Wren uses Apple Vision OCR at the system level, not API hooks per app.

Key engineering details:
- **Non-blocking**: OCR runs off the main thread with an 8-second cache. The suggestion path never waits on a screen capture.
- **Anti-feedback loop**: The input field is automatically cropped from the capture so the model never re-reads its own output.
- **Optional**: Requires Screen Recording permission; degrades gracefully to text-only when not granted.

---

## Permissions

- **Accessibility** — to read the text field and insert completions.
- **Input Monitoring** — for the global Tab intercept (CGEventTap).
- **Screen Recording** (optional) — only if you enable on-screen context (Settings → Completion).

---

## Architecture

Wren and [Parrot](https://github.com/thousandflowers/Parrot) are **one codebase, two products**. The shared code lives in the [`core`](https://github.com/thousandflowers/Parrot) submodule; the bundle identity (`com.thousandflowers.wren`) selects `AppMode.wren` at runtime.

```
Wren.app/
└── core/                  ← git submodule → github.com/thousandflowers/Parrot
    ├── App/               ─ AppDelegate, AppMode, Constants
    ├── Core/              ─ LLM services, correction engines, completion pipeline
    │   └── Completion/    ─ CompletionProvider, Postprocessor, LearningStore, ScreenContext
    ├── UI/                ─ SwiftUI views: Settings, Dashboard, MenuBar, OverlayWindow
    ├── Infra/             ─ Preferences, ModelManager, ServerManager, iCloud sync
    ├── Accessibility/     ─ AX bridge, app detection
    └── CompletionHelper/  ─ llama.cpp subprocess (isolated, out-of-process model inference)
```

### Completion pipeline

1. **AX context** — reads the text field content before and after the caret via Accessibility API.
2. **Screen context (optional)** — OCRs the on-screen text above the caret via Apple Vision for conversational grounding.
3. **Inference** — a dedicated subprocess runs llama.cpp with KV-cache reuse for sub-second continuations.
4. **Post-processing** — strips markup, deduplicates, collapses repetitions, rejects hallucinations (topic-drift guard, path/URL guard, post-context overlap guard).
5. **Overlay** — a borderless NSPanel floats ghost text at the caret position (first word bolded for partial-accept targeting).
6. **Learning** — accepted completions feed into a variable-order n-gram store for instant future matches.

---

## Build

```sh
./build.sh   # builds Wren.app from the shared core (latest main)
```

The shared code lives in the [`core`](https://github.com/thousandflowers/Parrot) submodule, which **tracks `main`**. `build.sh` runs `git submodule update --remote`, so **one commit to the core (Parrot repo) updates both Parrot and Wren** — no per-app pointer bump.

### Manual build from source

```sh
git clone https://github.com/thousandflowers/Wren.git
cd Wren
git submodule update --init --recursive
swift build
```

---

## Sibling

- [**Parrot**](https://github.com/thousandflowers/Parrot) — grammar & fluency correction for macOS.

---

## Requirements

- macOS 14.0+
- Apple Silicon or Intel Mac
- ~2 GB free RAM for the local model (shared with Parrot if both installed)

---

## License

[MIT](LICENSE).
