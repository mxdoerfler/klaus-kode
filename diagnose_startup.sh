#!/usr/bin/env bash
# Claude Code startup delay diagnostic
# Run from a FRESH terminal (not inside claude): bash diagnose_startup.sh
set -euo pipefail

echo "=== Claude Code Startup Diagnostic ==="
echo "Date: $(date)"
echo "Claude version: $(claude --version 2>&1)"
echo ""

# 1. Baseline: --version (should be <100ms)
echo "--- Test 1: --version (baseline) ---"
time claude --version >/dev/null 2>&1
echo ""

# 2. Interactive startup with immediate exit
echo "--- Test 2: Interactive startup (auto-exit) ---"
time echo '/exit' | claude --no-update-check 2>/dev/null
echo ""

# 3. Session metadata size
echo "--- Test 3: Session metadata ---"
echo "~/.claude/projects/ size: $(du -sh ~/.claude/projects/ 2>/dev/null | cut -f1)"
echo "Session files: $(find ~/.claude/projects/ -name '*.jsonl' 2>/dev/null | wc -l | tr -d ' ')"
echo "Largest sessions:"
find ~/.claude/projects/ -name '*.jsonl' -exec du -h {} + 2>/dev/null | sort -rh | head -5
echo ""

# 4. StatusLine check
echo "--- Test 4: StatusLine config ---"
STATUSLINE=$(grep -r '"statusLine"' ~/.claude/settings.json ~/.claude/.settings.json 2>/dev/null || echo "not found")
echo "StatusLine setting: $STATUSLINE"
echo ""

# 5. Interactive startup with statusLine disabled
echo "--- Test 5: Interactive startup (statusLine=disabled) ---"
# Temporarily rename settings to test without statusLine
if [ -f ~/.claude/settings.json ]; then
  cp ~/.claude/settings.json ~/.claude/settings.json.bak
  # Remove statusLine key
  python3 -c "
import json, sys
with open('$HOME/.claude/settings.json') as f:
    s = json.load(f)
had = 'statusLine' in s
if had:
    del s['statusLine']
    with open('$HOME/.claude/settings.json', 'w') as f:
        json.dump(s, f, indent=2)
print('disabled' if had else 'was not set')
"
  time echo '/exit' | claude --no-update-check 2>/dev/null
  # Restore
  mv ~/.claude/settings.json.bak ~/.claude/settings.json
else
  echo "No settings.json found, skipping"
fi
echo ""

# 6. Network / auth timing
echo "--- Test 6: API auth check ---"
time claude --version >/dev/null 2>&1
echo ""

echo "=== Summary ==="
echo "If Test 2 >> Test 1: delay is in REPL initialization"
echo "If Test 5 << Test 2: statusLine is a factor"
echo "If session files > 500 or size > 500MB: session bloat may contribute"
echo ""
echo "To trim old sessions (keeps last 30 days):"
echo "  find ~/.claude/projects/ -name '*.jsonl' -mtime +30 -delete"
