## *
## String length.
##
## Params:
##   *: {String} Text.
##
## Out: {Integer} String length.

local str="$(@style.clean "$@")"
echo ${#str}
