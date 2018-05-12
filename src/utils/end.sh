## code
## Exit from APP and execute the function setted in "@on-exit".
##
## Params:
##   code: {Integer} Exit code.
##         Optional. Default: 0.

local code=${1:-0}

if ! @is-number ${code}; then
  code=0
fi

if ! ${_APP_EXIT} ; then

  # Mark as exit
  _APP_EXIT=true

  # On Error
  if [[ ${code} -ne 0 ]] && [ -f "${EVENTS_PATH}/error.sh" ]; then
    appOnError() {
      . "${EVENTS_PATH}/error.sh"
    }
    appOnError ${code}
    unset -f appOnError
  fi

  # On Exit
  if [ -f "${EVENTS_PATH}/exit.sh" ]; then
    appOnExit() {
      . "${EVENTS_PATH}/exit.sh"
    }
    appOnExit ${code}
    unset -f appOnExit
  fi

  if [ ! -z "${_ON_EXIT}" ]; then
    # Execute exit actions
    ( eval "${_ON_EXIT}" )
  fi

  # Cleanup
  if [ ! -z "${APP_TMP_PATH}" ] && [ -d "${APP_TMP_PATH}" ]; then
    rm -rf "${APP_TMP_PATH}" || true
  fi

  # Reset System color
  @style reset >&3

  # Space
  echo >&3
fi

# Exit
exit ${code}
