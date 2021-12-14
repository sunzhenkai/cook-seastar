#!/bin/sh
git submodule update --init --recursive
sudo external/src/seastar/install-dependencies.sh
