## code
## Exit from APP and execute the function setted in "@on.exit".
##
## Params:
##   code: {Integer} Exit code.
##         Optional. Default: 0.
##
## Warning!
##   Avoid calling this function from sub-shell.

local code=${1:-0}

if ! @isNumber ${code}; then
  code=1
fi

if ! ${BX_APP_EXIT} ; then

  # Mark as exit
  BX_APP_EXIT=true

  # On Error
  if [[ ${code} -ne 0 ]] && [ -f "${BASHX_EVENTS_PATH}/error.sh" ]; then
    . "${BASHX_EVENTS_PATH}/error.sh"
  fi

  if [ ! -z "${BX_ON_EXIT}" ]; then
    # Execute exit actions
    (
      eval "${BX_ON_EXIT}"
    )
  fi

  # On Finish
  if [ -f "${BASHX_EVENTS_PATH}/finish.sh" ]; then
    . "${BASHX_EVENTS_PATH}/finish.sh"
  fi

  # Cleanup
  if [ ! -z "${BASHX_APP_TMP_PATH}" ] && [ -d "${BASHX_APP_TMP_PATH}" ]; then
    rm -rf "${BASHX_APP_TMP_PATH}" || true
  fi

  # Reset System color
  @style reset >&3

  # Space
  echo >&3
fi

# Exit
exit ${code}
