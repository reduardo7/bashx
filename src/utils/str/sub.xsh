## src limit [offset]
## Sub string.
##
## Params:
##   src:    {String} String to cut.
##   limit:  {Integer} Limit.
##   offset: {Integer} Offset.
##           Optional. Default: 0.
##
## Out: {String} Result string

local src="$1"
local limit=$2
local offset=$3

if [ -z "${offset}" ] || [[ ${offset} -eq 0 ]] || ! @isNumber "${offset}"; then
  echo "${src:0:${limit}}"
else
  echo "${src:${offset}:${limit}}"
fi

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
