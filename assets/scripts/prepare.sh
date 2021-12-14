#!/bin/sh
git submodule update --init --recursive
sh external/src/seastar/install-dependencies.sh
