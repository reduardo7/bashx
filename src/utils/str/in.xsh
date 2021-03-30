## src search [case_sensitive]
## String contains substring?
##
## Params:
##   src:            {String} String where search.
##   search:         {String} Substring to search.
##   case_sensitive: {Boolean} TRUE for case sensitive.
##                   Optional. Default: true.
##
## Return: 0 if contains substring, 1 if not contains substring.

local src="$1"
local search="$2"
local case_sensitive=${3:-true}

if [ ! -z "${src}" ] && [ ! -z "${search}" ]; then
  @str.pos "${src}" "${search}" ${case_sensitive} >/dev/null 2>&1
  return $?
fi

return 1

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
