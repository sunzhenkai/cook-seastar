#!/bin/bash
set -e
DEPS=(meson)

for dep in "${DEPS[@]}"; do
  if ! command -v "$dep" >/dev/null; then
    echo "miss dependency: $dep"
  fi
done

echo "all dependency checking passed"