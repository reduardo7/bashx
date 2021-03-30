## src search [case_sensitive]
## String position.
##
## Params:
##   src:            {String} String where search.
##   search:         {String} String to search.
##   case_sensitive: {Boolean} True for case sensitive.
##                   Optional. Default: true.
##
## Out: {Integer|NULL} String position or NULL if not found.
## Return: 0 on fonud, 1 on not found.

local src="$1"
local search="$2"
local case_sensitive=${3:-true}

if [ -z "${src}" ] || [ -z "${search}" ]; then
  # Empty variable
  return 1
fi

if ! ${case_sensitive}; then
  # Case insensitive
  src="$(@str.toLower "${src}")"
  search="$(@str.toLower "${search}")"
fi

local tmp="${src%${search}*}"
local index=${#tmp}

if [[ ${index} -eq ${#src} ]]; then
  # Not found
  return 1
else
  # Found
  echo ${index}
  return 0
fi

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
