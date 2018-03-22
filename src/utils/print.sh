## *
## Print at screen.
##
## *: {String} Text to print.

local str="$*"

# \t -> \s*4
echo -e "$(@style default)${ECHO_CHAR} $(@str-replace "${str}" '\t' '    ')$(@style reset)" >&3
