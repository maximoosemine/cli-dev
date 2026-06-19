#!/usr/bin/env bash
set -euo pipefail

ws="$(pwd)"

# "set up" = a devcontainer config exists in this folder
is_set_up() { [[ -f .devcontainer/devcontainer.json || -f .devcontainer.json ]]; }

# "running" = a dev container for this workspace is already up
# (the CLI/VS Code label the container with the host workspace path)
is_running() { [[ -n "$(docker ps -q --filter "label=devcontainer.local_folder=$ws" 2>/dev/null)" ]]; }

if ! is_set_up; then
  dc="${DC_CONFIG:?set DC_CONFIG to your devcontainer template dir}"
  dc="${dc%/}"           # strip trailing slash
  [[ -d "$dc" ]] || { echo "DC_CONFIG dir not found: $dc" >&2; exit 1; }

  mkdir -p .devcontainer
  cp -r "$dc/." .devcontainer/   # copy source contents into ./.devcontainer

  # keep the copied config out of git locally
  if [[ -d .git ]]; then
    mkdir -p .git/info
    grep -qxF '.devcontainer/' .git/info/exclude 2>/dev/null \
      || echo '.devcontainer/' >> .git/info/exclude
  fi
fi

is_running || devcontainer up --workspace-folder .
devcontainer exec --workspace-folder . zsh
