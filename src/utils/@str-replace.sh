# Replace string.
#
# 1: {String} String where replace.
# 2: {String} Search string (REG EXP).
# 3: {String} Replace.
# 4: {Boolean} (Default: 1) 1 to ignore case.
# Out: {String} Result string.

local options="g"
if [ $# -lt 4 ] || [ "$4" -ne $TRUE ]; then
  options="${options}i"
fi

local reg="s/$2/$3/$options"

if $OS_IS_MAC; then
  perl -C -Mutf8 -pe "$reg" <<< "$1"
else
  sed "$reg" <<< "$1"
fi
