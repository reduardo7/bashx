## *
## Pause.
##
## Params:
##   *: {String} Message.
##      Optional.

local m="$*"

if [ -z "$m" ]; then
  read -s -n 1 >&3
else
  @print
  read -s -n 1 -p "$(@style default)${APP_PRINT_PREFIX} ${m}$(@style system)" >&3
  @print
fi
