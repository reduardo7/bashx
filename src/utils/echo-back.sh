## lines *
## Re-print last line.
##
## lines: {Integer} (Default: 1) Lines to meve back. If is not a number, used as text.
## *:     {String} Text to print.
## Out:   {String} Text.

local n=1
local text="$@"

if [ $# -gt 1 ]; then
  if @is-number "$1" ; then
    n=$1
    text="${@:2}"
  fi
fi

local bl="\033[${n}A"
echo -e "${bl}$(@style default)${ECHO_CHAR} ${text}$(@style system)" >&3 # Clear line
@str-repeat 80 ' ' >&3
