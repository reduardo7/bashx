## *
## Add action to execute on.exit callback.
##
## Params:
##   *: Command to execute on APP exit.

local cmd="$@"

if [ ! -z "${cmd}" ]; then
  BX_ON_EXIT="${BX_ON_EXIT} ; ( ${cmd} )"
fi
