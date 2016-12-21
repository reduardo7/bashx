# Pause.
#
# *: {String} (Optional) Message.

local m="$@"

if [ -z "$m" ]; then
  read -s -n 1
else
  @print
  read -s -n 1 -p "$(@style default)${ECHO_CHAR} ${m}$(@style system)" 1>&2
  @print
fi
