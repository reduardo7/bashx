# String position.
#
# 1: {String} String where search.
# 2: {String} String to search.
# 3: {Boolean} (Default: TRUE) TRUE for case sensitive.
# Out: {Integer|NULL} String position or NULL if not found.
# Return: 0 on fonud, 1 on not found.

local src_str="$1"
local search="$2"
local case_sensitive=$3

[ -z "${case_sensitive}" ] && case_sensitive=true

local p='-bo'

if ! ${case_sensitive}; then
  # Case insensitive
  p="${p}i"
fi

local r=$(echo "${src_str}" | grep $p "${search}" | sed 's/:.*$//')
echo $r

if [ -z "$r" ]; then
  # No found
  return 1
else
  # Found
  return 0
fi
