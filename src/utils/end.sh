## code
## Exit from APP and execute the function setted in "@on-exit".
##
## Params:
##   code: {Integer} Exit code.
##         Optional. Default: 0.
##
## Warning!
##   Avoid calling this function from sub-shell.

local code=${1:-0}

if ! @is-number ${code}; then
  code=1
fi

if ! ${_BASHX_APP_EXIT} ; then

  # Mark as exit
  _BASHX_APP_EXIT=true

  # On Error
  if [[ ${code} -ne 0 ]] && [ -f "${BX_EVENTS_PATH}/error.sh" ]; then
    . "${BX_EVENTS_PATH}/error.sh"
  fi

  if [ ! -z "${_BASHX_ON_EXIT}" ]; then
    # Execute exit actions
    ( eval "${_BASHX_ON_EXIT}" )
  fi

  # On Finish
  if [ -f "${BX_EVENTS_PATH}/finish.sh" ]; then
    . "${BX_EVENTS_PATH}/finish.sh"
  fi

  # Cleanup
  if [ ! -z "${BX_APP_TMP_PATH}" ] && [ -d "${BX_APP_TMP_PATH}" ]; then
    rm -rf "${BX_APP_TMP_PATH}" || true
  fi

  # Reset System color
  @style reset >&3

  # Space
  echo >&3
fi

# Exit
exit ${code}
