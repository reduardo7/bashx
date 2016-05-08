# Pause.
#
# *: {String} (Optional) Message.

if [ $# -le 0 ]; then
  local m="Press any key to continue..."
else
  local m="$@"
fi
@e
read -n 1 -p "`@style default`${ECHO_CHAR} ${m}"
@e
@e
