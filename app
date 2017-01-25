#!/usr/bin/env bash

############################################
#                                          #
# BashX                                    #
#                                          #
# Extended Bash Framework.                 #
#                                          #
# URL: https://github.com/reduardo7/bashx  #
#                                          #
# Author: Eduardo Daniel Cuomo             #
#         eduardo.cuomo.ar@gmail.com       #
#         reduardo7@gmail.com              #
#                                          #
############################################

# BashX Required Version (INTEGER) | bashx.version
BASHX_REQUIRED_VERSION=310

#export LC_CTYPE=en_US.UTF-8
#export LC_ALL=en_US.UTF-8
export LC_CTYPE=C
export LC_ALL=C

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
export BASHX_DIR="$BASE_DIR/src/bashx"
export BASHX_CURRENT_VERSION=$(cat "${BASHX_DIR}/src/bashx.version" 2>/dev/null || echo 1)

# Install
(
  _err() {
    echo "# $@"
    exit 1
  }

  _bxinstall() {
    echo "# Installing BashX..."

    if type wget >/dev/null 2>&1
      then
        wget --no-check-certificate https://github.com/reduardo7/bashx/tarball/v${BASHX_REQUIRED_VERSION} -O - | tar -xz || _err "Error downloading BashX v${BASHX_REQUIRED_VERSION}"
      else
        if type curl >/dev/null 2>&1
          then
            curl -sL https://github.com/reduardo7/bashx/tarball/v${BASHX_REQUIRED_VERSION} | tar -xz || _err "Error downloading BashX v${BASHX_REQUIRED_VERSION}"
          else
            echo "# WGET/cURL are not installed!"
            echo "#"
            echo "# Install WGET:"
            echo "#     $ sudo apt-get install wget"
            echo "# or cURL:"
            echo "#     $ sudo apt-get install curl"
            echo "#"
            exit 1
          fi
      fi

    mv reduardo7-bashx-* "${BASHX_DIR}" || _err "Error installing BashX"
  }

  cd "$BASE_DIR" || _err "Error"

  if [ ! -d "${BASHX_DIR}" ]; then
    _bxinstall
  else
    if [[ $BASHX_CURRENT_VERSION -lt $BASHX_REQUIRED_VERSION ]]; then
      (
        echo "# BashX requred version is v$BASHX_REQUIRED_VERSION, but version v${BASHX_CURRENT_VERSION} is installed"
        echo "# Updating BashX..."
        rm -rf ${BASHX_DIR} || _err "Error removing old version"
        _bxinstall || exit 1
      )
    fi
  fi
)

# Init
(
  . "${BASHX_DIR}/src/bashx.sh"
  @init "$@"
  exit $?
)
