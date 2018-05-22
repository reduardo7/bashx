## @
## Run APP.
##
## Params:
##   @: APP parameters.
##
## Use: At end of /app file, put next:
##   @run-app "$@"

# Call @run-app once
unset -f @run-app

# Start
local r=1

echo >&3 # Space

ACTION="$1"

@title "$(@app-info)"

# On end Script
trap @end EXIT

# On CTRL + C
trap @end INT

if [ -z "${ACTION}" ]; then
  # Empty Action

  if [ -z "${APP_DEFAULT_ACTION}" ]; then
    # Show help
    ACTION='help'
    r=1
  else
    # Call default action
    ACTION="$APP_DEFAULT_ACTION"
  fi

  ${ACTION_PREFIX}.${ACTION}
elif [[ $# -gt 0 ]]; then
  shift # Remove "Action" from parameters

  # On Ready
  if [ -f "${EVENTS_PATH}/ready.sh" ]; then
    appOnReady() {
      . "${EVENTS_PATH}/ready.sh"
    }
    appOnReady
    unset -f appOnReady
  fi

  # If function (Action) exists
  if @function-exists "${ACTION_PREFIX}.${ACTION}" ; then
    # On Start
    if [ -f "${EVENTS_PATH}/start.sh" ]; then
      appOnStart() {
        . "${EVENTS_PATH}/start.sh"
      }
      appOnStart
      unset -f appOnStart
    fi

    # Exec
    ${ACTION_PREFIX}.${ACTION} "$@"
    r=$?
  else
    # Invalid Action
    if [ -f "${EVENTS_PATH}/invalid-action.sh" ]; then
      appOnInvalidAction() {
        . "${EVENTS_PATH}/invalid-action.sh"
      }
      appOnInvalidAction
      r=$?
      unset -f appOnInvalidAction
    else
      local _sr="$(@style default color:red)"
      @error "Parameter '$(@style color:green)${ACTION}${_sr}' not found. Call '$(@style bold)help${_sr}' to see help."
    fi
  fi
fi

# Return result code
@end $r
