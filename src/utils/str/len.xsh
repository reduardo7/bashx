## *
## String length.
##
## Params:
##   *: {String} Text.
##
## Out: {Integer} String length.

local str="$(@style.clean "$@")"
echo ${#str}

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
