## *
## Pause.
##
## Params:
##   *: {String} Message.
##      Optional.

local m="$@"

if [ -z "$m" ]; then
  read -s -n 1 >&3
else
  @log
  read -s -n 1 -p "$(@style)${BASHX_APP_PRINT_PREFIX} ${m}$(@style system)" >&3
  @log
fi
