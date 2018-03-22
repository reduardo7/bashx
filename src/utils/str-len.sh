## *
## String length.
##
## *:   {String} Text.
## Out: {Integer} String length.

local str="$(@remove-format "$@")"
echo ${#str}
