## @
## Run APP.
## Run arguments as commands if any, or show 'help'.
##
## Use: At end of /app file, put next:
##   @run-app "$@"

# Call @run-app once
unset -f @run-app

# Start
local r=1
echo >&3

@title "$(@app-info)"

# On end Script
trap @end EXIT

# On CTRL + C
trap @end INT

if [ $# -gt 0 ]; then
  # If function exists
  if @function-exists "${ACTION_PREFIX}.$1" ; then
    # Exec
    if [ "$1" == 'help' ]; then
      ACTION='help'
    else
      ACTION="$1"
    fi
    ${ACTION_PREFIX}."$@"
    r=$?
  else
      @error "Parameter '$(@style color:green)${1}$(@style color:red)' not found. Call 'help' to see help." false
  fi
fi

if [ ${#1} == 0 ]; then
  if [ -z "${APP_DEFAULT_ACTION}" ]; then
    # Show help
    ACTION='help'
    r=1
  else
    # Call default action
    ACTION="$APP_DEFAULT_ACTION"
  fi

  ${ACTION_PREFIX}.${ACTION}
fi

# Return result code
@end $r
