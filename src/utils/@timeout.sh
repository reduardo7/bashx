# Time out.
#
# 1: {Integer} Time out for count down.
# 2: {String} Command to execute on count down finish.
# Return: {Integer} Return command exit code or "255" on user cancel.



if [ $# -ne 2 ] || ! @is-number "$1" || [ -z "$2" ]; then
  @error 'Invalid call "@timeout"' 70
fi

@e
local COUNT=$1
local rta=0

while [ ${COUNT} -gt 0 ] && [ ${rta} -eq 0 ] ; do
  @echo-back "Count down [${COUNT}]... Press [C] or [ESC] to cancel..."
  read -n 1 -t 1 -p '' i
  local r=$?
  if [ "${i}" == 'c' ] || [ "${i}" == 'C' ] || [ "${i}" == "$KEY_ESC" ]; then
    rta=1
  else
    # 142 == No user input
    if [ "${r}" == '142' ]; then
      let COUNT=COUNT-1
    fi
  fi
done

@echo-back # Remove last line

if [ ${COUNT} -eq 0 ]; then
  @echo-back
  $2
  return $?
else
  # Canceled
  @echo-back '   Cancel by user!'
  @e
  return 255
fi
