# Exit from APP and execute the function setted in "@set-on-exit".
#
# 1: {Integer} (Default: 0) Exit code.

if [ "$_APP_EXIT" == "$FALSE" ]; then
  if [ ! -z "$_ON_EXIT" ]; then
    # Execute exit actions
    $_ON_EXIT
  fi

  # Mark as exit
  _APP_EXIT=$TRUE

  # Reset System color
  @style reset

  # Space
  echo

  # Exit
  if [ $# -gt 1 ]; then
    if [ @is-number "$1" == $TRUE ]; then
      exit $1
    else
      @error "Invalid exit code '$1'"
    fi
  else
    exit 0
  fi
fi
