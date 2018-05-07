## *
## Print warning at screen.
##
## Params:
##   *: {String} Text to print.

local str="$*"

@print "${str}$(@style reset)" 3>&2
