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

BX_ACTION="$1"

@log.title "$(@app.info)"

# On end Script from Error
trap '@app.error "Unexpected error" true $?' ERR

# On end Script
trap '@app.exit $?' EXIT

# On CTRL + C
trap '@app.exit $?' INT

if [ -z "${BX_ACTION}" ]; then
  # Empty Action

  if [ -z "${BASHX_APP_DEFAULT_ACTION}" ]; then
    # Show help
    BX_ACTION='help'
    r=1
  else
    # Call default action
    BX_ACTION="${BASHX_APP_DEFAULT_ACTION}"
  fi

  export BX_ACTION="${BX_ACTION}"
  ${BX_ACTION_PREFIX}.${BX_ACTION}
elif [[ $# -gt 0 ]]; then
  shift # Remove "Action" from parameters
  export BX_ACTION="${BX_ACTION}"

  # On Ready
  if [ -f "${BASHX_EVENTS_PATH}/ready.sh" ]; then
    . "${BASHX_EVENTS_PATH}/ready.sh"
  fi

  # If function (Action) exists
  if @function.exists "${BX_ACTION_PREFIX}.${BX_ACTION}" ; then
    # On Start
    if [ -f "${BASHX_EVENTS_PATH}/start.sh" ]; then
      . "${BASHX_EVENTS_PATH}/start.sh"
    fi

    # Exec
    ${BX_ACTION_PREFIX}.${BX_ACTION} "$@"
    # ${BX_ACTION_PREFIX}.${BX_ACTION} "$@" 4>&1 1>&2 2>&4 4>&- | grep -v '++ local _r_'
    # ${BX_ACTION_PREFIX}.${BX_ACTION} "$@" 2> >( grep '++ local _r_' >&2 )
    r=$?
  else
    # Invalid Action
    if [ -f "${BASHX_EVENTS_PATH}/invalid-action.sh" ]; then
      . "${BASHX_EVENTS_PATH}/invalid-action.sh"
    else
      local _sr="$(@style default color:red)"
      @app.error "Action '$(@style color:green)${BX_ACTION}${_sr}' not found. See '$(@style bold)help${_sr}' for help."
    fi
  fi
fi

# Return result code
@app.exit $r
