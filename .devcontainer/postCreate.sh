#!/usr/bin/env bash
set -euo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"

# System packages: nvim (convenience) + build toolchain for GitNexus native deps
sudo apt-get update -qq
sudo apt-get install -y -qq neovim build-essential python3

# Mounted volumes (gh creds, ~/.claude) come up root-owned on first run; hand them
# to the user before anything writes into them (gitnexus hooks, settings copy, login)
sudo chown -R "$(id -u):$(id -g)" "$HOME/.config" "$HOME/.claude"

# GitNexus: global CLI, register MCP + hook adapter + skills
GITNEXUS_SKIP_OPTIONAL_GRAMMARS=1 npm install -g gitnexus
gitnexus setup || echo "gitnexus setup skipped"

# Claude Code via the native installer: installs to ~/.local/bin (user-writable) and
# self-updates in the background, avoiding the npm-prefix permission error
curl -fsSL https://claude.ai/install.sh | bash

# Claude Code settings: copy the attached config into place on creation
mkdir -p "$HOME/.claude"
cp --remove-destination "$HERE/claude-settings.json" "$HOME/.claude/settings.json"

# zsh: ensure the native install is on PATH + AWS login reminder
cat >> "$HOME/.zshrc" <<'EOF'

# ---- devcontainer ----
export PATH="$HOME/.local/bin:$PATH"
if [[ -o interactive ]]; then
  if ! aws sts get-caller-identity >/dev/null 2>&1; then
    print -P "%F{yellow}AWS: not logged in. Run 'aws sso login' (or 'aws configure').%f"
  fi
fi
# ---- /devcontainer ----
EOF
