#!/bin/bash
# Builds Wren.app from the shared core (the Parrot codebase, pinned as the `core` submodule).
# Wren and Parrot are the same code; the bundle identity (com.thousandflowers.wren) selects
# AppMode.wren → inline-completion feature set. See core/App/AppMode.swift.
set -euo pipefail
cd "$(dirname "$0")"

echo "[*] Syncing core submodule..."
git submodule update --init --recursive

echo "[*] Building via core/build-app.sh..."
( cd core && ./build-app.sh "${1:-release}" )

echo "[*] Collecting Wren.app..."
rm -rf Wren.app
cp -R core/Wren.app Wren.app

echo "[✓] Wren.app ready ($(/usr/libexec/PlistBuddy -c 'Print :CFBundleIdentifier' Wren.app/Contents/Info.plist 2>/dev/null))"
