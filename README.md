# Wren 🐦

**Instant, on-device inline completion for every macOS app.** As you type, Wren suggests the
next words in grey — press **Tab** to accept. It also fixes typos in the word you just typed.
Everything runs locally; nothing leaves your Mac.

## Features
- **Inline completion** — predictive ghost text in any text field, accept with Tab.
- **Typo fix on Tab** — misspelled last word? Tab corrects it (on-device spell check).
- **Context-aware** — reads the preceding text and, optionally, on-screen context (the
  conversation/email you're replying to) so suggestions fit, not random.
- **Learns from you** — accepted completions are remembered; your recurring phrases come back
  instantly with no model call.
- **On-device LLM** — llama.cpp running locally (a small base model); the app process itself stays
  tiny because the model runs out-of-process and is memory-mapped (shared with Parrot if both
  installed — one copy of the weights in RAM).

## Permissions
- **Accessibility** — to read the text field and insert completions.
- **Input Monitoring** — for the global Tab accept (CGEventTap).
- **Screen Recording** (optional) — only if you enable on-screen context.

## Build
```sh
./build.sh            # builds Wren.app from the shared core
```
The shared code lives in the [`core`](https://github.com/thousandflowers/Parrot) submodule
(the Parrot codebase); Wren and Parrot are one codebase, two products selected by bundle identity.

## Sibling
- [**Parrot**](https://github.com/thousandflowers/Parrot) — grammar & fluency correction for macOS.
