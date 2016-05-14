# String contains substring?
#
# 1: {String} String where search.
# 2: {String} Substring to search.
# 3: {Boolean} (Default: TRUE) TRUE for case sensitive.
# Return: $TRUE if contains substring, $FALSE if not contains substring.
if [ $# -lt 3 ]; then
  @str-pos "$1" "$2" >$DEV_NULL 2>&1
  local r=$?
else
  @str-pos "$1" "$2" "$3" >$DEV_NULL 2>&1
  local r=$?
fi
return $r
