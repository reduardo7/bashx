## src search replace [ignore_case]
## Replace string.
##
## Params:
##   src:         {String} String where replace.
##   search:      {String} Search string (REG EXP).
##   replace:     {String} Replace.
##   ignore_case: {Boolean}True to ignore case.
##                Optional. Default: true.
##
## Out: {String} Result string.

local src="$1"
local search="$2"
local replace="$3"
local ignore_case=${4:-true}

if [ -z "${src}" ]; then
  echo ''
elif [ -z "${search}" ]; then
  echo "${src}"
else
  local options='g'
  ${ignore_case} && options="${options}i"

  perl -C -Mutf8 -pe "s/${search}/${replace}/${options}" <<<"${src}"
fi
