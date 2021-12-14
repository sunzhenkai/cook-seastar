#!/bin/bash
set -e
set -x

FP="$(
  cd "$(dirname "$0")" || exit
  pwd -P
)"
FP_SRC="$FP/src"
FP_DEPS="$FP/deps"
FP_BUILD="$FP/build"
FP_COMMON="$FP/common"

. "$FP_COMMON/tools.sh"
MAKE_THREAD_NUM="$(get_cpu_num)"

# creat folders
[ ! -e "$FP_DEPS" ] && mkdir -p "$FP_DEPS"
[ ! -e "$FP_BUILD" ] && mkdir -p "$FP_BUILD"

# versions
VERSION_BOOST='1_71_0'
VERSION_SEASTAR='20.05.0'

usage() {
  cat <<EOF
  Usage: $0 [-a] [-d dependency]
EOF
}

MODULES=(boost seastar)
INSTALL_MODULES=()
while getopts ":ad:" opt; do
  case "$opt" in
  a) INSTALL_MODULES=("${MODULES[@]}") ;;
  d) INSTALL_MODULES+=("$OPTARG") ;;
  *) usage exit 1 ;;
  esac
done

seastar() {
  tar -zxf "$FP_SRC/seastar-seastar-$VERSION_SEASTAR.tar.gz" -C "$FP_BUILD"
  cd "$FP_BUILD/seastar-seastar-$VERSION_SEASTAR"
  ./configure.py --mode=release --enable-dpdk --compiler=g++ --c-compiler=gcc \
    --cook fmt --c++-dialect=gnu++17 --prefix="$FP_DEPS"
  ninja -C build/release
}

boost() {
  FP_SRC_BOOST="$FP_SRC/boost_$VERSION_BOOST.tar.gz"
  # concat boost
  [ ! -e "FP_SRC_BOOST" ] && cat "$FP_SRC/boost_$VERSION_BOOST.tar.gz.part*" >"$FP_SRC_BOOST"
  # tar
  tar -zxf "$FP_SRC_BOOST" -C "$FP_BUILD"
  cd "$FP_BUILD/boost_$VERSION_BOOST"
  # build
  ./bootstrap.sh --without-libraries=mpi,python,graph,graph_parallel
  (./b2 --prefix="$FP_DEPS" -j "$MAKE_THREAD_NUM" threading=multi address-model=64 variant=release stage install)
}

FP_PWD="$(pwd)"
for module in "${INSTALL_MODULES[@]}"; do
  echo "start to build $module"
  $module
  # go back
  cd "$FP_PWD"
  echo "build $module done"
done
