## text [lines]
## Go back {lines} lines and print the text.
##
## Params:
##   text:  {String} Text to print.
##   lines: {Integer} Lines to meve back. If is not a number, used as text.
##          Optional. Default: 1.
##   width: {Integer} Line width.
##          Optional. Default: ${APP_WIDBASHX_APP_WIDTHTH}.


local text="$1"
local lines=${2:-1}
local width=${3:-${BASHX_APP_WIDTH}}

if ! @isNumber "${lines}" ; then
  lines=1
fi

if [[ ${lines} -gt 0 ]]; then
  local bl="\033[${lines}A"
  echo -e "${bl}$(@style)${BASHX_APP_PRINT_PREFIX} ${text}$(@style system)" >&3 # Clear line
  @str.repeat ${width} ' ' >&3
fi