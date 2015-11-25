#!/bin/bash

# ################### #
#                     #
# Application Manager #
#                     #
# ################### #

BASE_SOURCE="$0"
while [ -h "$BASE_SOURCE" ]; do
  BASE_SOURCE="$(readlink "$BASE_SOURCE")"
  BASE_SOURCE="$(cd $(dirname "$BASE_SOURCE") ; pwd)/$(basename "$BASE_SOURCE")"
done
export BASE_SOURCE="$BASE_SOURCE"
export BASE_DIR="$(dirname "$BASE_SOURCE")"
export CURRENT_DIR="$(pwd)"
export CURRENT_SOURCE="$CURRENT_DIR/$(basename "$0")"
cd "$(dirname "$BASE_SOURCE")"
. ./src/bashx.sh
run "$@"
