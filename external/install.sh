#!/bin/bash
set -e

FP="$(
  cd "$(dirname "$0")" || exit
  pwd -P
)"
FP_SRC="$FP/src"

usage() {
  cat <<EOF
  Usage: $0 [-a] [-d dependency]
EOF
}

MODULES=(seastar)
INSTALL_MODULES=()
while getopts ":ad:" opt; do
  case "$opt" in
  a) INSTALL_MODULES=("${MODULES[@]}") ;;
  d) INSTALL_MODULES+=("$OPTARG") ;;
  *) usage exit 1 ;;
  esac
done

seastar() {
  BASE="$FP_SRC/seastar"
  echo "build seastar under $BASE"
  cd "$BASE"
  ./configure.py --mode=release --c++-dialect=gnu++17
  ninja -C build/release
}

PWD="$(pwd)"
for module in "${INSTALL_MODULES[@]}"; do
  echo "start to build $module"
  $module
  # go back
  cd "$PWD"
done
