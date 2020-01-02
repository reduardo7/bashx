## command [interval [timeout [message [debug]]]]
## Wait for command until returns 0.
##
## Params:
##   command:  {String} Command to execute.
##   interval: {Number} Interval in seconds.
##             Optional. Default: 1.
##   timeout:  {Integer} Timeout. 0 to disable timeout.
##             Optional. Default: 0.
##   message:  {String} A message is printed while waiting. "false" string to disable output.
##             Optional. Default: "Waiting for {${command}}".
##   debug:    {Boolean} Show {command} output?
##             Optional. Default: false.
##
## Return: 0 if command finish with 0, 1 on timeout.

local command="$1"
local interval=${2:-1}
local timeout=${3:-0}
local message="${4:-"Waiting for {${command}}"}"
local debug=${5:-false}

local p='...'
local count=0

if [ "${message}" == "false" ]; then
  message=''
fi

if ! ${debug}; then
  command="( ${command} ) >/dev/null 2>&1"
fi

while ! eval "${command}" ; do
  if [ -n "${message}" ]; then
    if [[ ${timeout} -gt 1 ]]; then
      if [[ ${timeout} -lt ${count} ]]; then
        # Time out!
        return 1
      else
        count=$((count+1))
      fi
    fi

    @log.rewrite "${message}${p}"

    if [ "${p}" == '...' ]; then
      p='.'
    else
      p="${p}."
    fi
  fi

  sleep ${interval}
done

# Exists
return 0
