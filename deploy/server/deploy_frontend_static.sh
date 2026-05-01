#!/usr/bin/env bash

set -euo pipefail

APP_DIR="${APP_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)}"
WEB_ROOT="${WEB_ROOT:-/var/www/cloudflarefrontend}"
BUILD_COMMAND="${BUILD_COMMAND:-npm run build}"
BUILD_DIR="${BUILD_DIR:-dist}"
NPM_BIN="${NPM_BIN:-npm}"

cd "$APP_DIR"

if [ -f "package-lock.json" ]; then
  "$NPM_BIN" ci
else
  "$NPM_BIN" install
fi

/bin/bash -lc "$BUILD_COMMAND"

if [ ! -d "$APP_DIR/$BUILD_DIR" ]; then
  echo "Build output directory not found: $APP_DIR/$BUILD_DIR"
  exit 1
fi

mkdir -p "$WEB_ROOT"
rsync -a --delete "$APP_DIR/$BUILD_DIR"/ "$WEB_ROOT"/

sudo -n nginx -t
sudo -n systemctl reload nginx

