#!/usr/bin/env bash

## BashX
##
## Extended Bash Framework.
##
## URL: https://github.com/reduardo7/bashx
##
## Author: Eduardo Cuomo <eduardo.cuomo.ar@gmail.com> <reduardo7@gmail.com>

# #############################################################################

# Go to script path (working directory)
cd "$BASE_DIR"

# Test and force run with "bash" interpreter.
if [ -z "$BASH" ]; then
  bash "$(basename "$BASE_SOURCE")" "$@"
  exit $?
fi

# #############################################################################

### CONFIG
# Update with your configuration or use the "config.ini" file.

  # APP Title.
  export APP_TITLE="BashX"

  # APP Version.
  export APP_VERSION="1.0"

  # Default APP color. See "style" for more information.
  #COLOR_DEFAULT="system" # Default system color
  export COLOR_DEFAULT="cyan-light"

  # BashX output colors.
  # 0: Disable output colors.
  # 1: Enable output colors.
  export BASHX_COLORS_ENABLED=1

  # Start character for formated print screen (see "e" function).
  export ECHO_CHAR="#"

  # Application requeirements.
  # To extend requeirements, use:
  #   export APP_REQUEIREMENTS="${APP_REQUEIREMENTS} other app command extra foo"
  export APP_REQUEIREMENTS="printf sed grep read date dirname readlink basename let"

  # Default action to call.
  # Action to use if script called without arguments.
  export DEFAULT_ACTION="usage"

  # BashX SRC path.
  export SRC_PATH="src"

  # Log file (& path).
  export LOG_FILE="$0.log"

  # Config file.
  export CONFIG_FILE="$CONFIG_FILE"

  # Tests path
  export TESTS_PATH="${BASE_DIR}/${SRC_PATH}/tests"

  # Actions path
  export ACTIONS_PATH="${BASE_DIR}/${SRC_PATH}/actions"
  export BASHX_ACTIONS_PATH="${BASHX_DIR}/src/actions"
  readonly BASHX_ACTIONS_PATH="$BASHX_ACTIONS_PATH"

  # Utils path
  export UTILS_PATH="${BASE_DIR}/${SRC_PATH}/utils"
  export BASHX_UTILS_PATH="${BASHX_DIR}/src/utils"
  readonly BASHX_UTILS_PATH="$BASHX_UTILS_PATH"

  # Resources path.
  export RESOURCES_PATH="${BASE_DIR}/${SRC_PATH}/resources"

### OS

  export OS_IS_LINUX=false
  export OS_IS_MAC=false
  export OS_IS_MINGW=false

  if [ "$(uname)" == "Darwin" ]; then
    defaults write org.R-project.R force.LANG en_US.UTF-8
    export TERM="xterm-color"
    export OS_IS_MAC=true        
  elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    export OS_IS_LINUX=true
  elif [[ "$(expr substr $(uname -s) 1 10)" == MINGW* ]]; then
    export OS_IS_MINGW=true
  fi

### CONSTANTS

  # BashX base source.
  BASHX_BASE_SOURCE="${BASH_SOURCE[0]}"
  while [ -h "$BASHX_BASE_SOURCE" ]; do
    BASHX_BASE_DIR="$(cd -P `dirname "$BASHX_BASE_SOURCE"` && pwd)"
    BASHX_BASE_SOURCE=`readlink "$BASHX_BASE_SOURCE"`
    [[ $BASHX_BASE_SOURCE != /* ]] && BASHX_BASE_SOURCE="$BASHX_BASE_DIR/$BASHX_BASE_SOURCE"
  done
  [ -z "$BASHX_BASE_DIR"] && BASHX_BASE_DIR="$(cd -P `dirname "$BASHX_BASE_SOURCE"` && pwd)"
  export BASHX_BASE_SOURCE="$BASHX_BASE_SOURCE"
  readonly BASHX_BASE_SOURCE="$BASHX_BASE_SOURCE"

  # BashX base path.
  export BASHX_BASE_DIR="$BASHX_BASE_DIR"
  readonly BASHX_BASE_DIR="$BASHX_BASE_DIR"

  # Base script source.
  export BASE_SOURCE="$BASE_SOURCE"
  readonly BASE_SOURCE="$BASE_SOURCE"

  # Base script path.
  export BASE_DIR="$BASE_DIR"
  readonly BASE_DIR="$BASE_DIR"

  # Key: ESC
  # \e | \033 | \x1B
  $OS_IS_MAC && export KEY_ESC=$'\x1B' || export KEY_ESC=$'\e'
  readonly KEY_ESC="$KEY_ESC"

### Load files

  # Config
  if [ -z "${CONFIG_FILE}" ]; then
    # Default file
    export CONFIG_FILE="${SRC_PATH}/config.ini"
  fi
  # Load config
  if [ -f "${CONFIG_FILE}" ]; then
    . ${CONFIG_FILE}
  fi

### VARS

  # Current called action.
  export ACTION=""

### PRIVATE VARS

  # On exit command
  export _ON_EXIT=''

  # TRUE if APP is terminated
  export _APP_EXIT=false

  export _ACTION_PREFIX='@ACTIONS.'

### EXEC

  # Preload
  @trim() { . "${BASHX_UTILS_PATH}/@trim.sh"; }
  @str-to-lower() { . "${BASHX_UTILS_PATH}/@str-to-lower.sh"; }
  @str-explode() { . "${BASHX_UTILS_PATH}/@str-explode.sh"; }
  @style() { . "${BASHX_UTILS_PATH}/@style.sh"; }
  @str-replace() { . "${BASHX_UTILS_PATH}/@str-replace.sh"; }
  @file-name() { . "${BASHX_UTILS_PATH}/@file-name.sh"; }

  # Init
  @init() { . "${BASHX_DIR}/src/bashx.init.sh"; }
