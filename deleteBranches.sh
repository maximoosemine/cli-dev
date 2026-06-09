#!/usr/bin/env bash
# Deletes local branches named in the first column of the given TSV file.
set -euo pipefail

file=$1

while IFS=$'\t' read -r branch _; do
  [ -z "$branch" ] && continue
  git branch -D "$branch"
done < "$file"
