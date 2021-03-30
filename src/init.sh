#!/usr/bin/env bash

############################################
#                                          #
# BashX                                    #
#                                          #
# Extended Bash Framework                  #
#                                          #
# URL: https://github.com/reduardo7/bashx  #
#                                          #
# Author: Eduardo Daniel Cuomo             #
#         eduardo.cuomo.ar@gmail.com       #
#         reduardo7@gmail.com              #
#                                          #
############################################

set +e

export LC_CTYPE=C
export LC_ALL=C
export LANG=C

BX_SCRIPT_CALLED="$0"
BX_SCRIPT_DIR="$(cd "$(dirname "${BX_SCRIPT_CALLED}")" ; pwd)"
BX_SCRIPT_FILE_NAME="$(basename "${BX_SCRIPT_CALLED}")"
while [ -h "${BX_SCRIPT_CALLED}" ]; do
  BX_SCRIPT_CALLED="$(readlink "${BX_SCRIPT_CALLED}")"
  BX_SCRIPT_DIR="$(cd "${BX_SCRIPT_DIR}" ; cd "$(dirname "${BX_SCRIPT_CALLED}")" ; pwd)"
  BX_SCRIPT_FILE_NAME="$(basename "${BX_SCRIPT_CALLED}")"
  BX_SCRIPT_CALLED="$(cd "${BX_SCRIPT_DIR}" ; pwd)/${BX_SCRIPT_FILE_NAME}"
done

# Test and force run with "bash" interpreter
if [ -z "${BASH}" ]; then
  bash "$(basename "${BX_SCRIPT_CALLED}")" "$@"
  exit $?
fi

# #############################################################################

### Ensure environment constants

[[ ! -z "${UID}" ]] || export UID=$(id -u)
[[ ! -z "${GID}" ]] || export GID=$(id -g)

### Constants

## BashX called script arguments.
export BX_SCRIPT_ARGS=($@)

## BashX scripts extension.
readonly BX_SCRIPT_EXTENSION='xsh'

## Called script.
readonly BX_SCRIPT_CALLED="${BX_SCRIPT_CALLED}"

## Current script file name.
readonly BX_SCRIPT_FILE_NAME="${BX_SCRIPT_FILE_NAME}"

## Current script full path.
readonly BX_SCRIPT_FULL_PATH="${BX_SCRIPT_DIR}/${BX_SCRIPT_FILE_NAME}"

## Current script directory.
readonly BX_SCRIPT_DIR="${BX_SCRIPT_DIR}"

## Core directory (can be overridden before load with BX_DIR).
readonly BX_DIR="${BX_DIR:-${HOME:-/tmp}/.bashx/${BASHX_VERSION}}"

## Core SRC path.
readonly BX_SRC_PATH="${BX_DIR}/src"

## Core actions path.
readonly BX_ACTIONS_PATH="${BX_SRC_PATH}/actions"

## Core utils path.
readonly BX_UTILS_PATH="${BX_SRC_PATH}/utils"

### OS Constants

export BX_OS_IS_LINUX=false
export BX_OS_IS_MAC=false
export BX_OS_IS_MINGW=false

if [[ "$(uname)" == "Darwin" ]]; then
  defaults write org.R-project.R force.LANG en_US.UTF-8
  export TERM="xterm-color"
  export BX_OS_IS_MAC=true
elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
  export BX_OS_IS_LINUX=true
elif [[ "$(expr substr $(uname -s) 1 10)" == MINGW* ]]; then
  export BX_OS_IS_MINGW=true
fi

## Is Linux OS?
readonly BX_OS_IS_LINUX=${BX_OS_IS_LINUX}
## Is Mac OS?
readonly BX_OS_IS_MAC=${BX_OS_IS_MAC}
## Is Win OS?
readonly BX_OS_IS_MINGW=${BX_OS_IS_MINGW}

