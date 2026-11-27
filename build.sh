#!/bin/bash
# Builds the standalone Wren.app from the shared core (the Parrot codebase, pinned as the `core`
# submodule). Wren and Parrot are the same code; the bundle identity (com.thousandflowers.wren)
# selects AppMode.wren → inline-completion feature set. See core/App/AppMode.swift.
#
# Usage: [MODEL_PATH=/path/to/model.gguf] [WREN_DMG=1] [APP_VERSION=x.y.z] ./build.sh [release|debug]
#   MODEL_PATH  GGUF bundled into the app (default: core/build-wren.sh's qwen2.5-0.5b path).
#   WREN_DMG=1  also produce core/Wren.dmg (release path).
#   APP_VERSION stamp CFBundleShortVersionString (release.yml passes the tag).
set -euo pipefail
cd "$(dirname "$0")"

if [ ! -f core/Package.swift ]; then
    echo "[*] Initialising core submodule (pinned commit)..."
    git submodule update --init --recursive core
fi

echo "[*] Building via core/build-wren.sh..."
( cd core && ./build-wren.sh "${1:-release}" )

echo "[*] Collecting Wren.app..."
rm -rf Wren.app
cp -R core/Wren.app Wren.app

echo "[✓] Wren.app ready ($(/usr/libexec/PlistBuddy -c 'Print :CFBundleIdentifier' Wren.app/Contents/Info.plist 2>/dev/null) v$(/usr/libexec/PlistBuddy -c 'Print :CFBundleShortVersionString' Wren.app/Contents/Info.plist 2>/dev/null))"
