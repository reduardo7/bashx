# String length.
#
# *: {String} Text.
# Out: {Integer} String length.

local str="$(@remove_format "$@")"
local l=${#str}
echo $l
