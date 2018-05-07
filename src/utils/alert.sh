## *
## Show red alert message.
##
## Params:
##   *: {String} Message.

local str="$*"

@warn "$(@style color:red) ${str}"
