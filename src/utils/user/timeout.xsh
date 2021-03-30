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

@isNumber "${timeout}" || @throw.invalidParam timeout
[ -z "${cmd}" ] && @throw.invalidParam cmd

@log

local count=${timeout}
local rta=0
local r
local i

if ${BX_TTY}; then
  while [[ ${count} -gt 0 ]] && [[ ${rta} -eq 0 ]] ; do
    @log.rewrite "${message} [${count}]... Press [C] or [ESC] to cancel..."
    read -n 1 -s -t 1 -p '' i
    r=$?
    if [ "${i}" == 'c' ] || [ "${i}" == 'C' ] || [ "${i}" == "${BX_KEY_ESC}" ]; then
      rta=1
    else
      # 142 == No user input
      if [ "${r}" == '142' ]; then
        count=$((count - 1))
      fi
    fi
  done

  @log.rewrite # Remove last line
else
  @log.warn "Not at TTY! timeout cancelled: [${message}] {${cmd}}"
  return 254
fi

if [[ ${count} -eq 0 ]]; then
  @log.rewrite
  eval "${cmd}"
  return $?
else
  # Canceled
  @log.rewrite '   Cancel by user!'
  @log
  return 255
fi

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
