## src search [case_sens]
## String contains substring?
##
## Params:
##   src:       {String} String where search.
##   search:    {String} Substring to search.
##   case_sens: {Boolean} TRUE for case sensitive.
##              Optional. Default: true.
##
## Return: 0 if contains substring, 1 if not contains substring.

local src_str="$1"
local search="$2"
local case_sensitive=${3:-true}

@str-pos "${src_str}" "${search}" ${case_sensitive} >/dev/null 2>&1
return $?
