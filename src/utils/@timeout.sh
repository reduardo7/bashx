# Time out.
#
# 1: {Integer} Timeout for count down.
# 2: {String} Command to execute on count down finish.
# Return: {Integer} Return command exit code or "255" on user cancel.

local timeout_num=$1
local cmd_to_execute="$2"

if ! @is-number "${timeout_num}" || [ -z "${cmd_to_execute}" ]; then
  @error 'Invalid call "@timeout"' 70
fi

@print

local COUNT=${timeout_num}
local rta=0
local r
local i

while [[ ${COUNT} -gt 0 ]] && [[ ${rta} -eq 0 ]] ; do
  @echo-back "Count down [${COUNT}]... Press [C] or [ESC] to cancel..."
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

@echo-back # Remove last line

if [[ ${COUNT} -eq 0 ]]; then
  @echo-back
  eval "${cmd_to_execute}"
  return $?
else
  # Canceled
  @echo-back '   Cancel by user!'
  @print
  return 255
fi
