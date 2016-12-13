# Print at screen.
#
# *: {String} Text to print.
# Out: {String} Text.

local str="$@"

# \t -> \s*4
str=$(echo "${str}" | sed 's/\t/    /g')

echo -e "$(@style default)${ECHO_CHAR} ${str}" >&2

# Style reset for next command
@style reset >&2
