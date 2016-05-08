# Print at screen.
#
# *: {String} Text to print.
# Out: {String} Text.

local c=`@style default`
echo -e "$@" | sed "s/^/${c}${ECHO_CHAR} /" | sed "s/\t/    /g"

# Style reset for next command
@style reset
