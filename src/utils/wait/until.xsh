## command [interval [timeout [message [debug]]]]
## Wait for command until returns 0.
##
## Params:
##   command:  {String} Command to execute.
##   interval: {Number} Run command interval in seconds.
##             Optional. Default: 1.
##   timeout:  {Integer} Timeout. 0 to disable timeout.
##             Optional. Default: 0.
##   message:  {String} A message is printed while waiting. "false" string to disable output.
##             Optional. Default: "Waiting for {${command}}".
##   retries:  {Integer} Retries limit. 0 to disable retries limit.
##             Optional. Default: 0.
##   debug:    {Boolean} Show {command} output?
##             Optional. Default: false.
##
## Return:
##   0: command finish with exit code 0.
##   1: retries limit reached.
##   2: timeout reached.

local command="$1"
local interval=${2:-1}
local timeout=${3:-0}
local message="${4:-"Waiting for {${command}}"}"
local debug=${5:-false}

[ ! -z "${command}" ] || @throw.invalidParam command
command="( set -ex ; ${command} )"

local out_log="${BASHX_APP_TMP_PATH}/__bx_waituntil_out.out"
local retries_count=0

local working_file="${BASHX_APP_TMP_PATH}/__bx_waituntil_working.${BASH_SUBSHELL}.flag"
trap "[ ! -f '${working_file}' ] || rm -f '${working_file}' 2>/dev/null" HUP INT QUIT KILL TERM EXIT
touch "${working_file}"

if [[ "${message}" == "false" ]]; then
  message=''
fi

if ! ${debug}; then
  echo "$ ${command}" >"${out_log}"
  echo >>"${out_log}"
  # command="${command} 2>>'${out_log}'"
  command="${command} >/dev/null 2>/dev/null 3>/dev/null"
fi

(
  timeout_count=0
  p='...'

  while [ -f "${working_file}" ] ; do
    if [[ -n "${message}" ]]; then
      if [[ ${timeout} -gt 1 ]]; then
        if [[ ${timeout} -lt ${timeout_count} ]]; then
          # Time out!
          [ ! -f "${working_file}" ] || rm -f "${working_file}" 2>/dev/null
          @log
          @log.warn "Command execution timeout (${timeout_count}s)"
          exit 1
        else
          timeout_count=$((timeout_count+1))
        fi
      fi

      @log.rewrite "${message}${p}"

      if [[ "${p}" == '...' ]]; then
        p='.'
      else
        p="${p}."
      fi
    fi

    sleep 1
  done
) &

while [ -f "${working_file}" ] ; do
  if eval "${command}"; then
    # command finish with exit code 0
    check_fail=false
    [ ! -f "${working_file}" ] || rm -f "${working_file}" 2>/dev/null
    sleep 1
    return 0
  else
    if [[ ${retries} -gt 1 ]]; then
      if [[ ${retries} -lt ${retries_count} ]]; then
        # retries limit reached
        [ ! -f "${working_file}" ] || rm -f "${working_file}" 2>/dev/null
        @log
        @log.warn "Command execution retries limit (${retries_count} retries)"
        sleep 1
        return 1
      else
        retries_count=$((retries_count+1))
      fi
    fi

    sleep ${interval}
  fi
done

# timeout reached
[ ! -f "${working_file}" ] || rm -f "${working_file}" 2>/dev/null
sleep 1
return 2

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
