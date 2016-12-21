# Show red alert message.
#
# *: {String} Message.

local str="$*"

@warn "$(@style color:red) ${str}"
