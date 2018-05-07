## src search replace [ignore_case]
## Replace string.
##
## Params:
##   src:         {String} String where replace.
##   search:      {String} Search string (REG EXP).
##   replace:     {String} Replace.
##   ignore_case: {Boolean} (Default: true) True to ignore case.
## Out: {String} Result string.

local src_str="$1"
local search="$2"
local replace="$3"
local ignore_case=$4

if [ -z "${src_str}" ]; then
  echo ''
elif [ -z "${search}" ]; then
  echo "${src_str}"
else
  [ -z "${ignore_case}" ] && ignore_case=true

  local options='g'
  ${ignore_case} && options="${options}i"

  perl -C -Mutf8 -pe "s/${search}/${replace}/${options}" <<<"${src_str}"
fi
