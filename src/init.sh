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

BX_SCRIPT_CALLED="${BASH_SOURCE[0]:-$0}"
BX_SCRIPT_DIR="$(dirname "${BX_SCRIPT_CALLED}")"
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

## `BASHX_VERSION` constant should be defined before load the bootstrap.
readonly BASHX_VERSION="${BASHX_VERSION}"
[ ! -z "${BASHX_VERSION}" ] || {
  echo '"BASHX_VERSION" is required!' >&2
  exit 1
}

# #############################################################################

### Ensure environment constants

[[ ! -z "${UID}" ]] || export UID=$(id -u)
[[ ! -z "${GID}" ]] || export GID=$(id -g)

## Core directory (can be overridden before load with BX_DIR).
readonly BX_DIR="${BX_DIR:-${HOME:-/tmp}/.bashx/${BASHX_VERSION}}"
[ -d "${BX_DIR}" ] || {
  echo "[BX_DIR=${BX_DIR}] is invelid!" >&2
  exit 2
}

## Core SRC path.
readonly BX_SRC_PATH="${BX_DIR}/src"

. "${BX_SRC_PATH}/config.init.src"
. "${BX_SRC_PATH}/constants.src"
. "${BX_SRC_PATH}/config.src"

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
${BASHX_APP_COLORS_ENABLED} && PS4=' 🐛 ' || PS4='> % '

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
