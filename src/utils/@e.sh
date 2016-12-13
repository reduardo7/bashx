# Print at screen.
#
# *: {String} Text to print.
# Out: {String} Text.

local str="$@"
local reg='s/\t/    /g'

# \t -> \s*4
if $OS_IS_MAC; then
  str="$(perl -C -Mutf8 -pe "${reg}" <<< "${str}")"
else
  str=$(sed "$reg" <<< "${str}")
fi

echo -e "$(@style default)${ECHO_CHAR} ${str}" >&2

# Style reset for next command
@style reset >&2
