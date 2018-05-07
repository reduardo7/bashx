## count str
## Repeat string.
##
## Params:
##   count: {Integer} Number of repetitions.
##   str:   {String} String to repeat.
##
## Out: {String} Repeated string.

local repeats_count=$1
local str_repeat="$2"
local str=''

while [[ ${repeats_count} -gt 0 ]]; do
  str="${str}${str_repeat}"
  let repeats_count=$repeats_count-1
done

echo "${str}"
