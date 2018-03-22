## *
## Print warning at screen.
##
## *: {String} Text to print.

local str="$*"

@print "${str}$(@style reset)" 3>&2
