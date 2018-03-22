## src search [case_sens]
## String position.
##
## src:       {String} String where search.
## search:    {String} String to search.
## case_sens: {Boolean} (Default: TRUE) TRUE for case sensitive.
## Out:       {Integer|NULL} String position or NULL if not found.
## Return:    0 on fonud, 1 on not found.

local src_str="$1"
local search="$2"
local case_sensitive=$3

if [ -z "${src_str}" ] || [ -z "${search}" ]; then
  # Empty variable
  return 1
fi

[ -z "${case_sensitive}" ] && case_sensitive=true

if ! ${case_sensitive}; then
  # Case insensitive
  src_str="$(@str-to-lower "${src_str}")"
  search="$(@str-to-lower "${search}")"
fi

local tmp="${src_str%${search}*}"
local index=${#tmp}

if [[ ${index} -eq ${#src_str} ]]; then
  # Not found
  return 1
else
  # Found
  echo ${index}
  return 0
fi
