#!/usr/bin/env bash
# Klaus Kode installer
# Usage: curl -fsSL https://raw.githubusercontent.com/mxdoerfler/klaus-kode/main/install.sh | bash
set -euo pipefail

REPO="https://raw.githubusercontent.com/mxdoerfler/klaus-kode/main"
INSTALL_DIR="$HOME/.local/bin"

echo "Installing Klaus Kode..."

# Check prerequisites
if ! command -v claude &>/dev/null; then
  echo "Error: Claude Code not found. Install it first: https://docs.anthropic.com/en/docs/claude-code" >&2
  exit 1
fi

if ! command -v python3 &>/dev/null; then
  echo "Error: python3 not found." >&2
  exit 1
fi

# Download and install
mkdir -p "$INSTALL_DIR"
curl -fsSL "$REPO/klaus" -o "$INSTALL_DIR/klaus"
chmod +x "$INSTALL_DIR/klaus"

# Check PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
  echo ""
  echo "Warning: $INSTALL_DIR is not in your PATH."
  echo "Add this to your shell profile:"
  echo "  export PATH=\"$INSTALL_DIR:\$PATH\""
  echo ""
fi

# Verify
if "$INSTALL_DIR/klaus" --version &>/dev/null; then
  echo "Installed successfully. Run 'klaus' to start."
else
  echo "Installed to $INSTALL_DIR/klaus but verification failed."
  echo "Try running 'klaus' manually to see what's wrong."
fi
