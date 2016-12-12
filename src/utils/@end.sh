# Exit from APP and execute the function setted in "@set-on-exit".
#
# 1: {Integer} (Default: 0) Exit code.

local code=${code}

if ! $_APP_EXIT ; then
  if [ ! -z "$_ON_EXIT" ]; then
    # Execute exit actions
    $_ON_EXIT
  fi

  # Mark as exit
  _APP_EXIT=true

  # Reset System color
  @style reset >&2

  # Space
  echo >&2

  # Exit
  if [ $# -gt 1 ]; then
    if @is-number "${code}"; then
      exit ${code}
    else
      @error "Invalid exit code '${code}'"
    fi
  else
    exit 0
  fi
fi
