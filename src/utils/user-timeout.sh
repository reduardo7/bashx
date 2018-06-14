## timeout cmd [message]
## Execute command after specific time.
##
## Params:
##   timeout: {Integer} Timeout for count down.
##   cmd:     {String} Command to execute on count down finish.
##   message: {String} Message.
##            Optional. Default: "Count down".
##
## Return: {Integer} Return command exit code or "255" on user cancel.

local timeout=$1
local cmd="$2"
local message="${3:-Count down}"

@is-number "${timeout}" || @throw-invalid-param "${FUNCNAME[0]}" timeout
[ -z "${cmd}" ] && @throw-invalid-param "${FUNCNAME[0]}" cmd

@print

local count=${timeout}
local rta=0
local r
local i

while [[ ${count} -gt 0 ]] && [[ ${rta} -eq 0 ]] ; do
  @print-back "${message} [${count}]... Press [C] or [ESC] to cancel..."
  read -n 1 -s -t 1 -p '' i
  r=$?
  if [ "${i}" == 'c' ] || [ "${i}" == 'C' ] || [ "${i}" == "${BASHX_KEY_ESC}" ]; then
    rta=1
  else
    # 142 == No user input
    if [ "${r}" == '142' ]; then
      count=$((count - 1))
    fi
  fi
done

@print-back # Remove last line

if [[ ${count} -eq 0 ]]; then
  @print-back
  eval "${cmd}"
  return $?
else
  # Canceled
  @print-back '   Cancel by user!'
  @print
  return 255
fi
