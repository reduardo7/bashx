## [action [@]]
## Run APP.
##
## Params:
##   action: {String} Action to do.
##   @:      APP parameters.
##
## Use: At end of /app file, put next:
##   @app.run "$@"

# __BX_style_reset="$(${BASHX_APP_COLORS_ENABLED} && @style reset || true)"

# __BX_on_stdout() {
#   local line
#   while read line; do
#     [ -z "${BX_ON_STDOUT}" ] || line="$(OUT_LINE="${line}" eval "${BX_ON_STDOUT}")"
#     echo -e "${__BX_style_reset}${line}"
#   done
# }

# __BX_on_stderr() {
#   local line
#   while read line; do
#     [ -z "${BX_ON_STDERR}" ] || line="$(OUT_LINE="${line}" eval "${BX_ON_STDERR}")"
#     echo -e "${line}" >&2
#   done
# }

# __BX_on_stdinfo() {
#   local line
#   while read line; do
#     [ -z "${BX_ON_STDINFO}" ] || line="$(OUT_LINE="${line}" eval "${BX_ON_STDINFO}")"
#     echo -e "${__BX_style_reset}${line}" >&3
#   done
# }

{
  # Call @app.run once
  unset -f @app.run

  # Start
  local r=1

  echo >&3 # Space

  BX_ACTION="$1"

  @log.title "$(@app.info)"

  # On end Script from Error
  trap '@app.error "Unexpected error [$?]" true $?' ERR

  # On end Script
  # https://mywiki.wooledge.org/SignalTrap
  # https://tldp.org/LDP/Bash-Beginners-Guide/html/sect_12_02.html
  trap '@app.exit $?' HUP INT QUIT KILL TERM EXIT

  # Execution Watcher
  # https://tldp.org/LDP/Bash-Beginners-Guide/html/sect_12_02.html
  trap '{
    __BX_each_line $?
  } 2>/dev/null' DEBUG

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
    if [ -f "${BASHX_EVENTS_PATH}/ready.xsh" ]; then
      . "${BASHX_EVENTS_PATH}/ready.xsh"
    fi

    # If function (Action) exists
    if @function.exists "${BX_ACTION_PREFIX}.${BX_ACTION}" ; then
      # On Start
      if [ -f "${BASHX_EVENTS_PATH}/start.xsh" ]; then
        . "${BASHX_EVENTS_PATH}/start.xsh"
      fi

      # Exec
      ${BX_ACTION_PREFIX}.${BX_ACTION} "$@"
      r=$?
    else
      # Invalid Action
      if [ -f "${BASHX_EVENTS_PATH}/invalid-action.xsh" ]; then
        . "${BASHX_EVENTS_PATH}/invalid-action.xsh"
      else
        local _sr="$(@style default color:red)"
        @app.error "Action '$(@style color:green)${BX_ACTION}${_sr}' not found. See '$(@style bold)help${_sr}' for help."
      fi
    fi
  fi

  # Return result code
  @app.exit $r
} #> >(__BX_on_stdout) 2> >(__BX_on_stderr) 3> >(__BX_on_stdinfo)
