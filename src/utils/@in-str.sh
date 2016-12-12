# String contains substring?
#
# 1: {String} String where search.
# 2: {String} Substring to search.
# 3: {Boolean} (Default: TRUE) TRUE for case sensitive.
# Return: 0 if contains substring, 1 if not contains substring.

local src_str="$1"
local search="$2"
local case_sensitive=$3

[ -z "${case_sensitive}" ] && case_sensitive=true

@str-pos "${src_str}" "${search}" ${case_sensitive} >$DEV_NULL 2>&1
return $?