BX_BASE_SOURCE="${BASH_SOURCE[0]}"
while [ -h "${BX_BASE_SOURCE}" ]; do
  BX_BASE_DIR="$(cd -P "$(dirname "${BX_BASE_SOURCE}")" && pwd)"
  BX_BASE_SOURCE=`readlink "${BX_BASE_SOURCE}"`
  [[ "${BX_BASE_SOURCE}" != /* ]] && BX_BASE_SOURCE="${BX_BASE_DIR}/${BX_BASE_SOURCE}"
done
[ -z "${BX_BASE_DIR}"] && BX_BASE_DIR="$(cd -P "$(dirname "${BX_BASE_SOURCE}")" && pwd)"

## BashX base source path.
readonly BX_BASE_SOURCE="${BX_BASE_SOURCE}"

# BashX base directory path.
readonly BX_BASE_DIR="${BX_BASE_DIR}"

# \e | \033 | \x1B
## Key: ESC
${BX_OS_IS_MAC} && readonly BX_KEY_ESC=$'\x1B' || readonly BX_KEY_ESC=$'\e'

# https://stackoverflow.com/a/911213/717267
## TTY available?
[ -t 1 ] && readonly BX_TTY=true || readonly BX_TTY=false

# \n - New Line
## New Line constant (\n)
readonly BX_CHAR_NL='
'

# \t - Tab
## New Line constant (\t)
readonly BX_CHAR_TAB='  '

## Action prefix. Used at @app.run.
readonly BX_ACTION_PREFIX='@Actions'

## Events options.
readonly BX_EVENTS_OPTS=(invalid-action ready start error finish)

# #############################################################################

### Configs

export BASHX_DOC_MARK='##'

## Current script Sources directory. Customizable with: BASHX_SRC_DIR.
export BASHX_SRC_DIR="${BASHX_SRC_DIR:-${BX_SCRIPT_FILE_NAME}.src}"

## Current script Sources path. Constant.
export BASHX_SRC_PATH="${BX_SCRIPT_DIR}/${BASHX_SRC_DIR}"

## Configuration file (can be overridden before load). Customizable with: BASHX_APP_CONFIG_FILE.
export BASHX_APP_CONFIG_FILE="${BASHX_APP_CONFIG_FILE:-${BX_SCRIPT_DIR}/.env}"

## APP Title. Customizable with: BASHX_APP_CONFIG_FILE.
export BASHX_APP_TITLE="${BASHX_APP_TITLE:-BashX}"

## APP Version.
export BASHX_APP_VERSION="${BASHX_APP_VERSION:-1.0}"

## Default APP color. See "@style" for more information.
export BASHX_APP_COLOR_DEFAULT="${BASHX_APP_COLOR_DEFAULT:-cyan-light}"

## Output colors?
export BASHX_APP_COLORS_ENABLED=${BASHX_APP_COLORS_ENABLED:-true}

## APP colsumns width.
export BASHX_APP_WIDTH=${BASHX_APP_WIDTH:-80}

## Start character for formated print screen. See "@log" for more information.
export BASHX_APP_PRINT_PREFIX="${BASHX_APP_PRINT_PREFIX:-#}"

## Default action to call. Action to use if script called without arguments.
export BASHX_APP_DEFAULT_ACTION="${BASHX_APP_DEFAULT_ACTION:-help}"

## Tests path.
export BASHX_TESTS_PATH="${BASHX_SRC_PATH}/tests"

## Actions path.
export BASHX_ACTIONS_PATH="${BASHX_SRC_PATH}/actions"

## Utils path.
export BASHX_UTILS_PATH="${BASHX_SRC_PATH}/utils"

## Events path.
export BASHX_EVENTS_PATH="${BASHX_SRC_PATH}/events"

## Resources path.
export BASHX_RESOURCES_PATH="${BASHX_SRC_PATH}/resources"

# #############################################################################

### Load config

if [[ -f "${BASHX_APP_CONFIG_FILE}" ]]; then
  . "${BASHX_APP_CONFIG_FILE}"
fi

# #############################################################################

### VARS

## APP Temporary path.
readonly BASHX_APP_TMP_PATH="${BASHX_APP_TMP_PATH:-$(mktemp -d)}"

## APP main process index.
readonly BX_PROC_INDEX_MAIN=${BASH_SUBSHELL}

echo ${BX_PROC_INDEX_MAIN} > "${BASHX_APP_TMP_PATH}/__bx_shell_main"

# #############################################################################

### PRIVATE VARS

## Current called action.
export BX_ACTION=''

## True if APP is terminated with illegal error.
BX_APP_EXIT_ILLEGAL_ERROR=false

# Events commands
BX_ON_EXIT=''
# BX_ON_STDOUT=''
# BX_ON_STDERR=''
# BX_ON_STDINFO=''

# True if APP is terminated
BX_APP_EXIT=false

# #############################################################################

# info out > std err
exec 3>&2

# Debug (set +x) prompt
# ${BASHX_APP_COLORS_ENABLED} && PS4='>\e[2m % ' || PS4='>% '
PS4='> % '

# #############################################################################

### Preload required

__BX_each_line_=true

# Internal checks for sub-shells
__BX_each_line() {
  if \
    ${__BX_each_line_} \
    && ! ${BX_APP_EXIT} \
    && [[ ${BX_PROC_INDEX_MAIN} == ${BASH_SUBSHELL} ]] \
    && [ -f "${BASHX_APP_TMP_PATH}/__bx_subshell_exit" ]
  then
    __BX_each_line_=false
    exit $(cat "${BASHX_APP_TMP_PATH}/__bx_subshell_exit")
  fi
}

@str.trim() { . "${BX_UTILS_PATH}/str/trim.${BX_SCRIPT_EXTENSION}"; }
@str.toLower() { . "${BX_UTILS_PATH}/str/toLower.${BX_SCRIPT_EXTENSION}"; }
@style() { . "${BX_UTILS_PATH}/style.${BX_SCRIPT_EXTENSION}"; }
@file.name() { . "${BX_UTILS_PATH}/file/name.${BX_SCRIPT_EXTENSION}"; }
@function.load() { . "${BX_UTILS_PATH}/function/load.${BX_SCRIPT_EXTENSION}"; }

# #############################################################################

### Bootstrap

# Load base
@function.load "${BX_UTILS_PATH}" '@'
@function.load "${BX_ACTIONS_PATH}" "${BX_ACTION_PREFIX}."

# Load custom
[ ! -d "${BASHX_UTILS_PATH}" ] || @function.load "${BASHX_UTILS_PATH}" '@'
[ ! -d "${BASHX_ACTIONS_PATH}" ] || @function.load "${BASHX_ACTIONS_PATH}" "${BX_ACTION_PREFIX}."

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
