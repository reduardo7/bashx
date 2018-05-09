## timeout cmd
## Execute command after specific time.
##
## Params:
##   timeout: {Integer} Timeout for count down.
##   cmd:     {String} Command to execute on count down finish.
##
## Return: {Integer} Return command exit code or "255" on user cancel.

local timeout_num=$1
local cmd_to_execute="$2"

@is-number "${timeout_num}" || @throw-invalid-param "$0" timeout_num
[ -z "${cmd_to_execute}" ] && @throw-invalid-param "$0" cmd_to_execute

@print

local COUNT=${timeout_num}
local rta=0
local r
local i

while [[ ${COUNT} -gt 0 ]] && [[ ${rta} -eq 0 ]] ; do
  @print-back "Count down [${COUNT}]... Press [C] or [ESC] to cancel..."
  read -n 1 -s -t 1 -p '' i
  r=$?
  if [ "${i}" == 'c' ] || [ "${i}" == 'C' ] || [ "${i}" == "${KEY_ESC}" ]; then
    rta=1
  else
    # 142 == No user input
    if [ "${r}" == '142' ]; then
      let COUNT=COUNT-1
    fi
  fi
done

@print-back # Remove last line

if [[ ${COUNT} -eq 0 ]]; then
  @print-back
  eval "${cmd_to_execute}"
  return $?
else
  # Canceled
  @print-back '   Cancel by user!'
  @print
  return 255
fi
