# Klaus Kode

Claude Code, but his name is Klaus.

## Prerequisites

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) installed and on your PATH
- Python 3

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/mxdoerfler/klaus-kode/main/install.sh | bash
```

Or with Homebrew:

```bash
brew install mxdoerfler/tap/klaus-kode
```

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

## Platform support

- **macOS**: Full support (codesign + Keychain sync)
- **Linux**: Works, but credential sync is skipped (see [#1](https://github.com/mxdoerfler/klaus-kode/issues/1))
- **Windows**: Not yet supported (see [#3](https://github.com/mxdoerfler/klaus-kode/issues/3))

## License

MIT
