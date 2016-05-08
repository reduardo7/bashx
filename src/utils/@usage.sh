# Print basic usage.
# Using "ACTIONS." at begin of function name to set as argument method.
# Put "#" before function to write extra help text.
# Special chars: \n, \t (4 spaces)
#
# 1: {String} (Default: Current executed file) File to render usage.
# Out: {String} Usage text.

local src
local lp="    > "
local lpl=${#lp}

if [ $# -gt 0 ] && [ ! -z "$1" ]; then
  src="$1"
  if [ ! -f "${src}" ] ; then
    src="`@script_full_path`"
  fi
else
  src="`@script_full_path`"
fi

local srcName="`@script_file_name`"

# Default style
@style default

# Action file
local cmd="`@file_name "${src}" $TRUE`"
local info="`grep "^#\{2\}" "${src}" | sed "s/^#\{2\}\s\?/$(@style default)/g" | sed "s/^/$(@style default)${lp}/g"`"
if [ ! -z "$info" ]; then
  info="|||${info}"
fi
@e "  `@style color:red`${srcName}`@style color:green` ${cmd}`@style default`${info}" | sed "s/|||.*\s\+>\s/ /g"
@e
