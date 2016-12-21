# Print at screen.
#
# *: {String} Text to print.
# Out: {String} Text.

local str="$@"

# \t -> \s*4
echo -e "$(@style default)${ECHO_CHAR} $(@str-replace "${str}" '\t' '    ')" >&2

# Style reset for next command
@style reset >&2
