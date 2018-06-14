## [action [@]]
## Run APP.
##
## Params:
##   action: {String} Action to do.
##   @:      APP parameters.
##
## Use: At end of /app file, put next:
##   @run-app "$@"

# Call @run-app once
unset -f @run-app

# Start
local r=1

echo >&3 # Space

BASHX_ACTION="$1"

@title "$(@app-info)"

# On end Script
trap @end EXIT

# On CTRL + C
trap @end INT

if [ -z "${BASHX_ACTION}" ]; then
  # Empty Action

  if [ -z "${BX_APP_DEFAULT_ACTION}" ]; then
    # Show help
    BASHX_ACTION='help'
    r=1
  else
    # Call default action
    BASHX_ACTION="${BX_APP_DEFAULT_ACTION}"
  fi

  export BASHX_ACTION="${BASHX_ACTION}"
  ${BASHX_ACTION_PREFIX}.${BASHX_ACTION}
elif [[ $# -gt 0 ]]; then
  shift # Remove "Action" from parameters
  export BASHX_ACTION="${BASHX_ACTION}"

  # On Ready
  if [ -f "${BX_EVENTS_PATH}/ready.sh" ]; then
    appOnReady() {
      . "${BX_EVENTS_PATH}/ready.sh"
    }
    appOnReady
    unset -f appOnReady
  fi

  # If function (Action) exists
  if @function-exists "${BASHX_ACTION_PREFIX}.${BASHX_ACTION}" ; then
    # On Start
    if [ -f "${BX_EVENTS_PATH}/start.sh" ]; then
      appOnStart() {
        . "${BX_EVENTS_PATH}/start.sh"
      }
      appOnStart
      unset -f appOnStart
    fi

    # Exec
    ${BASHX_ACTION_PREFIX}.${BASHX_ACTION} "$@"
    r=$?
  else
    # Invalid Action
    if [ -f "${BX_EVENTS_PATH}/invalid-action.sh" ]; then
      appOnInvalidAction() {
        . "${BX_EVENTS_PATH}/invalid-action.sh"
      }
      appOnInvalidAction
      r=$?
      unset -f appOnInvalidAction
    else
      local _sr="$(@style default color:red)"
      @error "Action '$(@style color:green)${BASHX_ACTION}${_sr}' not found. See '$(@style bold)help${_sr}' for help."
    fi
  fi
fi

# Return result code
@end $r
