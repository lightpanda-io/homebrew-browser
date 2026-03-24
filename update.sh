#!/bin/bash
set -euo pipefail

DIR="$(dirname "$0")"
REPO="lightpanda-io/browser"

update() {
  local FORMULA="${DIR}/Formula/lightpanda-nightly.rb"

  RELEASE_JSON=$(curl -sf "https://api.github.com/repos/${REPO}/releases/tags/nightly")

  LATEST=$(printf '%s' "$RELEASE_JSON" | grep '"updated_at"' | head -1 | sed 's/.*"updated_at": *"\([0-9-]*\).*/\1/')
  CURRENT=$(grep '^  version ' "$FORMULA" | sed 's/.*"\(.*\)".*/\1/')

  echo "[nightly] Current: $CURRENT — Latest: $LATEST"

  if [ "$LATEST" = "$CURRENT" ]; then
    echo "[nightly] Already up to date."
    return
  fi

  echo "[nightly] Updating to $LATEST..."

  digest_for() {
    local asset_name="$1"
    printf '%s' "$RELEASE_JSON" | jq -r --arg name "$asset_name" '.assets[] | select(.name == $name) | .digest' | sed 's/^sha256://'
  }

  AARCH64_MACOS_SHA=$(digest_for "lightpanda-aarch64-macos")
  X86_MACOS_SHA=$(digest_for "lightpanda-x86_64-macos")
  AARCH64_LINUX_SHA=$(digest_for "lightpanda-aarch64-linux")
  X86_LINUX_SHA=$(digest_for "lightpanda-x86_64-linux")

  OLD_AARCH64_MACOS_SHA=$(grep -A1 'aarch64-macos"' "$FORMULA" | grep sha256 | sed 's/.*sha256 "\([^"]*\)".*/\1/')
  OLD_X86_MACOS_SHA=$(grep -A1 'x86_64-macos"' "$FORMULA" | grep sha256 | sed 's/.*sha256 "\([^"]*\)".*/\1/')
  OLD_AARCH64_LINUX_SHA=$(grep -A1 'aarch64-linux"' "$FORMULA" | grep sha256 | sed 's/.*sha256 "\([^"]*\)".*/\1/')
  OLD_X86_LINUX_SHA=$(grep -A1 'x86_64-linux"' "$FORMULA" | grep sha256 | sed 's/.*sha256 "\([^"]*\)".*/\1/')

  sed -i '' "s|version \"${CURRENT}\"|version \"${LATEST}\"|" "$FORMULA"
  sed -i '' "s|${OLD_AARCH64_MACOS_SHA}|${AARCH64_MACOS_SHA}|" "$FORMULA"
  sed -i '' "s|${OLD_X86_MACOS_SHA}|${X86_MACOS_SHA}|" "$FORMULA"
  sed -i '' "s|${OLD_AARCH64_LINUX_SHA}|${AARCH64_LINUX_SHA}|" "$FORMULA"
  sed -i '' "s|${OLD_X86_LINUX_SHA}|${X86_LINUX_SHA}|" "$FORMULA"

  echo "[nightly] Done. Review changes with: git diff"
}

update
