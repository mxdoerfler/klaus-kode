#!/usr/bin/env bash
# Klaus Kode uninstaller
set -euo pipefail

echo "Uninstalling Klaus Kode..."

# Remove the wrapper script
rm -f "$HOME/.local/bin/klaus"
echo "Removed ~/.local/bin/klaus"

# Remove cached patched binary
if [ -d "$HOME/.local/share/klaus-kode" ]; then
  rm -rf "$HOME/.local/share/klaus-kode"
  echo "Removed ~/.local/share/klaus-kode/"
fi

# Remove Keychain entry (macOS only)
if [[ "$OSTYPE" == darwin* ]]; then
  ACCT="$(id -un)"
  security delete-generic-password -a "$ACCT" -s "Klaus Kode -credentials" &>/dev/null && \
    echo "Removed Keychain entry" || true
fi

echo "Done. Claude Code itself is untouched."
