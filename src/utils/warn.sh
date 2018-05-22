## *
## Print warning at screen.
##
## Params:
##   *: {String} Text to print.

local str="$*"

@print "${str}" 3>&2
