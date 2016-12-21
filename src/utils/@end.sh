# Exit from APP and execute the function setted in "@on-exit".
#
# 1: {Integer} (Default: 0) Exit code.

if ! $_APP_EXIT ; then
  local code=$1

  if [ ! -z "${_ON_EXIT}" ]; then
    # Execute exit actions
    eval "${_ON_EXIT}"
  fi

  # Mark as exit
  _APP_EXIT=true

  # Reset System color
  @style reset >&3

  # Space
  echo >&3

  # Exit
  if @is-number "${code}"; then
    exit ${code}
  else
    exit 0
  fi
fi
