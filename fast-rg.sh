#!/bin/sh

# Is meant for copilot to accelerate broad codebase searches.

# Usage: RG_EXCLUDE_DIRS="node_modules,vendor,.git" ./rg-search.sh "args"

if [ -z "$1" ]; then
    echo "Usage: <rg_args>"
    exit 1
fi

exclude_args=""
if [ -n "$RG_EXCLUDE_DIRS" ]; then
    for dir in $(echo "$RG_EXCLUDE_DIRS" | tr ',' ' '); do
        exclude_args="$exclude_args --glob !$dir"
    done
fi

tmpfile=$(mktemp)
timeout 10 rg $exclude_args "$@" > "$tmpfile"
status=$?

output=$(head -50 "$tmpfile")
line_count=$(wc -l < "$tmpfile")
rm "$tmpfile"

echo "$output"

if [ $status -eq 124 ]; then
    printf "[Search timed out after 10 seconds. Try a more specific search.]\n"
elif [ "$line_count" -ge 50 ]; then
    printf "[Search stopped after 50 results. Try a more specific search.]\n"
fi
