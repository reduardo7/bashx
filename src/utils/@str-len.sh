# String length.
#
# *: {String} Text.
# Out: {Integer} String length.

local str="$(@remove-format "$@")"
local l=${#str}
echo $l
