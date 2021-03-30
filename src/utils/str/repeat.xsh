## count str
## Repeat string.
##
## Params:
##   count: {Integer} Number of repetitions.
##   str:   {String} String to repeat.
##
## Out: {String} Repeated string.

local count=$1
local str="$2"

if [ ! -z "${count}" ] && [[ ${count} -gt 0 ]] && [ ! -z "${str}" ]; then
  local result=''

  while [[ ${count} -gt 0 ]]; do
    result="${result}${str}"
    count=$((count - 1))
  done

  echo "${result}"
fi

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
