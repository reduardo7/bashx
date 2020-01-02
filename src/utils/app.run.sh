## [action [@]]
## Run APP.
##
## Params:
##   action: {String} Action to do.
##   @:      APP parameters.
##
## Use: At end of /app file, put next:
##   @app.run "$@"

# Call @app.run once
unset -f @app.run

# Start
local r=1

echo >&3 # Space

BASHX_ACTION="$1"

@log.title "$(@app.info)"

# On end Script from Error
trap '@app.error "Unexpected error" true $?' ERR

# On end Script
trap '@app.exit $?' EXIT

# On CTRL + C
trap '@app.exit $?' INT

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
    . "${BX_EVENTS_PATH}/ready.sh"
  fi

  # If function (Action) exists
  if @function.exists "${BASHX_ACTION_PREFIX}.${BASHX_ACTION}" ; then
    # On Start
    if [ -f "${BX_EVENTS_PATH}/start.sh" ]; then
      . "${BX_EVENTS_PATH}/start.sh"
    fi

    # Exec
    ${BASHX_ACTION_PREFIX}.${BASHX_ACTION} "$@"
    # ${BASHX_ACTION_PREFIX}.${BASHX_ACTION} "$@" 4>&1 1>&2 2>&4 4>&- | grep -v '++ local _r_'
    # ${BASHX_ACTION_PREFIX}.${BASHX_ACTION} "$@" 2> >( grep '++ local _r_' >&2 )
    r=$?
  else
    # Invalid Action
    if [ -f "${BX_EVENTS_PATH}/invalid-action.sh" ]; then
      . "${BX_EVENTS_PATH}/invalid-action.sh"
    else
      local _sr="$(@style default color:red)"
      @app.error "Action '$(@style color:green)${BASHX_ACTION}${_sr}' not found. See '$(@style bold)help${_sr}' for help."
    fi
  fi
fi

# Return result code
@app.exit $r