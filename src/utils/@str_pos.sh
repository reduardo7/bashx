# String position.
#
# 1: {String} String where search.
# 2: {String} String to search.
# 3: {Boolean} (Default: TRUE) TRUE for case sensitive.
# Out: {Integer|NULL} String position or NULL if not found.
# Return: $TRUE on fonud, $FALSE on not found.
if [ $# -lt 3 ] || [ $3 = $TRUE ]; then
  # Case sensitive
  local p="-bo"
else
  # Case insensitive
  local p="-boi"
fi
local r=`echo "$1" | grep $p "$2" | sed 's/:.*$//'`
echo $r
if [ -z "$r" ] ; then
  # No found
  return $FALSE
else
  # Found
  return $TRUE
fi
