#!/usr/bin/env bash
# Sorts local git branches into willDelete.tsv and evaluateForDeletion.tsv.
# Columns (tab-separated): branch  last-commit-date  reason
set -euo pipefail

ME="Max Stevens"          # committer name to match
MASTER="master"
WILL_DELETE="willDelete.tsv"
EVALUATE="evaluateForDeletion.tsv"

git fetch --all --prune

: > "$WILL_DELETE"
: > "$EVALUATE"

current=$(git symbolic-ref --quiet --short HEAD || true)
month_ago=$(date -d "1 month ago" +%s 2>/dev/null || date -v-1m +%s)

last_date() { git log -1 --format='%cI' "$1"; }

# true if ME is committer on any commit between master and the branch tip
i_am_on() {
  local base range
  base=$(git merge-base "$MASTER" "$1" 2>/dev/null || true)
  range="$1"; [ -n "$base" ] && range="$base..$1"
  git log --format='%cn' "$range" | grep -qxF "$ME"
}

# merged if it's an ancestor of master, OR every branch-only commit subject
# also appears on master after the merge-base (i.e. was cherry-picked)
is_merged() {
  local base masters s
  git merge-base --is-ancestor "$1" "$MASTER" && return 0
  base=$(git merge-base "$MASTER" "$1" 2>/dev/null || true)
  [ -z "$base" ] && return 1
  masters=$(git log --format='%s' "$base..$MASTER")
  while IFS= read -r s; do
    grep -qxF "$s" <<< "$masters" || return 1
  done < <(git log --format='%s' "$base..$1")
  return 0
}

add() { printf '%s\t%s\t%s\n' "$2" "$(last_date "$2")" "$3" >> "$1"; }

while read -r b; do
  [ "$b" = "$MASTER" ] && continue
  [ "$b" = "$current" ] && continue

  track=$(git for-each-ref --format='%(upstream:track,nobracket)' "refs/heads/$b")

  # --- pruned: upstream was deleted on origin ---
  if [ "$track" = "gone" ]; then
    if is_merged "$b"; then
      add "$WILL_DELETE" "$b" "pruned; merged into $MASTER"
    elif i_am_on "$b"; then
      add "$EVALUATE" "$b" "pruned; unmerged; you have commits"
    else
      add "$WILL_DELETE" "$b" "pruned; unmerged; no commits by you"
    fi
    continue
  fi

  # --- older than one month ---
  if [ "$(git log -1 --format='%ct' "$b")" -lt "$month_ago" ]; then
    if git rev-parse --verify --quiet "origin/$b" >/dev/null; then
      set -- $(git rev-list --left-right --count "origin/$b...$b")
      behind=$1; ahead=$2
      lt=$(git log -1 --format='%ct' "$b")
      ot=$(git log -1 --format='%ct' "origin/$b")

      if [ "$ahead" -gt 0 ] || [ "$lt" -gt "$ot" ]; then
        add "$EVALUATE" "$b" "stale; ahead of / newer than origin"
      elif [ "$behind" -gt 0 ] || [ "$lt" -lt "$ot" ]; then
        if i_am_on "$b"; then
          add "$EVALUATE" "$b" "stale; behind origin; you have commits"
        else
          add "$WILL_DELETE" "$b" "stale; behind origin; no commits by you"
        fi
      else
        if i_am_on "$b"; then
          add "$EVALUATE" "$b" "stale; in sync; you have commits"
        else
          add "$WILL_DELETE" "$b" "stale; in sync; no commits by you"
        fi
      fi
    else
      add "$EVALUATE" "$b" "stale; never pushed to origin"
    fi
  fi
done < <(git for-each-ref --format='%(refname:short)' refs/heads/)

echo "Wrote $WILL_DELETE and $EVALUATE"
