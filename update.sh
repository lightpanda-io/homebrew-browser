#!/bin/bash
# Update the formulas from the GitHub releases.
#
# Usage:
#   ./update.sh            update both formulas
#   ./update.sh nightly    update lightpanda-nightly from the nightly release
#   ./update.sh <tag>      update lightpanda from the release <tag>
#   ./update.sh latest     update lightpanda from the latest tagged release
#
# When GITHUB_OUTPUT is set (GitHub Actions), it writes the step outputs:
# changed, formula, current, latest.
set -euo pipefail

DIR="$(dirname "$0")"
REPO="lightpanda-io/browser"
ASSETS="lightpanda-aarch64-macos lightpanda-x86_64-macos lightpanda-aarch64-linux lightpanda-x86_64-linux"

output() {
  if [ -n "${GITHUB_OUTPUT:-}" ]; then
    echo "$1" >> "$GITHUB_OUTPUT"
  fi
}

# update <formula> <release tag>
update() {
  local NAME="$1"
  local TAG="$2"
  local FORMULA="${DIR}/Formula/${NAME}.rb"
  local RELEASE CURRENT LATEST ASSET SHA BEFORE

  RELEASE=$(curl -sf "https://api.github.com/repos/${REPO}/releases/tags/${TAG}")

  if [ "$TAG" = "nightly" ]; then
    LATEST=$(echo "$RELEASE" | jq -r '.updated_at' | sed 's/-/./g; s/T/./; s/://g; s/Z$//')
  else
    LATEST="$TAG"
  fi
  CURRENT=$(grep '^  version ' "$FORMULA" | sed 's/.*"\(.*\)".*/\1/')

  echo "[${NAME}] Current: $CURRENT — Latest: $LATEST"

  # Read all digests first, so an incomplete release leaves the formula untouched.
  declare -A SHAS
  for ASSET in $ASSETS; do
    SHA=$(echo "$RELEASE" | jq -r --arg name "$ASSET" '.assets[] | select(.name == $name) | .digest | sub("^sha256:"; "")')
    if [ -z "$SHA" ] || [ "$SHA" = "null" ]; then
      echo "[${NAME}] Error: no digest for ${ASSET} in release ${TAG}." >&2
      exit 1
    fi
    SHAS[$ASSET]="$SHA"
  done

  BEFORE=$(cat "$FORMULA")
  sed -i "s|^  version \".*\"|  version \"${LATEST}\"|" "$FORMULA"
  for ASSET in $ASSETS; do
    # The sha256 line comes right after the url line of the asset.
    sed -i "/\/${ASSET}\"/{n;s|sha256 \"[^\"]*\"|sha256 \"${SHAS[$ASSET]}\"|}" "$FORMULA"
  done

  output "formula=${NAME}"
  output "current=${CURRENT}"
  output "latest=${LATEST}"

  if [ "$BEFORE" = "$(cat "$FORMULA")" ]; then
    echo "[${NAME}] Already up to date."
    output "changed=false"
    return
  fi

  echo "[${NAME}] Updated from $CURRENT to $LATEST. Review changes with: git diff"
  output "changed=true"
}

latest_tag() {
  local TAG
  TAG=$(curl -sf "https://api.github.com/repos/${REPO}/releases/latest" | jq -r '.tag_name')
  # The nightly release is not a prerelease, so it could be returned as latest.
  if [ -z "$TAG" ] || [ "$TAG" = "null" ] || [ "$TAG" = "nightly" ]; then
    echo "[lightpanda] Error: invalid latest release tag '${TAG}'." >&2
    exit 1
  fi
  echo "$TAG"
}

case "${1:-}" in
  "")
    # The step outputs can describe only one formula.
    if [ -n "${GITHUB_OUTPUT:-}" ]; then
      echo "Error: a tag is required in GitHub Actions." >&2
      exit 1
    fi
    update lightpanda-nightly nightly
    LATEST_TAG=$(latest_tag)
    update lightpanda "$LATEST_TAG"
    ;;
  nightly)
    update lightpanda-nightly nightly
    ;;
  latest)
    LATEST_TAG=$(latest_tag)
    update lightpanda "$LATEST_TAG"
    ;;
  *)
    LATEST_TAG=$(latest_tag)
    if [ "$1" != "$LATEST_TAG" ]; then
      echo "[lightpanda] Skip: ${1} is not the latest release (${LATEST_TAG})."
      output "changed=false"
      exit 0
    fi
    update lightpanda "$1"
    ;;
esac
