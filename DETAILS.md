# Details

## What it does

- Creates a patched copy of the Claude Code binary with "Claude Code" replaced by "Klaus Kode"
- Re-patches automatically when Claude Code updates (hash check)
- Syncs your existing auth credentials so you don't need to log in again (macOS)
- Preserves the API-critical system prompt identifier so nothing breaks server-side

## Uninstall

```bash
curl -fsSL https://raw.githubusercontent.com/mxdoerfler/klaus-kode/main/uninstall.sh | bash
```

Or manually: `rm ~/.local/bin/klaus && rm -rf ~/.local/share/klaus-kode`
