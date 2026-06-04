# Wren 🐦

**Instant, on-device inline completion for every macOS app.** As you type, Wren suggests the
next words in grey — press **Tab** to accept. It also fixes typos in the word you just typed.
Everything runs locally; nothing leaves your Mac.

## Features
- **Inline completion** — predictive ghost text in any text field, accept with Tab.
- **Typo fix on Tab** — misspelled last word? Tab corrects it (on-device spell check).
- **Screen context** — reads on-screen text above the caret via local OCR (the conversation or
  email you are replying to) so suggestions fit, not random. Automatically crops out your input
  field to prevent feedback loops.
- **Personalization** — optional style instructions (e.g. "friendly and concise") with a strength
  slider so suggestions match your voice.
- **Snippet expansion** — define custom abbreviations; Tab replaces them with full text.
- **Dashboard** — live stats showing acceptance rate, characters saved, completions shown vs.
  dismissed, tracking since first use.
- **Learns from you** — accepted completions are remembered; your recurring phrases come back
  instantly with no model call.
- **On-device LLM** — llama.cpp running locally (a small base model); the app process itself stays
  tiny because the model runs out-of-process and is memory-mapped (shared with Parrot if both
  installed — one copy of the weights in RAM).

## Permissions
- **Accessibility** — to read the text field and insert completions.
- **Input Monitoring** — for the global Tab accept (CGEventTap).
- **Screen Recording** (optional) — only if you enable on-screen context (Settings → Completion).

## Build
```sh
./build.sh            # builds Wren.app from the shared core (latest main)
```
The shared code lives in the [`core`](https://github.com/thousandflowers/Parrot) submodule, which
**tracks `main`**. `build.sh` runs `git submodule update --remote`, so **one commit to the core
(Parrot repo) updates both Parrot and Wren** — no per-app pointer bump. Wren and Parrot are one
codebase, two products selected by bundle identity (`com.thousandflowers.wren` → AppMode.wren).

## Sibling
- [**Parrot**](https://github.com/thousandflowers/Parrot) — grammar & fluency correction for macOS.
