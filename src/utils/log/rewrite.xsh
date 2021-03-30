## text [lines]
## Go back {lines} lines and print the text.
##
## Params:
##   text:  {String} Text to print.
##   lines: {Integer} Lines to meve back.
##          Optional. Default: 1.
##   width: {Integer} Line width.
##          Optional. Default: ${BASHX_APP_WIDTH}.


local text="$1"
local lines=${2}
local width=${3:-${BASHX_APP_WIDTH}}

if [ -z "${lines}" ]; then
  lines=1
elif ! @isNumber "${lines}" ; then
  lines=1
fi

if [[ ${lines} -gt 0 ]]; then
  local bl="\r\033[${lines}A"
  echo -e "${bl}$(@style)${BASHX_APP_PRINT_PREFIX} ${text}$(@style system)\r" >&3 # Clear line
  @str.repeat ${width} ' ' >&3
fi

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
