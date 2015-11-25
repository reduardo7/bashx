#!/bin/bash

# ################### #
#                     #
# Application Manager #
#                     #
# ################### #

BASE_SOURCE="$0"
BASE_DIR="$(cd "$(dirname "$BASE_SOURCE")" ; pwd)"
while [ -h "$BASE_SOURCE" ]; do
  BASE_SOURCE="$(readlink "$BASE_SOURCE")"
  BASE_DIR="$(cd "$BASE_DIR" ; cd "$(dirname "$BASE_SOURCE")" ; pwd)"
  BASE_SOURCE="$(cd "$BASE_DIR" ; pwd)/$(basename "$BASE_SOURCE")"
done
export BASE_SOURCE="$BASE_SOURCE"
export BASE_DIR="$BASE_DIR"
export CURRENT_DIR="$(pwd)"
export CURRENT_SOURCE="$CURRENT_DIR/$(basename "$0")"
export CONFIG_FILE="$BASE_DIR/src/config.ini"
export BASHX_DIR="$BASE_DIR"
cd "$BASE_DIR"
if [ ! -d "${BASHX_DIR}" ]; then
  echo "Installing BashX..."
  git clone git@github.com:reduardo7/bashx.git "${BASHX_DIR}"
fi
. "${BASHX_DIR}/src/bashx.sh"
run "$@"
