# Pause.
#
# *: {String} (Optional) Message.
local m="$@"

if [ -z "$m" ]; then
  read -s -n 1
else
  @e
  read -s -n 1 -p "`@style default`${ECHO_CHAR} ${m}`@style system`" 1>&2
  @e
fi
