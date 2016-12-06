# Replace string.
#
# 1: {String} String where replace.
# 2: {String} Search string (REG EXP).
# 3: {String} Replace.
# 4: {Boolean} (Default: 1) 1 to ignore case.
# Out: {String} Result string.
local options="g"
if [ $# -lt 4 ] || [ "$4" -ne $TRUE ]; then
  if $OS_IS_MAC; then
    options="${options}I"
  else
    options="${options}i"
  fi
fi
echo "$1" | sed "s/$2/$3/$options"
