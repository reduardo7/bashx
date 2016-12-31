# Replace string.
#
# 1: {String} String where replace.
# 2: {String} Search string (REG EXP).
# 3: {String} Replace.
# 4: {Boolean} (Default: TRUE) TRUE to ignore case.
# Out: {String} Result string.

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
